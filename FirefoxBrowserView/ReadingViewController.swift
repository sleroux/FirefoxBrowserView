/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

class ReadingViewController: UIViewController {
    private let browserModel: BrowserModel

    private let topBar: ReaderModeBarView = ReaderModeBarView()

    init(browserModel: BrowserModel) {
        self.browserModel = browserModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Top Bar Actions
extension ReadingViewController: ReaderActionsDelegate {
    func tappedReadStatus() {

    }

    func tappedSettings() {

    }

    func tappedListStatus() {

    }
}
