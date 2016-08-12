/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

enum ReaderModeBarButtonType {
    case MarkAsRead, MarkAsUnread, Settings, AddToReadingList, RemoveFromReadingList

    private var localizedDescription: String {
        switch self {
        case .MarkAsRead: return NSLocalizedString("Mark as Read", comment: "Name for Mark as read button in reader mode")
        case .MarkAsUnread: return NSLocalizedString("Mark as Unread", comment: "Name for Mark as unread button in reader mode")
        case .Settings: return NSLocalizedString("Display Settings", comment: "Name for display settings button in reader mode. Display in the meaning of presentation, not monitor.")
        case .AddToReadingList: return NSLocalizedString("Add to Reading List", comment: "Name for button adding current article to reading list in reader mode")
        case .RemoveFromReadingList: return NSLocalizedString("Remove from Reading List", comment: "Name for button removing current article from reading list in reader mode")
        }
    }

    private var imageName: String {
        switch self {
        case .MarkAsRead: return "MarkAsRead"
        case .MarkAsUnread: return "MarkAsUnread"
        case .Settings: return "SettingsSerif"
        case .AddToReadingList: return "addToReadingList"
        case .RemoveFromReadingList: return "removeFromReadingList"
        }
    }

    private var image: UIImage? {
        let image = UIImage(named: imageName)
        image?.accessibilityLabel = localizedDescription
        return image
    }
}

private func createImageButton(type: ReaderModeBarButtonType) -> UIButton {
    let button = UIButton()
    button.setImage(type.image, for: .normal)
    return button
}

protocol ReaderActionsDelegate: class {
    func tappedReadStatus()

    func tappedSettings()

    func tappedListStatus()
}

class ReaderModeBarView: UIStackView {

    weak var delegate: ReaderActionsDelegate?

    var readingItemModel: ReadingItemModel {
        didSet {
            let readType: ReaderModeBarButtonType =
                !readingItemModel.hasRead && readingItemModel.hasBeenAdded ? .MarkAsRead : .MarkAsUnread
            readStatusButton.setImage(readType.image, for: .normal)
            readStatusButton.isEnabled = readingItemModel.hasBeenAdded
            readStatusButton.alpha = readingItemModel.hasBeenAdded ? 1.0 : 0.6

            let addedType: ReaderModeBarButtonType = readingItemModel.hasBeenAdded ? .RemoveFromReadingList : .AddToReadingList
            listStatusButton.setImage(addedType.image, for: .normal)
        }
    }

    private let readStatusButton: UIButton = createImageButton(type: .MarkAsRead)

    private let settingsButton: UIButton = createImageButton(type: .Settings)

    private let listStatusButton: UIButton = createImageButton(type: .AddToReadingList)

    init(model: ReadingItemModel) {
        self.readingItemModel = model
        super.init(frame: .zero)

        addArrangedSubview(readStatusButton)
        addArrangedSubview(settingsButton)
        addArrangedSubview(listStatusButton)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: View Overrides
extension ReaderModeBarView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        ctx.setLineWidth(0.5)
        ctx.setStrokeColor(UIColor.gray.cgColor)
        ctx.beginPath()
        ctx.moveTo(x: 0, y: rect.size.height)
        ctx.addLineTo(x: rect.size.width, y: rect.size.height)
        ctx.strokePath()
    }
}

// MARK: Selectors
extension ReaderModeBarView {

    func tappedReadStatus() {
        delegate?.tappedReadStatus()
    }

    func tappedSettingsButton() {
        delegate?.tappedSettings()
    }

    func tappedListStatus() {
        delegate?.tappedListStatus()
    }
}
