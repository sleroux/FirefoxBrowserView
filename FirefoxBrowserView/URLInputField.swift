/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

@objc protocol URLInputFieldDelegate: class {
    func didSubmitText(text: String)
}

class URLInputField: UITextField {
    weak var urlDelegate: URLInputFieldDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        autocorrectionType = .no
        autocapitalizationType = .none

        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 4
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 2)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 2)
    }
}

extension URLInputField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            self.selectedTextRange = self.textRange(from: self.beginningOfDocument, to: self.endOfDocument)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        urlDelegate?.didSubmitText(text: text ?? "")
        endEditing(true)
        return true
    }
}
