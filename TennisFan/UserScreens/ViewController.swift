//
//  ViewController.swift
//  TennisFan
//
//  Created by OS on 14.11.2022.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
  var button = UIButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.addSubview(button)
    navigationItem.hidesBackButton = true
    button.addTarget(self, action: #selector (signCurrentUserOut), for: .allTouchEvents)
    button.translatesAutoresizingMaskIntoConstraints = false
    navigationController?.setToolbarHidden(true, animated: false)
    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
      button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100),
      button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100)])
  }
  
  @objc public func signCurrentUserOut() {
    try? Auth.auth().signOut()
  }
}

