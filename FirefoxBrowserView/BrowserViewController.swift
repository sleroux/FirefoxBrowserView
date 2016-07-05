/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

class BrowserViewController: UIViewController {
    private var chromeView: ChromeView {
        return view as! ChromeView
    }

    private let browserModel: BrowserModel
    private let toolbarController: BrowserToolbarController

    init(
        browserModel: BrowserModel,
        toolbarController: BrowserToolbarController = BrowserToolbarController()
    ) {
        self.browserModel = browserModel
        self.toolbarController = toolbarController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let chrome = ChromeView(frame: UIScreen.main().bounds)
        chrome.translatesAutoresizingMaskIntoConstraints = false
        self.view = chrome
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToolbarSelectors()
        showWebView()

        browserModel.webView.load(URLRequest(url: URL(string: "https://www.mozilla.org")!))
    }
}

// MARK: Content Management
extension BrowserViewController {
    func showWebView() {
        let webViewController = FirefoxWebViewController(browserModel: browserModel)
        webViewController.willMove(toParentViewController: self)
        chromeView.setContent(view: webViewController.view)
        webViewController.didMove(toParentViewController: self)
    }

    func showHomeView() {
        
    }
}

// MARK: Selectors
extension BrowserViewController {
    private func bindToolbarSelectors() {
        // Bind bottom toolbar buttons
//        chromeView.toolbar.backButton.addTarget(self, action: #selector(BrowserViewController.tappedBack), for: .touchUpInside)
//        chromeView.toolbar.forwardButton.addTarget(self, action: #selector(BrowserViewController.tappedForward), for: .touchUpInside)
//        chromeView.toolbar.refreshButton.addTarget(self, action: #selector(BrowserViewController.tappedRefresh), for: .touchUpInside)
//        chromeView.toolbar.shareButton.addTarget(self, action: #selector(BrowserViewController.tappedShare), for: .touchUpInside)

        // Bind URL bar toolbar buttons
        chromeView.urlBar.backButton.addTarget(self, action: #selector(BrowserViewController.tappedBack), for: .touchUpInside)
        chromeView.urlBar.forwardButton.addTarget(self, action: #selector(BrowserViewController.tappedForward), for: .touchUpInside)
        chromeView.urlBar.refreshButton.addTarget(self, action: #selector(BrowserViewController.tappedRefresh), for: .touchUpInside)
        chromeView.urlBar.shareButton.addTarget(self, action: #selector(BrowserViewController.tappedShare), for: .touchUpInside)
    }

    func tappedBack() { toolbarController.goBack() }

    func tappedForward() { toolbarController.goForward() }

    func tappedRefresh() { toolbarController.refresh() }

    func tappedStop() { toolbarController.stop() }

    func tappedShare() { toolbarController.share() }
}





