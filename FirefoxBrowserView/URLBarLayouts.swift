/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation
import CoreGraphics

struct URLBarWide: Layout {
    private var backgroundCurve: Frameable
    private var urlTextField: Frameable
    private var rightToolbar: Frameable
    private var leftToolbar: Frameable

    init(backgroundCurve: Frameable, urlTextField: Frameable, rightToolbar: Frameable, leftToolbar: Frameable) {
        self.backgroundCurve = backgroundCurve
        self.urlTextField = urlTextField
        self.rightToolbar = rightToolbar
        self.leftToolbar = leftToolbar
    }

    mutating func layout(in rect: CGRect) {
        backgroundCurve.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        urlTextField.frame = CGRect(x: 10, y: 4, width: rect.width - 60, height: rect.height - 4 * 2)
    }
}

struct URLBarNarrow: Layout {
    private var backgroundCurve: Frameable
    private var urlTextField: Frameable
    private var rightToolbar: Frameable
    private var leftToolbar: Frameable

    init(backgroundCurve: Frameable, urlTextField: Frameable, rightToolbar: Frameable, leftToolbar: Frameable) {
        self.backgroundCurve = backgroundCurve
        self.urlTextField = urlTextField
        self.rightToolbar = rightToolbar
        self.leftToolbar = leftToolbar
    }

    mutating func layout(in rect: CGRect) {
        backgroundCurve.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        urlTextField.frame = CGRect(x: 10, y: 6, width: rect.width - 60, height: rect.height - 6 * 2)
    }
}
