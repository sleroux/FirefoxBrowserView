/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

struct BrowserLayout: Layout {
    let toolbarView: ToolbarView
    let urlBarView: URLBarView
    let webView: UIView

    func layout(in rect: CGRect) {
        webView.frame = CGRect(x: 0,
                               y: LayoutMetrics.urlFieldHeight,
                               width: rect.width,
                               height: rect.height - LayoutMetrics.urlFieldHeight - LayoutMetrics.toolbarHeight)

        let toolbarFrame = CGRect(x: 0,
                                  y: rect.height - LayoutMetrics.toolbarHeight,
                                  width: rect.width,
                                  height: LayoutMetrics.toolbarHeight)
        toolbarView.frame = toolbarFrame

        let urlBarFrame = CGRect(x: 0,
                                 y: 0,
                                 width: rect.width,
                                 height: LayoutMetrics.urlFieldHeight)
        urlBarView.frame = urlBarFrame
    }
}
