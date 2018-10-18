import UIKit

@objc protocol NotificationDelegate: AnyObject {
    @objc optional func didUpdateSelectedPageContent()
    @objc optional func didUpdateLockedValue()
    @objc optional func applicationDidBecomeActive()
    // ...
}

class NotificationManager {
    private var delegates = [Weak<NotificationDelegate>]()

    func addDelegate(_ delegate: NotificationDelegate) {
        delegates.append(Weak(value: delegate))
    }

    func removeDelegate(_ delegate: NotificationDelegate) {
        if let indexToRemove = delegates.index(where: { $0.value === delegate }) {
            delegates.remove(at: indexToRemove)
        }
    }

    func didUpdateSelectedPageContent() {
        delegates.forEach { $0.value?.didUpdateSelectedPageContent?() }
    }

    func didUpdateLockedValue() {
        delegates.forEach { $0.value?.didUpdateLockedValue?() }
    }

    func applicationDidBecomeActive() {
        delegates.forEach { $0.value?.applicationDidBecomeActive?() }
    }
    
    // ...
}

class Weak<T: AnyObject> {
    weak var value: T?
    init (value: T) {
        self.value = value
    }
}

extension Array where Element: Weak<AnyObject> {
    mutating func reap () {
        self = self.filter { nil != $0.value }
    }
}

// Example use
class ExampleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationManager.addDelegate(self)
    }

    deinit {
        notificationManager.removeDelegate(self)
    }
}

extension ExampleViewController: NotificationDelegate {
    func didUpdateLockedValue() {
        //leftViewController?.updateUI()
        //removeRightViewControllerAndView()
    }
}

class AnotherViewController: UIViewController {
    func didClickButton() {
        notificationManager.didUpdateLockedValue()
    }
}
