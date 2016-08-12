/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

protocol ChromeActionDelegate: class {
    func tappedGoBack()

    func tappedGoForward()

    func tappedRefresh()

    func tappedShare()
}

extension UIStackView {
    static func toolbar(buttons: [ToolbarButton]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }
}

class ChromeViewController: UIViewController {

    weak var chromeActionDelegate: ChromeActionDelegate?

    private let browserModel: BrowserModel

    private lazy var urlBar: URLBarViewController = {
        let urlBar = URLBarViewController()
        urlBar.view.translatesAutoresizingMaskIntoConstraints = false
        return urlBar
    }()

    private lazy var urlBarView: URLBarView = {
        return self.urlBar.urlBarView
    }()
    
    private let toolbar: UIStackView = {
        let view = UIStackView.toolbar(buttons: [
            .backButton(), .forwardButton(), .refreshButton(), .shareButton()
        ])
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let topThemeView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "fox"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private var toolbarBottomConstraint: NSLayoutConstraint?

    init(browserModel: BrowserModel) {
        self.browserModel = browserModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: View Controller Overrides
extension ChromeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(topThemeView)

        urlBar.willMove(toParentViewController: self)
        addChildViewController(urlBar)
        view.addSubview(urlBarView)
        urlBar.didMove(toParentViewController: self)

        view.addSubview(toolbar)

        self.setupConstraints()

        showWebView()

        browserModel.webView.load(URLRequest(url: URL(string: "https://www.mozilla.org")!))
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { _ in
            if isWideTraitCollection(traitCollection: newCollection) {
                self.toolbarBottomConstraint?.constant = 44
            } else {
                self.toolbarBottomConstraint?.constant = 0
            }
        }, completion: nil)
    }
}

// MARK: Helpers
extension ChromeViewController {

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topThemeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topThemeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topThemeView.topAnchor.constraint(equalTo: view.topAnchor),
            topThemeView.heightAnchor.constraint(equalToConstant: LayoutMetrics.urlFieldHeight + 20),

            urlBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            urlBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            urlBarView.heightAnchor.constraint(equalToConstant: LayoutMetrics.urlFieldHeight),
            urlBarView.bottomAnchor.constraint(equalTo: topThemeView.bottomAnchor),

            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: LayoutMetrics.toolbarHeight)
        ])

        toolbarBottomConstraint = toolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        toolbarBottomConstraint?.isActive = true
    }
}

// MARK: Content Management
extension ChromeViewController {

    func showWebView() {
        let webViewController = FirefoxWebViewController(browserModel: browserModel)
        webViewController.willMove(toParentViewController: self)
        addChildViewController(webViewController)

        let contentView = webViewController.view!
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)

        webViewController.didMove(toParentViewController: self)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: urlBarView.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: toolbar.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        view.setNeedsLayout()
    }

    func showHomeView() {
        
    }
}

// MARK: Chrome Actions
extension ChromeViewController {
    func tappedBack() {
        chromeActionDelegate?.tappedGoBack()
    }

    func tappedForward() {
        chromeActionDelegate?.tappedGoForward()
    }

    func tappedRefresh() {
        chromeActionDelegate?.tappedRefresh()
    }

    func tappedShare() {
        chromeActionDelegate?.tappedShare()
    }
}






