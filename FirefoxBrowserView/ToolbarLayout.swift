/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

struct ToolbarLayout<ToolbarItem: UIView>: Layout {
    let items: [ToolbarItem]

    init(items: [ToolbarItem]) {
        self.items = items
    }

    func layout(in rect: CGRect) {
        let itemWidth = floor(rect.width / CGFloat(items.count))
        let itemHeight = rect.height
        items.enumerated().forEach { offset, item in
            let frame = CGRect(x: CGFloat(offset) * itemWidth, y: 0, width: itemWidth, height: itemHeight)
            item.frame = frame
        }
    }
}
