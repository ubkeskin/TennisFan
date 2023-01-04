//
//  LoginViewModel.swift
//  TennisFan
//
//  Created by OS on 14.11.2022.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

class LoginViewModel {
  var eMail: String?
  var password: String?
  
  func login(with eMail: String, password: String, controller: UIViewController) {
    Auth.auth().signIn(withEmail: eMail, password: password) { result, error in
      guard error == nil else { return controller.displayError(error) }
    }
  }
  func createUser(with eMail: String, password: String, controller: UIViewController) {
    Auth.auth().createUser(withEmail: eMail, password: password) { authResult, error in
      guard error == nil else { return controller.displayError(error) }
    }
  }
  func performGoogleSignInFlow(controller: UIViewController) {
    // Start the sign in flow!
    GIDSignIn.sharedInstance.signIn(withPresenting: controller) { [unowned self] user, error in
      guard error == nil,
            let idToken = user?.user.idToken?.tokenString,
            let accessToken = user?.user.accessToken.tokenString
      else { return controller.displayError(error) }
      
      let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
      Auth.auth().signIn(with: credential)
    }
  }
}
