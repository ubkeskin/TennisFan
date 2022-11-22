//
//  LoginViewController.swift
//  TennisFan
//
//  Created by OS on 14.11.2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
  let loginView = LoginView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
  var viewModel = LoginViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationItem.hidesBackButton = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
  private func setupUI() {
    view.addSubview(loginView)
    loginView.translatesAutoresizingMaskIntoConstraints = false
    loginView.gidButton.addTarget(self, action: #selector(startGoogleAuth), for: .touchUpInside)
    loginView.signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
    loginView.signInButton.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
    NSLayoutConstraint.activate([
      loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      loginView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
      loginView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
    ])
  }
  
    @objc func signInAction() {
    viewModel.login(with: loginView.eMailTextField.text ?? "", password: loginView.passwordTextField.text ?? "", controller: self)
  }
  @objc func signUpAction() {
    viewModel.createUser(with: loginView.eMailTextField.text ?? "", password: loginView.passwordTextField.text ?? "", controller: self)
  }
  @objc func startGoogleAuth() {
    viewModel.performGoogleSignInFlow(controller: self)
  }
}
