import Combine
import SVGKit
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var appLogo: UIImageView!
    @IBOutlet weak var usernameTextFieldView: UIView!
    @IBOutlet weak var passwordTextFieldView: UIView!
    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextFieldView.layer.cornerRadius = 10
        usernameTextFieldView.layer.borderWidth = 1
        usernameTextFieldView.layer.borderColor = UIColor(named: "textFieldBorder")?.cgColor
        
        passwordTextFieldView.layer.cornerRadius = 10
        passwordTextFieldView.layer.borderWidth = 1
        passwordTextFieldView.layer.borderColor = UIColor(named: "textFieldBorder")?.cgColor
        
        usernameTextField.borderStyle = .none
        usernameTextField.text = "agent_0@mailinator.com"
        passwordTextField.borderStyle = .none
        passwordTextField.text = "123456"
        
        let passwordTextFieldTrailingIcon = UIImageView(image: UIImage(named: "eye"))
        passwordTextField.rightView = passwordTextFieldTrailingIcon
        passwordTextField.rightViewMode = .always
        passwordTextField.isSecureTextEntry = true
        let trailingIconTapGesture = UITapGestureRecognizer(target: self, action: #selector(togglePasswordVisibility))
        passwordTextFieldTrailingIcon.isUserInteractionEnabled = true
        passwordTextFieldTrailingIcon.addGestureRecognizer(trailingIconTapGesture)
        
        loginButton.layer.cornerRadius = 10
        let currentFont = loginButton.titleLabel?.font
        let boldFont = UIFont.boldSystemFont(ofSize: currentFont?.pointSize ?? 16)
        loginButton.titleLabel?.font = boldFont
        navigationController?.navigationBar.isHidden = true
        
    }
    
    @IBAction func login( _ sender: UIButton) {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            
            ActivityIndicator.shared.showActivityIndicator(on: self.view, withAlpha: 0.5)
            
            let username = username.isEmpty ? "agent_0@mailinator.com" : username
            let password = password.isEmpty ? "123456" : password
            viewModel = LoginViewModel(email: username, password: password)
            
            viewModel.$user
                .sink { user in
                    guard let user else {
                        return
                    }
                    switch user {
                    case .newUser:
                        pushViewController(UpdatePasswordViewController.self, fromStoryboard: "Main", navigationController: self.navigationController)
                    case .existingUser:
                        pushViewController(UpdatePasswordViewController.self, fromStoryboard: "Main", navigationController: self.navigationController)
                    case .invalidUser:
                        showErrorAlert(title: "Error", message: "Unable to verify credentials")
                    }
                    
                    ActivityIndicator.shared.hideActivityIndicator()
                }
                .store(in: &viewModel.cancellables)
        }
    }
    
    @objc func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
    }
}



