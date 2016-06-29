/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

@objc protocol ToolbarDelegate: class {
    func tappedBack()
    func tappedForward()
    func tappedRefresh()
    func tappedStop()
    func tappedShare()
}

class ToolbarView: UIView {
    var delegate: ToolbarDelegate? {
        didSet {
            unbindActions()
            bindActions()
        }
    }

    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back"), for: [])
        return button
    }()

    let forwardButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "forward"), for: [])
        return button
    }()

    let refreshButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "refresh"), for: [])
        return button
    }()

    let shareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "send"), for: [])
        return button
    }()

    private let toolbarLayout: ToolbarLayout<UIButton>

    override init(frame: CGRect) {
        toolbarLayout = ToolbarLayout(items: [
            backButton,
            forwardButton,
            refreshButton,
            shareButton
            ])
        super.init(frame: frame)
        addButtonViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addButtonViews() {
        addSubview(backButton)
        addSubview(forwardButton)
        addSubview(refreshButton)
        addSubview(shareButton)
    }

    private func unbindActions() {
        backButton.removeTarget(delegate, action: #selector(ToolbarDelegate.tappedBack), for: .touchUpInside)
        forwardButton.removeTarget(delegate, action: #selector(ToolbarDelegate.tappedForward), for: .touchUpInside)
        shareButton.removeTarget(delegate, action: #selector(ToolbarDelegate.tappedShare), for: .touchUpInside)
        refreshButton.removeTarget(delegate, action: #selector(ToolbarDelegate.tappedRefresh), for: .touchUpInside)
    }

    private func bindActions() {
        backButton.addTarget(delegate, action: #selector(ToolbarDelegate.tappedBack), for: .touchUpInside)
        forwardButton.addTarget(delegate, action: #selector(ToolbarDelegate.tappedForward), for: .touchUpInside)
        shareButton.addTarget(delegate, action: #selector(ToolbarDelegate.tappedShare), for: .touchUpInside)
        refreshButton.addTarget(delegate, action: #selector(ToolbarDelegate.tappedRefresh), for: .touchUpInside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        toolbarLayout.layout(in: frame)
    }
}
