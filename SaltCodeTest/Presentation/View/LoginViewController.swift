//
//  LoginViewController.swift
//  SaltCodeTest
//
//  Created by Chrismanto Natanail Manik on 13/11/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    private lazy var emailTextField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Email"
        txtField.textColor = .black
        txtField.layer.borderWidth = 1
        txtField.clipsToBounds = true
        txtField.layer.cornerRadius = 3
        txtField.textColor = .black
        txtField.autocapitalizationType = .none
        txtField.layer.borderColor = UIColor.lightGray.cgColor
        txtField.setLeftPaddingPoints(20)
        txtField.setRightPaddingPoints(20)
        
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    private lazy var passwordTextField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Password"
        txtField.textColor = .black
        txtField.layer.borderWidth = 1
        txtField.layer.borderColor = UIColor.lightGray.cgColor
        txtField.textColor = .black
        txtField.setRightPaddingPoints(42)
        txtField.setShowHideRightIcon()
        txtField.setLeftPaddingPoints(20)
        txtField.clipsToBounds = true
        txtField.layer.cornerRadius = 3
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    private lazy var loginBtn: UIButton = {
        let btn  = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .blue
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(loginTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var alert: UIAlertController?
    
    private let viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
        
        viewModel.errorMessage.bind { message in
            let alertController = UIAlertController(title: "Errror Message",
                                                    message: message,
                                                    preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func setupUI(){
        [emailTextField, passwordTextField, loginBtn].forEach{stackView.addArrangedSubview($0)}
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: K.widthDf * 0.8),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            loginBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func loginTapped(_ sender: UIButton){
        viewModel.login(emailTextField.text ?? "", password: passwordTextField.text ?? "")
        print(viewModel.toLogin.value)
        viewModel.toLogin.bind { value in
            if value{
                let mainVC = HomeViewController()
                mainVC.modalPresentationStyle = .fullScreen
                mainVC.modalTransitionStyle = .crossDissolve
                self.present(mainVC, animated: true, completion: nil)
            }
        }
    }
    
}
