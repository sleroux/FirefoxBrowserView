/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

protocol ToolbarActions {
    func goBack()
    func goForward()
    func refresh()
    func stop()
    func share()
}

class ToolbarView: UIView {
    private let buttons: [UIButton]
    private var layout: Layout

    init(frame: CGRect, buttons: [UIButton]) {
        self.buttons = buttons
        self.layout = ToolbarLayout(items: buttons)
        super.init(frame: frame)
        buttons.forEach(addSubview)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layout.layout(in: frame)
    }
}

struct ToolbarLayout<ToolbarItem: UIButton>: Layout {
    private let items: [ToolbarItem]

    init(items: [ToolbarItem]) {
        self.items = items
    }

    mutating func layout(in rect: CGRect) {
        let itemWidth = floor(rect.width / CGFloat(items.count))
        let itemHeight = rect.height
        items.enumerated().forEach { offset, item in
            let frame = CGRect(x: CGFloat(offset) * itemWidth, y: 0, width: itemWidth, height: itemHeight)
            item.frame = frame
        }
    }
}

class BrowserToolbarView: ToolbarView {
    let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "back"), for: [])
        return backButton
    }()

    let forwardButton: UIButton = {
        let forwardButton = UIButton()
        forwardButton.setImage(UIImage(named: "forward"), for: [])
        return forwardButton
    }()

    let refreshButton: UIButton = {
        let refreshButton = UIButton()
        refreshButton.setImage(UIImage(named: "refresh"), for: [])
        return refreshButton
    }()

    let shareButton: UIButton = {
        let shareButton = UIButton()
        shareButton.setImage(UIImage(named: "send"), for: [])
        return shareButton
    }()

    init(frame: CGRect) {
        super.init(frame: frame, buttons: [backButton, forwardButton, refreshButton, shareButton])
        backgroundColor = .gray()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

