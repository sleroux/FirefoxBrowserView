/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

class ChromeView: UIView {
    private(set) var content: UIView?
    let toolbar = BrowserToolbarView(frame: .zero)
    let urlBar = URLBarView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        urlBar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.translatesAutoresizingMaskIntoConstraints = false

        addSubview(toolbar)
        addSubview(urlBar)

        urlBar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        urlBar.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        urlBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        urlBar.heightAnchor.constraint(equalToConstant: LayoutMetrics.urlFieldHeight).isActive = true

        toolbar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        toolbar.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        toolbar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        toolbar.heightAnchor.constraint(equalToConstant: LayoutMetrics.toolbarHeight).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setContent(view: UIView) {
        content = view
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        view.topAnchor.constraint(equalTo: urlBar.bottomAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: toolbar.topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        setNeedsLayout()
    }
}
