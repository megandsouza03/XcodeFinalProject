
import UIKit

class CustomAlertViewController : UIViewController {
    let transitioner = CAVTransitioner()
    
    @IBOutlet weak var timePicker: UIDatePicker!
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.transitioner
    }
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    @IBAction func doDismiss(_ sender:Any) {
        print(timePicker.countDownDuration)
        
//        HomePageViewController()
//        vc.startTimer(timePicker.countDownDuration)
        let vc = HomePageViewController()
        
        vc.startTimer(interval: timePicker.countDownDuration-50)
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
