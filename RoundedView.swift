import UIKit

@IBDesignable
class RoundedView: UIView {

    @IBInspectable var isRounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }

    func updateCornerRadius() {
        layer.cornerRadius = isRounded ? frame.size.height / 2 : 0
        layer.masksToBounds = isRounded
    }

    override var backgroundColor: UIColor? {
        didSet {
            if let bgColor = backgroundColor, bgColor.cgColor.alpha == 0 {
                backgroundColor = oldValue
            }
        }
    }
}
