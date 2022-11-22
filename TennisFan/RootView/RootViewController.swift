//
//  RootViewController.swift
//  TennisFan
//
//  Created by OS on 16.11.2022.
//

import UIKit

class RootViewController: UINavigationController, UINavigationControllerDelegate {
  var rootViewModal = RootViewModal()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    rootViewModal.handleAuthentication { vc in
      self.popToRootViewController(animated: false)
      self.pushViewController(vc, animated: false)
    }
  }
}
