//
//  EmoticonPagerSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerChatMessagesUI
import ChatModuleMessengerUI

struct EmoticonPagerSection: View {
    @EnvironmentObject var tm: ThemeManager

    @State private var selection = 1
    let dataModel = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    private let emoticonGroupHeight: CGFloat = 40
    var emoticonSelect: (EmoticonItemInfo) -> Void

    init(emoticonSelect: @escaping (EmoticonItemInfo) -> Void) {
        self.emoticonSelect = emoticonSelect
    }

    var body: some View {
        VStack(spacing: 0) {
            // ScrollableTabView
            Divider()
                .background(tm.theme.labelColorQuarternary)

            ScrollView(.horizontal, showsIndicators: false, content: {
                ScrollViewReader { scrollReader in
                    ScrollableTabView(activeIdx: $selection, dataSet: dataModel, emoticonGroupHeight: emoticonGroupHeight)
                        .onChange(of: selection, perform: { value in
                            withAnimation {
                                scrollReader.scrollTo(value, anchor: .center)
                            }
                        })
                }
            })
            .frame(height: emoticonGroupHeight)
            .background(tm.theme.systemBackground)

            Divider()
                .background(tm.theme.labelColorQuarternary)

            // Page View
            VStack {
                PageView(selection: $selection,
                         dataModel: dataModel, emoticonSelect: emoticonSelect)
            }
        }
    }
}

// page view
struct PageView: View {
    @EnvironmentObject var tm: ThemeManager
    @State var deleteSheetSmileMeAction: Bool = false
    @State var deletePopupSmileMeAction: Bool = false

    @Binding var selection: Int
    let dataModel: [String]
    var emoticonSelect: (EmoticonItemInfo) -> Void
    let data = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
                "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
                "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
    let columns = [ GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()) ]

    // 스마일미 만든 후 리스트 보이기위한 테스트 코드
    @State var makeSmileMeAction: Bool = false
    @State var testMakeSmileMe: Bool = false

    var body: some View {
        TabView(selection: $selection) {
            ForEach(0..<dataModel.count) { index in
                // dataModel에서 smileme로 검사해야함
                if index == 1 {
                    // smileme에서 아이템이 없을경우 EmptySection 호출
                    // 있을경우 EmoticonListSection
                    if testMakeSmileMe {
                        emoticonListSection
                    } else {
                        smileMeEmptySection
                    }
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, alignment: .center, spacing: 11) {
                            ForEach(data, id: \.self) { _ in
                                Button(action: {
                                    let emoticon = EmoticonItemInfo(id: "1", emoticonInfoId: "1",
                                                                    name: "emo1", url: "", nameThumb: "", urlThumb: "")
                                    emoticonSelect(emoticon)
                                }, label: {
                                    let emoticonItemInfo = EmoticonItemInfo(id: "1", emoticonInfoId: "1",
                                                                            name: "emo1", url: "", nameThumb: "", urlThumb: "")
                                    EmoticonItemSection(emoticonItemInfo: emoticonItemInfo)
                                })
                            }
                        }
                        .padding(.top, 5)
                        .padding(.horizontal)
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle.init(indexDisplayMode: .never))
        .background(tm.theme.systemBackground)

    }

    @ViewBuilder
    private var smileMeEmptySection: some View {

        VStack(spacing: 8) {
            HStack {
                Image("visual02")
                    .resizable()
                    .frame(width: 96, height: 96)

                Text(tm.lang.localized("SmileMe.Empty.Description"))
                    .font(tm.typo.body)
                    .foregroundColor(tm.theme.labelColorPrimary)

                Spacer()
            }
            .padding(.leading, 16)

            Button(action: {
                makeSmileMeAction.toggle()
            }, label: {
                ZStack {
                    Text(tm.lang.localized("SmileMe.Empty.MakeSmileMe"))
                        .font(tm.typo.headline)
                        .foregroundColor(tm.theme.systemBackground)
                }
                .frame(width: UIScreen.main.bounds.width - 32, height: 42)
                .background(tm.theme.systemPurple)
                .cornerRadius(8)

            })

            HStack {
                Image(systemName: "info.circle.fill")
                    .frame(width: 16, height: 13)
                    .foregroundColor(tm.theme.labelColorSecondary)

                Text(tm.lang.localized("SmileMe.Empty.Info"))
                    .font(tm.typo.caption2)
                    .foregroundColor(tm.theme.labelColorSecondary)

                Spacer()
            }
            .padding(.leading, 16)
            .frame(height: 29)

            Spacer()
        }
        .padding(.top, 8)
        .fullScreenCover(isPresented: $makeSmileMeAction) {
            testMakeSmileMe.toggle()
        } content: {
            SmileMeCameraViewPage()
        }

    }

    // 스마일미 추후에 빠질거라 따로 구현
    @ViewBuilder
    private var emoticonListSection: some View {
        let smileMedata = [0, 1, 2, 3, 4, 5, 6]

        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, alignment: .center, spacing: 11) {
                ForEach(smileMedata, id: \.self) { index in

                    if index == 0 {
                        Button(action: {
                            makeSmileMeAction.toggle()
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [2]))
                                    .foregroundColor(tm.theme.labelColorTertiary)
                                    .frame(width: 50, height: 50)

                                Image(systemName: "video.fill.badge.plus")
                                    .font(.system(size: 18))
                                    .foregroundColor(tm.theme.labelColorSecondary)
                            }
                        })

                    } else {
                        let emoticonItemInfo = EmoticonItemInfo(id: "1", emoticonInfoId: "1",
                                                                name: "emo1", url: "", nameThumb: "", urlThumb: "")
                        EmoticonItemSection(emoticonItemInfo: emoticonItemInfo)
                            .onTapGesture {
                                emoticonSelect(emoticonItemInfo)
                            }
                        .onLongPressGesture {
                            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
                                .tintColor = UIColor(tm.theme.labelColorPrimary)

                            deleteSheetSmileMeAction.toggle()
                        }
                    }
                }
            }
            .padding(.top, 5)
            .padding(.horizontal)
        }
        .actionSheet(isPresented: $deleteSheetSmileMeAction) {
            ActionSheet(title: Text(""), message: Text(tm.lang.localized("SmileMe")), buttons: [
              .default(Text(tm.lang.localized("Common.Delete")),
                       action: {
                           UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
                               .tintColor = UIColor(tm.theme.systemPurple)
                           deletePopupSmileMeAction.toggle()
                        }),
              .cancel(Text(tm.lang.localized("Common.Cancel"))
                        )])
        }
        .alert(isPresented: $deletePopupSmileMeAction) {
            Alert(title: Text(""), message: Text(tm.lang.localized("SmileMe.Delete.Ifto")),
                  primaryButton: .default(Text(tm.lang.localized("Common.Cancel")), action: {
                // some Action
            }), secondaryButton: .destructive(Text(tm.lang.localized("Common.Delete"))))
        }
        .fullScreenCover(isPresented: $makeSmileMeAction) {
            SmileMeCameraViewPage()
        }
    }
}
// Tab bar
struct ScrollableTabView: View {

    @Binding var activeIdx: Int
    private let dataSet: [String]
    private let emoticonGroupHeight: CGFloat

    init(activeIdx: Binding<Int>, dataSet: [String], emoticonGroupHeight: CGFloat) {
        self._activeIdx = activeIdx
        self.dataSet = dataSet
        self.emoticonGroupHeight = emoticonGroupHeight
    }

    var body: some View {
        LazyHStack {
            ForEach(0..<dataSet.count) { i in

                let emoticonGroupInfo = EmoticonInfo(id: "1", version: 1, name: "name",
                                                     index: Int(dataSet[i]) ?? 0, urlOn: "", urlOff: "", useYn: 1,
                                                     items: [EmoticonItemInfo(id: "1", emoticonInfoId: "1",
                                                                              name: "emo1", url: "", nameThumb: "", urlThumb: "")
                                                            ])

                EmoticonGroupItemSection(emoticonInfo: emoticonGroupInfo, checked: activeIdx == i ? true : false)
                    .modifier(ScrollableTabViewModifier(activeIdx: $activeIdx, idx: i))
                    .id(i)
            }
        }
    }
}

struct ScrollableTabViewModifier: ViewModifier {
    @Binding var activeIdx: Int
    let idx: Int

    func body(content: Content) -> some View {
        content.onTapGesture {
            self.activeIdx = self.idx
        }
    }
}

#if DEBUG
struct EmoticonPagerSection_Previews: PreviewProvider {
    static var previews: some View {
        EmoticonPagerSection(emoticonSelect: { _ in

        })
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
#endif
