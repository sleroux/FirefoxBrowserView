/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

class ChromeView: UIView {
    private(set) var content: UIView?
    let toolbar: UIStackView = .toolbar(buttons: [
        .backButton(), .forwardButton(), .refreshButton(), .shareButton()
    ])

    let urlBar = URLBarView()

    private var toolbarBottomConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        urlBar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.distribution = .fillEqually

        addSubview(toolbar)
        addSubview(urlBar)

        urlBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        urlBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        urlBar.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        urlBar.heightAnchor.constraint(equalToConstant: LayoutMetrics.urlFieldHeight).isActive = true

        toolbarBottomConstraint = toolbar.bottomAnchor.constraint(equalTo: bottomAnchor)
        toolbarBottomConstraint?.isActive = true

        toolbar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        toolbar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        toolbar.heightAnchor.constraint(equalToConstant: LayoutMetrics.toolbarHeight).isActive = true
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if isWideTraitCollection(traitCollection: traitCollection) {
            toolbarBottomConstraint?.constant = 44
        } else {
            toolbarBottomConstraint?.constant = 0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setContent(view: UIView) {
        content = view
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: urlBar.bottomAnchor),
            view.bottomAnchor.constraint(equalTo: toolbar.topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        setNeedsLayout()
    }
}
