//
//  SearchVC.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 22.08.2023.
//

import UIKit

class SearchVC: UIViewController {

    // MARK: - UI Elements
    private let logoImageView = UIImageView()
    private let usernameTextField = GFTextField()
    private let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    // computed property
    var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureKeyboardDismiss()
        configureLogoImageView()
        configureUsernameTextField()
        configureCallToActionButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        usernameTextField.text = ""
    }
    
    
    // MARK: - Functions
    private func configureKeyboardDismiss() {
        view.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func keyboardDismiss(){
        view.endEditing(true)
    }
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        // Constraints
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
        ])
        // view.safeAreaLayoutGuide == Safe Area
    }
    
    private func configureUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(callToActionButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func callToActionButtonTapped() {
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(alertTitle: "Empty Username",
                                       message: "Please enter a username. We need to know who to look for 🙂",
                                       buttonTitle: "OK")
            return
        }
        
        let vc = FollowerListVC()
        vc.username = usernameTextField.text
        vc.title = usernameTextField.text
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        callToActionButtonTapped()
        return true
    }
}
