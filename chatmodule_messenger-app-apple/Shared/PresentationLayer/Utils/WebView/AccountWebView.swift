//
//  AccountWebView.swift
//  ChatModuleMessengerAppApple
//

import Foundation
import SwiftUI
import WebKit
import UIKit
import Combine

 protocol AccountWebViewHandlerDelegate {
    func receivedJsonValueFromWebView(value: [String: Any?])
    func receivedStringValueFromWebView(value: String)
 }

struct AccountWebView: UIViewRepresentable, AccountWebViewHandlerDelegate {

    var url: String

    @ObservedObject var viewModel: AccountWebViewModel

    func makeUIView(context: Context) -> WKWebView {

        let wkWebView = context.coordinator.wkWebView
        context.coordinator.addWKWebViewObserve()

        // - WKWebView에 대한 설정
        // 웹 사이트에 적용 할 표준 동작을 캡슐화하는 개체
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true // JavaScript가 사용자 상호 작용없이 창을 열 수 있는지 여부

        // 웹보기를 초기화하는 데 사용하는 속성 모음
        let configuration = WKWebViewConfiguration()
        configuration.userContentController.add(context.coordinator, name: "chatmodule_account")
        configuration.preferences = preferences

        guard let url = URL(string: self.url) else {
            return wkWebView
        }

        wkWebView.navigationDelegate = context.coordinator // 웹보기의 탐색 동작을 관리하는 데 사용하는 개체
        wkWebView.allowsBackForwardNavigationGestures = true // 가로로 스와이프 동작이 페이지 탐색을 앞뒤로 트리거하는지 여부
        wkWebView.scrollView.isScrollEnabled = true // 웹보기와 관련된 스크롤보기에서 스크롤 가능 여부

        wkWebView.load(URLRequest(url: url))

        return wkWebView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func receivedJsonValueFromWebView(value: [String: Any?]) {
        Log.info("\(#function)-JSON Data:\n\(value)")
    }

    func receivedStringValueFromWebView(value: String) {
        Log.info("\(#function)-String Data:\n\(value)")
    }

}

// MARK: - Coordinator
extension AccountWebView {

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: AccountWebView
        var WVDelegate: AccountWebViewHandlerDelegate?
        var foo: AnyCancellable?
        var webViewNavigationSubscriber: AnyCancellable?

        let wkWebView = WKWebView()
        var tokenValue = ""
        var urlChangedObservation: NSKeyValueObservation?

        init(_ accountWebView: AccountWebView) {
            self.parent = accountWebView
            self.WVDelegate = parent
        }

        deinit {
            foo?.cancel()
            webViewNavigationSubscriber?.cancel()
            urlChangedObservation = nil
        }

        func addWKWebViewObserve() {
            self.urlChangedObservation = self.wkWebView.observe(\WKWebView.url, changeHandler: { [weak self] view, keyvalue in
                guard let changeUrl = view.url else {
                    return
                }

                Log.info("Change WKWebView url : \(changeUrl)")
                Log.info("Change KeyValue : \(keyvalue)")

                view.configuration.websiteDataStore.httpCookieStore.getAllCookies { [weak self] cookies in
                    for cookie in cookies {

                        guard let cookieName = cookie.name.removingPercentEncoding else {
                            continue
                        }

                        let tokenKey = "chatmodule_accounts::app-browser::SIGNIN_COOKIE"
                        if cookieName == tokenKey {
                            // 로그인 토큰 정보
                            Log.info("account info : \(cookie.value)")
                            self?.tokenValue = cookie.value
                            self?.saveTokenInfo()
                        }
                    }
                }
            })
        }

        func saveTokenInfo() {
            // Test - 키체인에 등록 구현부 샘플코드
            Log.debug(self.tokenValue)

            let data: Data = Data(from: self.tokenValue)
            let status = KeyChainService.save(key: AccountToken.tokenKey, data: data)
            Log.debug("status: \(status)")

            if let receiveData = KeyChainService.load(key: AccountToken.tokenKey) {
                let res = receiveData.to(type: String.self)
                Log.debug("result: \(res)")
            }
            Log.debug(KeyChainService.delete(key: AccountToken.tokenKey))
        }

        // 지정된 기본 설정 및 작업 정보를 기반으로 새 콘텐츠를 탐색 할 수있는 권한을 대리인에게 요청
        func webView(_ webView: WKWebView,
                     decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

            /*
            if let hots = navigationAction.request.url?.host {
                // 특정 도메인을 제외한 도메인을 연결하지 못하게
                if hots != "http://192.168.0.0:1234/" {
                    Log.error("도메인 오류")
                    return decisionHandler(.cancel)
                }
            }
             */

            Log.info("\(#function)")
            parent.viewModel.bar.send(false)

            self.foo = self.parent.viewModel.foo
                .receive(on: RunLoop.main)
                .sink(receiveValue: { value in
                    Log.info("\(#function ) - \(value)")
                })

            return decisionHandler(.allow)
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            Log.info("기본 프레임에서 탐색 시작")

            self.foo = self.parent.viewModel.webViewNavigationPublisher.receive(on: RunLoop.main)
                .sink(receiveValue: { value in
                    switch value {
                    case .backward:
                        if webView.canGoBack {
                            webView.goBack()
                        }

                    case .forward:
                        if webView.canGoForward {
                            webView.goForward()
                        }

                    case .reload:
                        webView.reload()
                    }
                })
        }

        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            Log.info("기본 프레임에 대한 내용 수신 시작")
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            Log.info("탐색 완료")

            // 예제
            /*
            webView.evaluateJavaScript("document.title") { (response, error) in
                if let error = error {
                    Log.error("Error Getting Title")
                    Log.error(error.localizedDescription)
                }

                guard let title = response as? String else {
                    return
                }

                Log.info("didFinish - \(title)")
            }
             */
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            Log.info("초기 탐색 프로세스 중 오류 발생")
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            Log.info("탐색 중 오류 발생")
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            Log.info("탐색 요청에 대한 응답이 알려진 후 새 컨텐츠 탐색 권한을 요청")
            decisionHandler(.allow)
        }

        func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
            Log.info("서버 리디렉션을 수신")
        }

        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
            Log.info("컨텐츠 프로세스가 종료")
        }

        func webView(_ webView: WKWebView, authenticationChallenge challenge: URLAuthenticationChallenge, shouldAllowDeprecatedTLS decisionHandler: @escaping (Bool) -> Void) {
            Log.info("TLS")
        }

        func printCookies(webView: WKWebView) {
            webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
                for cookie in cookies {
                    Log.debug("\(cookie.name.removingPercentEncoding) >>> \(cookie.value)")
                }
            }

            WKWebsiteDataStore.default().httpCookieStore.getAllCookies { cookies in
                Log.error(cookies)
            }
        }
    }

}

extension AccountWebView.Coordinator: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        Log.info(message)
        if message.name == "chatmodule_account" {
            if let body = message.body as? [String: Any?] {
                WVDelegate?.receivedJsonValueFromWebView(value: body)
            } else if let body = message.body as? String {
                WVDelegate?.receivedStringValueFromWebView(value: body)
            }
        }
    }
}

extension HTTPCookieStorage {

    static func clear() {
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
    }

    static func save() {

        var cookies = [Any]()

        if let newCookies = HTTPCookieStorage.shared.cookies {
            for newCookie in newCookies {
                var cookie = [HTTPCookiePropertyKey: Any]()
                cookie[.name] = newCookie.name
                cookie[.value] = newCookie.value
                cookie[.domain] = newCookie.domain
                cookie[.path] = newCookie.path
                cookie[.version] = newCookie.version

                if let date = newCookie.expiresDate {
                    cookie[.expires] = date
                }
                cookies.append(cookie)
            }

            UserDefaults.standard.setValue(cookies, forKey: "cookies")
            UserDefaults.standard.synchronize()
        }
    }

    static func restore() {
        if let cookies = UserDefaults.standard.value(forKey: "cookies") as? [[HTTPCookiePropertyKey: Any]] {
            for cookie in cookies {
                if let oldCookie = HTTPCookie(properties: cookie) {
                    print("cookie loaded:\(oldCookie)")
                    HTTPCookieStorage.shared.setCookie(oldCookie)
                }
            }
        }
    }

}

