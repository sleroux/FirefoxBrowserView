/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit
import pop

public func isWideTraitCollection(traitCollection: UITraitCollection) -> Bool {
    return (traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .compact) ||
           (traitCollection.horizontalSizeClass == .regular)
}

extension UIStackView {
    static func toolbar(buttons: [ToolbarButton]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }
}

class URLBarView: UIView {
    private let backgroundCurve: CurveBackgroundView = {
        let view = CurveBackgroundView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let backButton: ToolbarButton = .backButton()
    let forwardButton: ToolbarButton = .forwardButton()
    let refreshButton: ToolbarButton = .refreshButton()
    let shareButton: ToolbarButton = .shareButton()

    let urlTextField: URLInputField = {
        let textField = URLInputField(frame: CGRect.zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let tabButton: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red()
        return view
    }()

    let cancelButton: UIView = {
        let view = UILabel()
        view.text = "Cancel"
        view.backgroundColor = .green()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var leftToolbar: UIStackView = .toolbar(buttons: [self.backButton, self.forwardButton])
    private lazy var rightToolbar: UIStackView = .toolbar(buttons: [self.shareButton])

    private var toggled: Bool = false

    private var tabsTrailingConstraint: NSLayoutConstraint?
    private var urlFieldTrailingConstraint: NSLayoutConstraint?

    private var staticNarrowConstraints: [NSLayoutConstraint]!
    private var staticWideConstraints: [NSLayoutConstraint]!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue()
        addSubview(backgroundCurve)
        addSubview(cancelButton)
        addSubview(urlTextField)
        addSubview(tabButton)
        addSubview(cancelButton)
        addSubview(leftToolbar)
        addSubview(rightToolbar)

        cancelButton.alpha = 0;

        staticWideConstraints = buildWideConstraints()
        staticNarrowConstraints = buildNarrowConstraints()

        tabsTrailingConstraint = tabButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        tabsTrailingConstraint?.isActive = true
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        leftToolbar.isHidden = !isWideTraitCollection(traitCollection: traitCollection)
        rightToolbar.isHidden = !isWideTraitCollection(traitCollection: traitCollection)

        if isWideTraitCollection(traitCollection: traitCollection) {
            // 1. Deactivate previous constraints for narrow layout
            urlFieldTrailingConstraint?.isActive = false
            NSLayoutConstraint.deactivate(staticNarrowConstraints)

            // 2. Active static wide constraints
            NSLayoutConstraint.activate(staticWideConstraints)

            // 3. Setup priorities to resolve ambigious layouts
            leftToolbar.setContentHuggingPriority(UILayoutPriorityRequired, for: .horizontal)
            leftToolbar.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .horizontal)

            rightToolbar.setContentHuggingPriority(UILayoutPriorityRequired, for: .horizontal)
            rightToolbar.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .horizontal)

            // 4. Bind dynamic constraints for animations
            urlFieldTrailingConstraint = urlTextField.trailingAnchor.constraint(equalTo: rightToolbar.leadingAnchor, constant: -10)
            urlFieldTrailingConstraint?.isActive = true

        } else {
            NSLayoutConstraint.deactivate(staticWideConstraints)
            NSLayoutConstraint.activate(staticNarrowConstraints)

            urlFieldTrailingConstraint = urlTextField.trailingAnchor.constraint(equalTo: backgroundCurve.trailingAnchor, constant: -30)
            urlFieldTrailingConstraint?.isActive = true
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Static Constraints
private extension URLBarView {
    private func buildWideConstraints() -> [NSLayoutConstraint] {
        return [
            backgroundCurve.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundCurve.trailingAnchor.constraint(equalTo: tabButton.leadingAnchor),
            backgroundCurve.topAnchor.constraint(equalTo: topAnchor),
            backgroundCurve.bottomAnchor.constraint(equalTo: bottomAnchor),

            tabButton.widthAnchor.constraint(equalToConstant: 30),
            tabButton.heightAnchor.constraint(equalToConstant: 30),
            tabButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            leftToolbar.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftToolbar.centerYAnchor.constraint(equalTo: centerYAnchor),

            rightToolbar.trailingAnchor.constraint(equalTo: backgroundCurve.trailingAnchor, constant: -30),
            rightToolbar.centerYAnchor.constraint(equalTo: centerYAnchor),

            urlTextField.leadingAnchor.constraint(equalTo: leftToolbar.trailingAnchor),
            urlTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            urlTextField.heightAnchor.constraint(equalToConstant: 30),

            cancelButton.trailingAnchor.constraint(equalTo: backgroundCurve.trailingAnchor, constant: -30),
            cancelButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
    }

    private func buildNarrowConstraints() -> [NSLayoutConstraint] {
        return [
            backgroundCurve.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundCurve.trailingAnchor.constraint(equalTo: tabButton.leadingAnchor),
            backgroundCurve.topAnchor.constraint(equalTo: topAnchor),
            backgroundCurve.bottomAnchor.constraint(equalTo: bottomAnchor),

            tabButton.widthAnchor.constraint(equalToConstant: 30),
            tabButton.heightAnchor.constraint(equalToConstant: 30),
            tabButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            urlTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            urlTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            urlTextField.heightAnchor.constraint(equalToConstant: 30),

            cancelButton.trailingAnchor.constraint(equalTo: backgroundCurve.trailingAnchor, constant: -30),
            cancelButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
    }
}

// MARK: Animators
extension URLBarView {
    func tappedURLTextField() {
        toggled ? unselectURLTextField() : selectURLTextField()
        toggled = !toggled
    }

    func unselectURLTextField() {
        guard let moveTrailing = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant),
            let shrinkTextField = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant),
            let showCancel = POPBasicAnimation(propertyNamed: kPOPViewAlpha) else {
                return
        }
        moveTrailing.toValue = -10
        tabsTrailingConstraint?.pop_add(moveTrailing, forKey: "animate_trailing")

        shrinkTextField.toValue = -30
        urlFieldTrailingConstraint?.pop_add(shrinkTextField, forKey: "animate_trailing")

        showCancel.toValue = 0
        cancelButton.pop_add(showCancel, forKey: "show_cancel")
    }

    func selectURLTextField() {
        guard let moveTrailing = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant),
              let shrinkTextField = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant),
              let showCancel = POPBasicAnimation(propertyNamed: kPOPViewAlpha) else {
            return
        }
        moveTrailing.toValue = 40
        tabsTrailingConstraint?.pop_add(moveTrailing, forKey: "animate_trailing")

        shrinkTextField.toValue = -95
        urlFieldTrailingConstraint?.pop_add(shrinkTextField, forKey: "animate_trailing")

        showCancel.toValue = 1
        cancelButton.pop_add(showCancel, forKey: "show_cancel")
    }
}

