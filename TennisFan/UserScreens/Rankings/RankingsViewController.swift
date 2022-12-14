//
//  RankingsViewController.swift
//  TennisFan
//
//  Created by OS on 14.12.2022.
//

import UIKit

protocol RankingsViewInterface: AnyObject {
  
}
extension RankingsViewController: RankingsViewInterface {
  
}

class RankingsViewController: UIViewController {
  lazy var viewModel: RankingsViewModel = { RankingsViewModel(view: self) }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}
