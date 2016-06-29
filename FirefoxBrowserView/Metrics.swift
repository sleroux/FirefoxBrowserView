/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

protocol Layout {
    mutating func layout(in rect: CGRect)
}

struct LayoutMetrics {
    static let toolbarHeight: CGFloat = 44
    static let urlFieldHeight: CGFloat = 44
}
