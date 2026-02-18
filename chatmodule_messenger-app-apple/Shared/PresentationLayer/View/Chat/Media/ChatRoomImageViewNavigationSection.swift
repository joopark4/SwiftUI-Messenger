//
//  ChatRoomImageViewNavigationSection.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI
import ChatModuleMessengerUI
import ChatModuleMessengerChatMessagesUI

struct ChatRoomImageViewNavigationSection: View {
    @EnvironmentObject var tm: ThemeManager

    @State var currentIndex = 0
    @State var offset: CGPoint = .zero
    private let imageList = [0, 1, 2, 3, 4, 5]

    var body: some View {
        VStack {
            HorizontalFixedScrollView(offset: $offset, showIndicators: false, axis: .horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(imageList, id: \.self) { idx in
                        ChatRoomImageViewNavigationItemSection()
                            .overlay(RoundedRectangle(cornerRadius: 2)
                                        .stroke(idx == currentIndex ? tm.theme.bubbleBgMine01 : Color.clear, lineWidth: 2)
                            )
                    }
                }
                .padding(.horizontal, UIScreen.main.bounds.width/2)
            }
        }
        .onChange(of: offset) { _ in
            let tmpIndex = Int(offset.x) / 36
            self.currentIndex = tmpIndex >= imageList.count ? imageList.count-1 : tmpIndex
        }
        .frame(height: 52)
        .padding(.top, 8)
    }
}

#if DEBUG
struct ChatRoomImageViewNavigationSection_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomImageViewNavigationSection()
            .environmentObject(ThemeManager())
    }
}
#endif

// 현재는 가운데 고정 스크롤 사용이 여기뿐이라 여기에 작성했고
// 추후 필요한경우 따로 뺼 필요가 있음
struct HorizontalFixedScrollView<Content: View>: View {
    var content: Content

    @Binding var offset: CGPoint
    var showIndicators: Bool
    var axis: Axis.Set

    @State var startOffset: CGPoint = .zero

    init(offset: Binding<CGPoint>, showIndicators: Bool, axis: Axis.Set, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._offset = offset
        self.showIndicators = showIndicators
        self.axis = axis
    }

    var body: some View {
        ScrollView(axis, showsIndicators: showIndicators, content: {
            content
                .overlay(
                    GeometryReader { proxy -> Color in

                        let rect = proxy.frame(in: .global)

                        if startOffset == .zero {
                            DispatchQueue.main.async {
                                startOffset = CGPoint(x: rect.minX, y: rect.minY)
                            }
                        }

                        DispatchQueue.main.async {

                            if startOffset == .zero {
                                startOffset = CGPoint(x: rect.minX, y: rect.minY)
                            }

                            self.offset = CGPoint(x: startOffset.x - rect.minX, y: startOffset.y - rect.minY)
                        }

                        return Color.clear
                    }
                        .frame(width: UIScreen.main.bounds.width, height: 0, alignment: .top)
                )
        })

    }
}
