//
//  ViewController.swift
//  Demo App 2
//
//  Created by BrainX Technologies on 10/05/2023.
//

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        usernameTextFieldView.layer.cornerRadius = 10
        usernameTextFieldView.layer.borderWidth = 1
        usernameTextFieldView.layer.borderColor = UIColor(named: "textFieldBorder")?.cgColor
        
        passwordTextFieldView.layer.cornerRadius = 10
        passwordTextFieldView.layer.borderWidth = 1
        passwordTextFieldView.layer.borderColor = UIColor(named: "textFieldBorder")?.cgColor
        
        usernameTextField.borderStyle = .none
        passwordTextField.borderStyle = .none
        
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let username = usernameTextField.text, let password = passwordTextField.text {
            let levelUpAPI = LevelUpAPI()
            levelUpAPI.login(email: username.isEmpty ? "agent_0@mailinator.com" : username, password: password.isEmpty ? "123456" : password, completion: { [weak self] first_login in
                if first_login {
                    let destinationVC = storyboard.instantiateViewController(withIdentifier: "UpdatePasswordViewController") as! UpdatePasswordViewController
                    self?.navigationController?.pushViewController(destinationVC, animated: true)
                }
                else {
                    let destinationVC  = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
                    self?.navigationController?.pushViewController(destinationVC, animated: true)
                }
            })
        }
        
        
    }
    
    @objc func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
}



