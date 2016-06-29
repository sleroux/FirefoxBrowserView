/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

class BrowserViewController: UIViewController {
    private var browserView: BrowserView {
        return view as! BrowserView
    }

    private let browserModel: BrowserModel
    private let toolbarController: BrowserToolbarController

    init(
        browserModel: BrowserModel,
        toolbarController: BrowserToolbarController = BrowserToolbarController()
    ) {
        self.browserModel = browserModel
        self.toolbarController = toolbarController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = BrowserView(frame: UIScreen.main().bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        browserView.toolbarView.delegate = toolbarController
    }
}






