import UIKit

class XibLoadedView: UIView {
    var loadedView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    internal func xibSetup() {
        guard let loadedView = viewLoadedFromNib(named: xibName) else {
            return
        }

        loadedView.frame = bounds
        loadedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setupView()
        addSubview(loadedView)
        self.loadedView = loadedView
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

    internal func setupView() {
        // To be overridden
    }

    internal var xibName: String? {
        // To be overridden if xib filename is other than subclass name
        return nil
    }
}

extension UIView {
    @discardableResult
    func viewLoadedFromNib<T: UIView>(named nibName: String? = nil) -> T? {
        let nibName = nibName ?? String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? T
        return view
    }
}
