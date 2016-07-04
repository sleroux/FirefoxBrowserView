/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit
import pop

class URLBarView: UIView {
    private let backgroundCurve: CurveBackgroundView = {
        let view = CurveBackgroundView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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

    let urlTextField: UILabel = {
        let textField = UILabel()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Test"
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = UIColor.gray().cgColor
        textField.backgroundColor = .purple()
        textField.isUserInteractionEnabled = true
        return textField
    }()

    private lazy var leftToolbar: ToolbarView = ToolbarView(frame: CGRect.zero, buttons: [
        self.backButton, self.forwardButton, self.refreshButton
    ])

    private lazy var rightToolbar: ToolbarView = ToolbarView(frame: CGRect.zero, buttons: [
        self.shareButton
    ])

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue()
        addSubview(backgroundCurve)
        addSubview(urlTextField)

        urlTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(URLBarView.tappedURLTextField)))

        backgroundCurve.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundCurve.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        backgroundCurve.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundCurve.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        urlTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        urlTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -60).isActive = true
        urlTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
        urlTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 6).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Animators
extension URLBarView {
    func tappedURLTextField() {
        performSelectURLTextFieldAnimation()
    }

    func performSelectURLTextFieldAnimation() {
        guard let animation = POPSpringAnimation(propertyNamed: kPOPLayerBounds) else {
            return
        }
        animation.toValue = NSValue(cgRect: CGRect(x: 10, y: 4, width: frame.width - 200, height: 40))
        animation.springBounciness = 20
        urlTextField.pop_add(animation, forKey: "size")
    }
}

private class CurveBackgroundView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let curvePath = UIBezierPath.tabCurvePath(width: rect.width, height: rect.height, direction: .right)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setFillColor(UIColor.white().cgColor)
        curvePath.fill()
    }
}

private enum TabCurveDirection {
    case right
    case left
    case both
}

private extension UIBezierPath {
    static func tabCurvePath(width: CGFloat, height: CGFloat, direction: TabCurveDirection) -> UIBezierPath {
        let x1: CGFloat = 32.84
        let x2: CGFloat = 5.1
        let x3: CGFloat = 19.76
        let x4: CGFloat = 58.27
        let x5: CGFloat = -12.15

        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: width, y: height))
        switch direction {
        case .right:
            bezierPath.addCurve(to: CGPoint(x: width-x1, y: 0), controlPoint1: CGPoint(x: width-x3, y: height), controlPoint2: CGPoint(x: width-x2, y: 0))
            bezierPath.addCurve(to: CGPoint(x: 0, y: 0), controlPoint1: CGPoint(x: 0, y: 0), controlPoint2: CGPoint(x: 0, y: 0))
            bezierPath.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: 0, y: height), controlPoint2: CGPoint(x: 0, y: height))
            bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: x5, y: height), controlPoint2: CGPoint(x: width-x5, y: height))
        case .left:
            bezierPath.addCurve(to: CGPoint(x: width, y: 0), controlPoint1: CGPoint(x: width, y: 0), controlPoint2: CGPoint(x: width, y: 0))
            bezierPath.addCurve(to: CGPoint(x: x1, y: 0), controlPoint1: CGPoint(x: width-x4, y: 0), controlPoint2: CGPoint(x: x4, y: 0))
            bezierPath.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: x2, y: 0), controlPoint2: CGPoint(x: x3, y: height))
            bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width, y: height), controlPoint2: CGPoint(x: width, y: height))
        case .both:
            bezierPath.addCurve(to: CGPoint(x: width-x1, y: 0), controlPoint1: CGPoint(x: width-x3, y: height), controlPoint2: CGPoint(x: width-x2, y: 0))
            bezierPath.addCurve(to: CGPoint(x: x1, y: 0), controlPoint1: CGPoint(x: width-x4, y: 0), controlPoint2: CGPoint(x: x4, y: 0))
            bezierPath.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: x2, y: 0), controlPoint2: CGPoint(x: x3, y: height))
            bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: x5, y: height), controlPoint2: CGPoint(x: width-x5, y: height))
        }
        bezierPath.close()
        bezierPath.miterLimit = 4;
        return bezierPath
    }
}
