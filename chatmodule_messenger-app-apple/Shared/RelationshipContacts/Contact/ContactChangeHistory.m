//
//  ContactChangeHistory.m
//  ContactsChangeHistory
//
//

#import "ContactChangeHistory.h"


@interface ContactChangeHistory ()<CNChangeHistoryEventVisitor>
@end

@implementation ContactChangeHistory

+ (ContactChangeHistory *)sharedObject{
    static ContactChangeHistory *_sharedHander;
    
    static dispatch_once_t onceQueue;
    
    dispatch_once(&onceQueue, ^{
        _sharedHander = [[ContactChangeHistory alloc] init];
    });
    
    return _sharedHander;
}

- (NSArray *)changedHistoryData: (CNContactStore *)contactStore dataToken:(NSData *)token {
    
    CNChangeHistoryFetchRequest *fetchHistory = [[CNChangeHistoryFetchRequest alloc] init];
    fetchHistory.startingToken = token;
    
    fetchHistory.additionalContactKeyDescriptors = @[CNContactIdentifierKey,
                                                     CNContactFamilyNameKey,
                                                     CNContactMiddleNameKey,
                                                     CNContactGivenNameKey,
                                                     CNContactPhoneNumbersKey];
    //
    //변경 데이터 추출
    //
    NSMutableArray *mArrayTemp = [NSMutableArray array];
    
    NSError *error = nil;
    CNFetchResult *fetchResult = [contactStore enumeratorForChangeHistoryFetchRequest:fetchHistory error:&error];
    
    //변경값
    NSEnumerator *enumerator = [fetchResult value];
    
    id object;
    while ((object = [enumerator nextObject])) {
        
        CNChangeHistoryEvent *historyEvent = (CNChangeHistoryEvent *) object;
        if ([historyEvent isKindOfClass:[CNChangeHistoryDropEverythingEvent class]]) {
            [historyEvent acceptEventVisitor:self];
        } else {
            //Apple에서는 연락처의 추가와 수정 구분이 가능하나, 안드로이드 폰에서는 수정 구분만 가능한 이슈가 있어 현재는 추가와 수정을 동일하게 U로 반환하고 있습니다.
            if ([historyEvent isKindOfClass:[CNChangeHistoryAddContactEvent class]]) {
                CNChangeHistoryAddContactEvent *addContactEvent = (CNChangeHistoryAddContactEvent *) object;
//                NSLog(@"추가 %@ - %@", addContactEvent.containerIdentifier, addContactEvent.contact);
                
                NSArray *array = [self makeDataFromContact:addContactEvent.contact operationType:@"U"];
                [mArrayTemp addObjectsFromArray:array];
                
            } else if ([historyEvent isKindOfClass:[CNChangeHistoryUpdateContactEvent class]]) {
                
                CNChangeHistoryUpdateContactEvent *updateContactEvent = (CNChangeHistoryUpdateContactEvent *) object;
//                NSLog(@"수정 - %@", updateContactEvent.contact.identifier);
                NSArray *array = [self makeDataFromContact:updateContactEvent.contact operationType:@"U"];
                [mArrayTemp addObjectsFromArray:array];
                
            } else if ([historyEvent isKindOfClass:[CNChangeHistoryDeleteContactEvent class]]) {
                CNChangeHistoryDeleteContactEvent *deleteContactEvent = (CNChangeHistoryDeleteContactEvent *) object;
//                NSLog(@"삭제 - %@", deleteContactEvent.contactIdentifier);
                [mArrayTemp addObject:@{@"contact_id": deleteContactEvent.contactIdentifier, @"type":@"D"}];
            }
        }
    }
    
    return mArrayTemp;
}



/// ployglot에 전달할 주소록 포멧 배열을 반환
/// @param contact CNContact
/// @param type NSString
- (NSArray *)makeDataFromContact: (CNContact *)contact operationType:(NSString *)type {
    NSString *nType = type;
    NSString *nName = [self getContactName:contact];
    
    if (nName.length == 0) {
        return [NSArray array];
    }
    
    NSArray *nArrayContacts = [self getContactIDAndNumbers:contact];
    if(nArrayContacts.count == 0) {
        return nArrayContacts;
    }
    
    [nArrayContacts enumerateObjectsUsingBlock:^(NSMutableDictionary* _Nonnull mDicObj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mDicObj setValue:nType forKey:@"type"];
        [mDicObj setValue:nName forKey:@"name"];
    }];
    
    return nArrayContacts;
}

//id, number 배열반환
- (NSArray *)getContactIDAndNumbers: (CNContact *)contact {
    
    NSMutableArray *mArrayNumbers = [NSMutableArray array];
    
    if(contact.phoneNumbers){
        [contact.phoneNumbers enumerateObjectsUsingBlock:^(CNLabeledValue<CNPhoneNumber *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
            NSMutableDictionary *mDicIDAndNumber = [NSMutableDictionary dictionary];
            
            //
            //전화번호(number)
            //
            
            NSString *nStrPhoneNumber = obj.value.stringValue;
//            NSString *nStrPhoneLabel = obj.label;
//            NSLog(@"PHONE NUMBER IDX: %zi, label: %@, number: %@", idx, nStrPhoneLabel, nStrPhoneNumber);
            
            //TODO: 성능체크 필요
            nStrPhoneNumber = [ nStrPhoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@"" ];
            nStrPhoneNumber = [ nStrPhoneNumber stringByReplacingOccurrencesOfString:@"/" withString:@"" ];
            nStrPhoneNumber = [ nStrPhoneNumber stringByReplacingOccurrencesOfString:@"(" withString:@"" ];
            nStrPhoneNumber = [ nStrPhoneNumber stringByReplacingOccurrencesOfString:@")" withString:@"" ];
            if(nStrPhoneNumber.length > 0) {
                //
                //연락처식별자(Identifier)
                //
                NSString *nStrIdentifier = obj.identifier;
                [mDicIDAndNumber setValue:contact.identifier forKey:@"contact_id"];
                [mDicIDAndNumber setValue:nStrIdentifier forKey:@"phone_id"];
                [mDicIDAndNumber setValue:nStrPhoneNumber forKey:@"number"];
                [mArrayNumbers addObject:mDicIDAndNumber];
            }
            
        }];//[contact.phoneNumbers enumerateObjectsUsingBlock:
    }
    
    return mArrayNumbers;
}

/// 지정한 contact의 이름과 전화번호 반환
/// @param contact CNContact
- (NSString *)getContactName: (CNContact *)contact {
    
    //
    //이름(name)
    //
    NSMutableString *nameString = [[NSMutableString alloc] init];
    NSString *nStrFamilyName   = contact.familyName;           //성
    NSString *nStrMiddleName   = contact.middleName;           //중간이름
    NSString *nStrGivenName    = contact.givenName;            //이름
    
    if(nStrFamilyName && ![nStrFamilyName isEqualToString:@""]){
        nStrFamilyName = [nStrFamilyName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [nameString appendString:nStrFamilyName];
    }
    if(nStrMiddleName && ![nStrMiddleName isEqualToString:@""]){
        [nameString appendString:nStrMiddleName];
    }
    if(nStrGivenName && ![nStrGivenName isEqualToString:@""]){
        [nameString appendString:nStrGivenName];
    }
    
    return [NSString stringWithString:nameString];
}

- (void)checkChangedData:(nullable NSData *)historyTokenData completeHandler:(void (^)(NSArray* arrData, NSData* historyTokenData))complete {

    CNContactStore *contactStore = [[CNContactStore alloc] init];
    complete([self changedHistoryData:contactStore dataToken:historyTokenData], contactStore.currentHistoryToken);
}

- (void)visitAddContactEvent:(nonnull CNChangeHistoryAddContactEvent *)event {
//    NSLog(@"최초 호출 시 visitAddContactEvent");
}

- (void)visitDeleteContactEvent:(nonnull CNChangeHistoryDeleteContactEvent *)event {
//    NSLog(@"최초 호출 시 visitDeleteContactEvent");
}

- (void)visitDropEverythingEvent:(nonnull CNChangeHistoryDropEverythingEvent *)event {
//    NSLog(@"최초 호출 시 visitDropEverythingEvent");
}

- (void)visitUpdateContactEvent:(nonnull CNChangeHistoryUpdateContactEvent *)event {
//    NSLog(@"최초 호출 시 visitUpdateContactEvent");
}

@end
