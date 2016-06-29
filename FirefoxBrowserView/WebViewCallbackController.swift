/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation
import WebKit

class WebViewCallbackController: NSObject {}

extension WebViewCallbackController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {

    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: (WKNavigationResponsePolicy) -> Void) {

    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

    }

    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {

    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {

    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {

    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: NSError) {

    }

    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

    }

    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {

    }
}

extension WebViewCallbackController: WKUIDelegate {

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        return webView
    }

    func webViewDidClose(_ webView: WKWebView) {

    }

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {

    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: (Bool) -> Void) {

    }

    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: (String?) -> Void) {

    }
}
