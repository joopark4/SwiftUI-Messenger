//
//  MediaImageDetailSelectionPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatMessagesUI
import Photos

struct MediaImageDetailSelectionPage: View {

    @EnvironmentObject var tm: ThemeManager
    @Environment(\.presentationMode) var presentationMode

    var photolib = PhotoLib()

    @State private var counter: Int = 0
    @State private var checked: Bool = true
    @State private var selectedImageIndex: Int = 0

    private let assets: PHFetchResult<PHAsset>?
    private var selectList: [PHAsset]?

    private let iconW: CGFloat = 28
    private let iconS: CGFloat = 24

    init(counter: Int, assets: PHFetchResult<PHAsset>?, selectList: [PHAsset]?) {
        _counter = State(initialValue: counter)
        self.assets = assets
        self.selectList = selectList
    }

    var body: some View {
        NavigationView {
            ZStack {
                pageView

                checkedCount

                VStack {
                    Spacer()
                    editToolBar
//                        .frame(width: 44, height: 44)
                }
            }
            .navigationTitle("index/total")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: UIColor(tm.theme.systemBackground),
                                tintColor: UIColor(tm.theme.labelColorPrimary))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(tm.theme.labelColorPrimary)
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("\(counter) \(tm.lang.localized(tm.lang.localized("Send")))")
                            .foregroundColor(tm.theme.labelColorSecondary)
                    }
                }
            }
        }
    }

    private var checkedCount: some View {
        ZStack {
            HStack {
                Spacer()
                VStack {
                    ZStack {
                        Circle()
                            .strokeBorder(Color.white
                                            .opacity(0.8), lineWidth: 1.5)
                            .background(Circle()
                                            .foregroundColor(checked ? Color.purple.opacity(1) : Color.gray.opacity(0.2)))
                            .frame(width: 46, height: 46)

                        if checked {
                            Text("\(counter)")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                    }

                    Spacer()
                }
            }
        }
        .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 16))
    }

    private var editToolBar: some View {
        HStack {
            // 요술봉
            Button {
                // action
            } label: {
                Image(systemName: "wand.and.rays")
            }
            .frame(width: iconW, height: iconW)
            .font(.system(size: iconS))
            .padding(.leading, 24)

            Spacer()

            // 자르기
            Button {
                // action
            } label: {
                Image(systemName: "crop")
            }
            .frame(width: iconW, height: iconW)
            .font(.system(size: iconS))

            Spacer()

            // 돌리기
            Button {
                // action
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath")
            }
            .frame(width: iconW, height: iconW)
            .font(.system(size: iconS))

            Spacer()

            // 이모티콘
            Button {
                // action
            } label: {
                Image(systemName: "face.smiling")
            }
            .frame(width: iconW, height: iconW)
            .font(.system(size: iconS))

            Spacer()

            // 펜in
            Button {
                // action
            } label: {
                Image(systemName: "scribble")
            }
            .frame(width: iconW, height: iconW)
            .font(.system(size: iconS))
            .padding(.trailing, 24)
        }
        .foregroundColor(tm.theme.labelColorPrimary)
    }
}

extension MediaImageDetailSelectionPage {

    private var pageView: some View {
        VStack {
            TabView(selection: $selectedImageIndex, content: {
                ForEach(0..<photolib.allPhotos.count-1) { idx in
                    Image(uiImage: photolib.allPhotos.object(at: idx).getImageFromPHAsset())
                        .resizable()
                        .scaledToFit()
                }
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

#if DEBUG
struct MediaImageDetailSelectionPage_Previews: PreviewProvider {
    static var previews: some View {
        MediaImageDetailSelectionPage(counter: 4, assets: nil, selectList: nil)
            .environmentObject(ThemeManager())
    }
}
#endif
