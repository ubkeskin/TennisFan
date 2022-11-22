//
//  RootViewModal.swift
//  TennisFan
//
//  Created by OS on 16.11.2022.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

protocol RootViewInterface {
  func handleAuthentication(completion: @escaping (UIViewController) -> ())
}
extension RootViewInterface {
  func handleAuthentication(completion: @escaping (UIViewController) -> ()) {
    Auth.auth().addStateDidChangeListener { auth, user in
      var vc = UIViewController()
      if user != nil {
        vc = TabbarViewController()
        completion(vc)
      } else {
        vc = LoginViewController()
        completion(vc)
      }
    }
  }
}
class RootViewModal: RootViewInterface {
  var user: User? = Auth.auth().currentUser
  var sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
  lazy var window: UIWindow? = { (sceneDelegate?.window) }()
}

