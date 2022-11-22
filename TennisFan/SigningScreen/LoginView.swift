//
//  LoginView.swift
//  TennisFan
//
//  Created by OS on 14.11.2022.
//

import UIKit
import GoogleSignIn

class LoginView: UIView {
  var signInButton: UIButton = UIButton(type: .roundedRect)
  var signUpButton: UIButton = UIButton(type: .roundedRect)
  var gidButton: GIDSignInButton = GIDSignInButton()
  
  lazy var eMail: UILabel = {
    let eMail = UILabel()
    eMail.font = UIFont(name: "GillSans-Bold", size: 15)
    eMail.text = "E-Mail"
    eMail.textColor = .white
    return eMail
  }()
  lazy var password: UILabel = {
    let password = UILabel()
    password.font = UIFont(name: "GillSans-Bold", size: 15)
    password.text = "Password"
    password.textColor = .white
    return password
  }()
  lazy var eMailTextField: UITextField = {
    let eMailTextField = UITextField()
    eMailTextField.backgroundColor = .white
    eMailTextField.font = UIFont(name: "GillSans-Bold", size: 15)
    eMailTextField.placeholder = "Enter your accounts E-mail address"
    return eMailTextField
  }()
  lazy var passwordTextField: UITextField = {
    let passwordTextField = UITextField()
    passwordTextField.backgroundColor = .white
    passwordTextField.font = UIFont(name: "GillSans-Bold", size: 15)
    passwordTextField.placeholder = "Enter your password"
    return passwordTextField
  }()
  lazy var stacks: UIStackView = {
    signInButton.setTitle("Sign In", for: .normal)
    signInButton.titleEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
    signInButton.backgroundColor = .white
    signInButton.setTitleColor(.black, for: .normal)
    signInButton.layer.cornerRadius = 5

    signUpButton.setTitle("Sign Up", for: .normal)
    signUpButton.titleEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
    signUpButton.backgroundColor = .yellow
    signUpButton.layer.cornerRadius = 5
    signUpButton.setTitleColor(.black, for: .normal)
    let or = UILabel()
    or.text = "-or-"
    or.textColor = .white
    
    let buttonStack = UIStackView(arrangedSubviews: [signInButton, signUpButton])
    buttonStack.axis = .horizontal
    buttonStack.alignment = .fill
    buttonStack.distribution = .fillEqually
    buttonStack.spacing = 4
    
    let labelStack = UIStackView(arrangedSubviews: [eMail, password])
    labelStack.axis = .vertical
    labelStack.spacing = 10
    labelStack.distribution = .fillProportionally
    let textFieldsStack = UIStackView(arrangedSubviews: [eMailTextField, passwordTextField])
    textFieldsStack.axis = .vertical
    textFieldsStack.spacing = 10
    textFieldsStack.distribution = .fillProportionally
    let labelFieldStack = UIStackView(arrangedSubviews: [labelStack, textFieldsStack])
    labelFieldStack.axis = .horizontal
    labelFieldStack.spacing = 10
    labelFieldStack.distribution = .fillProportionally
    labelFieldStack.alignment = .center
    let manuelLoginStack = UIStackView(arrangedSubviews: [labelFieldStack, buttonStack])
    manuelLoginStack.axis = .vertical
    manuelLoginStack.spacing = 10
    manuelLoginStack.alignment = .fill
    manuelLoginStack.distribution = .fill
    let loginStack = UIStackView(arrangedSubviews: [manuelLoginStack, or, gidButton])
    loginStack.axis = .vertical
    loginStack.alignment = .center
    loginStack.distribution = .fill
    loginStack.translatesAutoresizingMaskIntoConstraints = false
    return loginStack
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func layoutSubviews() {
    addSubview(stacks)
    NSLayoutConstraint.activate([
      stacks.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 10),
      stacks.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10),
      stacks.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
      stacks.rightAnchor.constraint(equalTo: rightAnchor, constant: 10),
      stacks.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
