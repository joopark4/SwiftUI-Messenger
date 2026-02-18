//
//  AccountWebViewModel.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import Combine

class AccountWebViewModel: ObservableObject {
    // App > Web
    var foo = PassthroughSubject<Bool, Never>()
    // Web > App
    var bar = PassthroughSubject<Bool, Never>()
    var webViewNavigationPublisher = PassthroughSubject<WebViewNavigation, Never>()
}

enum WebViewNavigation {
    case backward, forward, reload
}
