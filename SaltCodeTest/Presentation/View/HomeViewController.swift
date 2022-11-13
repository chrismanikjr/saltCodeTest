//
//  ViewController.swift
//  SaltCodeTest
//
//  Created by Chrismanto Natanail Manik on 13/11/22.
//

import UIKit

class HomeViewController: UIViewController{
    
    private lazy var profileImage: UIImageView = {
        let imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.heightAnchor.constraint(equalToConstant: K.widthDf * 0.5).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: K.widthDf * 0.5).isActive = true
        return imgView
    }()
    
    private lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    private lazy var emailLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let viewModel = HomeViewModel()
    private var alert: UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fullName.bind { name in
            self.nameLabel.text = name
        }
        viewModel.email.bind { email in
            self.emailLabel.text = email
        }
        viewModel.imgValue.bind { image in
            self.profileImage.load(urlString: image)
        }
        viewModel.errorMessage.bind { message in
            let alertController = UIAlertController(title: "Errror Message",
                                                    message: message,
                                                    preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        setupUI()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchUser()
    }
    
    func setupUI(){        
        [profileImage, nameLabel, emailLabel].forEach{stackView.addArrangedSubview($0)}
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: K.widthDf * 0.8)
        ])
    }
}

