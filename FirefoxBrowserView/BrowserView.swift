/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

class BrowserView: UIView {
    let webView: UIView = {
        let view = UIView()
        view.backgroundColor = .green()
        return view
    }()

    let toolbarView = ToolbarView()

    let urlBarView = URLBarView()

    private let browserLayout: BrowserLayout

    override init(frame: CGRect) {
        browserLayout = BrowserLayout(toolbarView: toolbarView, urlBarView: urlBarView, webView: webView)
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubview(webView)
        addSubview(toolbarView)
        addSubview(urlBarView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        browserLayout.layout(in: frame)
    }
}
