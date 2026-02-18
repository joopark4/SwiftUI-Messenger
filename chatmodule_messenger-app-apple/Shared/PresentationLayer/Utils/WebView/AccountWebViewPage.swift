//
//  AccountWebViewPage.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI

struct AccountWebViewPage: View {

    @ObservedObject var viewModel = AccountWebViewModel()
    @State var bar = false

    private let testUrl = "http://signin/identifier"

    var body: some View {
        VStack {
            AccountWebView(url: testUrl, viewModel: viewModel)

//            HStack {
//                Text(bar ? "Before" : "After")
//
//                Button {
//                    self.viewModel.foo.send(true)
//                } label: {
//                    Text("보내기")
//                }
//            }
        }
        .onReceive(self.viewModel.bar.receive(on: RunLoop.main)) { value in
            Log.info("onReceive : \(value)")
            self.bar = value
        }
    }
}

struct AccountWebViewPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountWebViewPage()
    }
}
