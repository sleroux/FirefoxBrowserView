/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation
import CoreGraphics

struct ChromeNarrow: Layout {
    private var content: Frameable?
    private var toolbar: Frameable
    private var urlBar: Frameable

    init(content: Frameable?, toolbar: Frameable, urlBar: Frameable) {
        self.content = content
        self.toolbar = toolbar
        self.urlBar = urlBar
    }

    mutating func layout(in rect: CGRect) {
        content?.frame = CGRect(x: 0,
                                y: LayoutMetrics.urlFieldHeight,
                                width: rect.width,
                                height: rect.height - LayoutMetrics.urlFieldHeight - LayoutMetrics.toolbarHeight)

        let toolbarFrame = CGRect(x: 0,
                                  y: rect.height - LayoutMetrics.toolbarHeight,
                                  width: rect.width,
                                  height: LayoutMetrics.toolbarHeight)
        toolbar.frame = toolbarFrame

        let urlBarFrame = CGRect(x: 0,
                                 y: 0,
                                 width: rect.width,
                                 height: LayoutMetrics.urlFieldHeight)
        urlBar.frame = urlBarFrame
    }
}

struct ChromeWide: Layout {
    private var content: Frameable?
    private var toolbar: Frameable
    private var urlBar: Frameable

    init(content: Frameable?, toolbar: Frameable, urlBar: Frameable) {
        self.content = content
        self.toolbar = toolbar
        self.urlBar = urlBar
    }

    mutating func layout(in rect: CGRect) {
        content?.frame = CGRect(x: 0,
                                      y: LayoutMetrics.urlFieldHeight,
                                      width: rect.width,
                                      height: rect.height - LayoutMetrics.urlFieldHeight)

        let toolbarFrame = CGRect(x: 0,
                                  y: rect.height,
                                  width: rect.width,
                                  height: LayoutMetrics.toolbarHeight)
        toolbar.frame = toolbarFrame

        let urlBarFrame = CGRect(x: 0,
                                 y: 0,
                                 width: rect.width,
                                 height: LayoutMetrics.urlFieldHeight)
        urlBar.frame = urlBarFrame
    }
}
