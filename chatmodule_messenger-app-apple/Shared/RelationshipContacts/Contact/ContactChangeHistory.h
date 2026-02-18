//
//  ContactChangeHistory.h
//  ContactsChangeHistory
//
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactChangeHistory : NSObject

+ (ContactChangeHistory *)sharedObject;

/// Contacts에서 전달된 historyToken에 대한 변경정보를 확인하고 결과값을 배열로 반환
/// @param complete 결과, 변경 데이터 배열, historyToken

- (void)checkChangedData: (nullable NSData *) data completeHandler:(void (^)(NSArray* arrData, NSData* historyTokenData))complete;

@end

NS_ASSUME_NONNULL_END
