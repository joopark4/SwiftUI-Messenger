//
//  ChatRoomMediaViewPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatMessagesUI
import ChatModuleMessengerChatRoomUI

enum ChatRoomMediaViewType {
    case NORMAL
    case EDIT
}

struct ChatRoomMediaViewPage: View {
    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) var presentationMode
    @State var toolBarShowAction: Bool = true
    @State var bookMarkAction: Bool = false
    @State var isMultiMedia: Bool = false

    // button action
    @State var downloadAction: Bool = false
    @State var forwardAction: Bool = false
    @State var deleteAction: Bool = false
    @State var infoAction: Bool = false
    @State var detailInfoAction: Bool = false

    private var type: ChatRoomMediaViewType = .EDIT
    @State var isChecked: Bool = false

    // forwarding
    @State var forwardingModalAction: Bool = false
    @State var forwardingFullAction: Bool = false

    // progress 테스트용
    /*
    @State var progress: CGFloat = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
     */

    init(type: ChatRoomMediaViewType) {
        self.type = type
    }

    var body: some View {

        ZStack {
            contentView

            VStack(spacing: 0) {
                if toolBarShowAction {
                    ChatRoomMediaViewTopBar

                    if self.type == .EDIT {
                        HStack {
                            Spacer()
                            checkeButton
                                .padding(.top, 16)
                                .padding(.trailing, 17)
                        }
                    }
                }
                Spacer()
            }

            VStack(spacing: 0) {
                Spacer()
                if toolBarShowAction {
                    if self.type == .NORMAL && isMultiMedia {
                        multiMediaView
                    }
                    ChatRoomMediaViewBottomBar
                }
            }

            //  MediaProgress 테스트
            // 사진/동영상 데이터에 따라 분기처리 필요
//            MediaProgressBarSection(icon: "photo", title: "225KB", subTitle: "눌러서 보기")
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                .background(tm.theme.backgroundInfoSelect)
//
//            MediaProgressBarSection(icon: "xmark", progress: progress, title: "203.00/255KB")
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                .background(tm.theme.backgroundInfoSelect)
//            
//            MediaProgressBarSection(icon: "checkmark", title: "225.00/255KB")
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                .background(tm.theme.backgroundInfoSelect)
//            
//            MediaProgressBarSection(icon: "play.fill", title: "0:25")
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                .background(tm.theme.backgroundInfoSelect)

            if forwardingModalAction {
                forwardingView
            }

        }
        .fullScreenCover(isPresented: $forwardingFullAction) {
            ContentForwardingSelectionPage()
        }
        .ignoresSafeArea(.container)
        // progress 테스트용
        /*
        .onReceive(timer) { _ in
            withAnimation {
                if progress == 1 {
                    progress = 0
                } else {
                    progress += 0.2
                }
            }
        }
        */
    }

    private var forwardingView: some View {
        VStack {
            Spacer()

            ContentForwardingSelectionBottomSection(forwardingModalAction: $forwardingModalAction,
                                                    forwardingFullAction: $forwardingFullAction)
        }
        .background(tm.theme.separatorColor)
    }

    private var contentView: some View {
        ZStack {
            // 스와이프 동작이 필요하므로 binding시 tabview로 변경 필요
//            TabView {
//                Image("tempImage")
//                    .resizable()
//
//                Image("tempImage")
//                    .resizable()
//            }
//            .tabViewStyle(.page)

            Image("tempImage")
                .resizable()
        }
        .onTapGesture {
            toolBarShowAction.toggle()
        }
    }

    private var multiMediaView: some View {
        VStack(spacing: 0) {
            ChatRoomImageViewNavigationSection()
            ChatRoomImageIndexSection(count: 7, index: 1)
        }
        .background(tm.theme.befamilyBackgroundSemiBlack)
    }

    // 현재는 미디어 상세보기에서만 쓰여서 여기에 구현
    // 추구 같은 UI 사용될경우 분리 필요
    private var ChatRoomMediaViewBottomBar: some View {
        VStack {
            if self.type == .NORMAL {
                HStack {
                    download

                    Spacer()

                    forwarding

                    Spacer()

                    delete

                    Spacer()

                    info

                }
                .padding(.horizontal, 24)
                .padding(.top, 8)

                Spacer()

            } else if self.type == .EDIT && isMultiMedia {
                VStack {
                    HStack {
                        Spacer()
                        ChatRoomImageIndexSection(count: 7, index: 1)
                            .padding(.top, 8)
                        Spacer()
                    }

                    Spacer()
                }
            }
        }
        .frame(height: self.type == .NORMAL ? 78 : 69)
        .background(tm.theme.befamilyBackgroundSemiBlack)
    }

    private var download: some View {
        Button {
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
                .tintColor = UIColor(tm.theme.labelColorPrimary)

            downloadAction.toggle()
        } label: {
            Image(systemName: "square.and.arrow.down")
                .font(.system(size: 24))
                .foregroundColor(.white)
        }
        .actionSheet(isPresented: $downloadAction) {
            ActionSheet(title: Text(""), message: Text(tm.lang.localized("ChatRoom.MediaView.Save")), buttons: [
              .default(Text(tm.lang.localized("ChatRoom.MediaView.SaveAllPhotos")),
                       action: {

                        }),
              .default(Text(tm.lang.localized("ChatRoom.MediaView.SavePhoto")),
                       action: {

                        }),
              .cancel(Text(tm.lang.localized("Common.Cancel"))
                        )])
        }
    }

    private var forwarding: some View {
        Button {
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
                .tintColor = UIColor(tm.theme.labelColorPrimary)

            forwardAction.toggle()
        } label: {
            Image(systemName: "square.and.arrow.up")
                .font(.system(size: 24))
                .foregroundColor(.white)
        }
        .actionSheet(isPresented: $forwardAction) {
            ActionSheet(title: Text(""), message: Text(tm.lang.localized("ChatRoom.MediaView.Forwarding")), buttons: [
              .default(Text(tm.lang.localized("ChatRoom.MediaView.ForwardingAllPhotos")),
                       action: {
                           forwardingModalAction = true
                        }),
              .default(Text(tm.lang.localized("ChatRoom.MediaView.ForwardingPhoto")),
                       action: {
                           forwardingModalAction = true
                        }),
              .cancel(Text(tm.lang.localized("Common.Cancel"))
                        )])
        }
    }

    private var delete: some View {
        Button {
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
                .tintColor = UIColor(tm.theme.systemPurple)

            deleteAction.toggle()
        } label: {
            Image(systemName: "trash")
                .font(.system(size: 24))
                .foregroundColor(.white)
        }
        .alert(isPresented: $deleteAction) {
            Alert(title: Text(""), message: Text(tm.lang.localized("ChatRoom.MediaView.DeleteInfo")),
                  primaryButton: .default(Text(tm.lang.localized("Common.Cancel")), action: {
                // some Action
            }), secondaryButton: .destructive(Text(tm.lang.localized("ChatRoom.MediaView.Delete"))))
        }
    }

    private var info: some View {
        Button {
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
                .tintColor = UIColor(tm.theme.labelColorPrimary)

            infoAction.toggle()
        } label: {
            Image(systemName: "ellipsis")
                .font(.system(size: 24))
                .foregroundColor(.white)
        }
        .actionSheet(isPresented: $infoAction) {
            ActionSheet(title: Text(""), message: Text(tm.lang.localized("ChatRoom.MediaView.Showmore")), buttons: [
              .default(Text(tm.lang.localized("ChatRoom.MediaView.DetailInfo")),
                       action: {
                           UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
                               .tintColor = UIColor(tm.theme.systemBlue)

                           detailInfoAction.toggle()
                        }),
              .default(Text(tm.lang.localized("ChatRoom.MediaView.ShowMessage")),
                       action: {

                        }),
              .default(Text(tm.lang.localized("ChatRoom.MediaView.Reload")),
                       action: {

                        }),
              .cancel(Text(tm.lang.localized("Common.Cancel"))
                        )])
        }
        .alert(isPresented: $detailInfoAction) {
            Alert(title: Text(""), message: Text("종류 : JPG\n크기: 56.6KB\n해상도: 612 x 1440"),
                  dismissButton: .cancel(Text(tm.lang.localized("Common.Ok"))))
        }
    }

    // 현재는 미디어 상세보기에서만 쓰여서 여기에 구현
    // 추구 같은 UI 사용될경우 분리 필요
    private var ChatRoomMediaViewTopBar: some View {
        VStack {
            Spacer()

            ZStack {

                title

                HStack {
                    backArrow

                    Spacer()

                    if self.type == .NORMAL {
                        bookMark

                        squareGrid
                    }
                }
            }
        }
        .frame(height: 88)
        .background(tm.theme.befamilyBackgroundSemiBlack)
    }

    private var backArrow: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
                .frame(width: 30, height: 40)
        }
    }

    private var title: some View {
        VStack {
            Text("ChatModule")
                .font(.headline)
                .foregroundColor(.white)
            Text("2025-02-021")
                .font(.caption)
                .foregroundColor(Color(UIColor.lightGray))
        }
    }

    private var bookMark: some View {
        Button {
            bookMarkAction.toggle()
        } label: {
            let imageName = bookMarkAction ? "bookmark.fill" : "bookmark"
            Image(systemName: imageName)
                .foregroundColor(bookMarkAction ? .yellow : .white)
                .frame(width: 36, height: 36)
        }
    }

    private var squareGrid: some View {
        Button {
            self.isMultiMedia.toggle()
        } label: {
            Image(systemName: "square.grid.2x2")
                .foregroundColor(.white)
                .frame(width: 36, height: 36)
        }
    }

    @ViewBuilder
    private var checkeButton: some View {
        if self.isChecked {
            Button {
                self.isChecked.toggle()
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(tm.theme.systemPurple)
                        .mask(Circle())

                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .font(.system(size: 24))

                }
                .frame(width: 46, height: 46)
            }
        } else {
            Button {
                self.isChecked.toggle()
            } label: {
                Rectangle()
                    .foregroundColor(tm.theme.labelColorQuarternary)
                    .frame(width: 46, height: 46)
                    .mask(Circle())
            }
        }
    }
}

#if DEBUG
struct ChatRoomMediaViewPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomMediaViewPage(type: .NORMAL)
            .environmentObject(ThemeManager())
    }
}
#endif
