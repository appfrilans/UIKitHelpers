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
