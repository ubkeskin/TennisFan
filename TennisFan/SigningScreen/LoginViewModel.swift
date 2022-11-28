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
    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    // Create Google Sign In configuration object.
    let config = GIDConfiguration(clientID: clientID)
    // Start the sign in flow!
    GIDSignIn.sharedInstance.signIn(with: config, presenting: controller) { [unowned self] user, error in
      
      guard error == nil else { return controller.displayError(error) }
      guard
        let authentication = user?.authentication,
        let idToken = authentication.idToken
      else {
        let error = NSError(
          domain: "GIDSignInError",
          code: -1,
          userInfo: [
            NSLocalizedDescriptionKey: "Unexpected sign in result: required authentication data is missing.",
          ]
        )
        return controller.displayError(error)
      }
      let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                     accessToken: authentication.accessToken)
      Auth.auth().signIn(with: credential) { result, error in
        guard error == nil else {
          print(error.debugDescription)
          return
        }
        // Logic
      }
    }
  }
}
