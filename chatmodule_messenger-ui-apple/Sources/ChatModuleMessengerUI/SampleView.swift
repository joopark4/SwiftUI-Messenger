//
//  SampleView.swift
//  ChatModuleMessengerUI
//

import SwiftUI

private struct SampleView: View {
    @State var tm = ThemeManager()

    var body: some View {
        VStack {
            Text("Hello world")
                .font(.largeTitle)
                .foregroundColor(Color(UIColor.systemPurple))
                .padding()

            Text(tm.lang.localized("Common.Cancel"))
                .font(tm.typo.largeTitle)
                .foregroundColor(tm.theme.systemPurple)
                .padding()

            Button(action: {
                self.tm.typo.types = .chatmodule
                self.tm.lang.types = .english
                self.tm.theme.types = .chatmodule
            }, label: {
                Text("change")
            })
            .padding()
        }
    }
}

#if DEBUG
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SampleView()
            .previewLayout(.sizeThatFits)

        SampleView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
#endif
