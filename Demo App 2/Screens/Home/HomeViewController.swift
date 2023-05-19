import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var doTodayView: UIView!
    @IBOutlet weak var activitiesAndTipsView: UIView!
    @IBOutlet weak var trackItView: UIView!
    @IBOutlet weak var eventsView: UIView!
    @IBOutlet weak var trainingView: UIView!
    @IBOutlet weak var sayAndShareView: UIView!
    @IBOutlet weak var quoteView: UIView!
    @IBOutlet weak var quoteAutherLabel: UILabel!
    @IBOutlet weak var quoteTextLabel: UILabel!
    
    var quote: Quote = Quote(author: "", text: "")
    var homeViewModel: HomeViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateQuote()
        
        quoteAutherLabel.text = quote.author
        quoteTextLabel.text = quote.text
        
        doTodayView.layer.cornerRadius = 12
        activitiesAndTipsView.layer.cornerRadius = 12
        trackItView.layer.cornerRadius = 12
        eventsView.layer.cornerRadius = 12
        trainingView.layer.cornerRadius = 12
        sayAndShareView.layer.cornerRadius = 12
        quoteView.layer.cornerRadius = 20
        
        addTapGestureToView(doTodayView, identifier: "DoTodayViewController")
        addTapGestureToView(trackItView, identifier: "TrackItViewController")
        
    }
    
    private func addTapGestureToView(_ view: UIView, identifier: String) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToScreen(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        view.accessibilityIdentifier = identifier
    }
    
    @objc func goToScreen(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view, let identifier = view.accessibilityIdentifier else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: identifier)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func updateQuote() {
        ActivityIndicator.shared.showActivityIndicator(on: self.view, withAlpha: 1.0)
        
        homeViewModel = HomeViewModel()
        homeViewModel.bind = {
            guard let upwrapped_quote = self.homeViewModel.quote else {
                return
            }
            self.quote = upwrapped_quote
            DispatchQueue.main.async {
                ActivityIndicator.shared.hideActivityIndicator()
            }
        }
    }
}
