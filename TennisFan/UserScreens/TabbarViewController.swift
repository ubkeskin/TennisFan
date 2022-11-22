//
//  TabBarController.swift
//  TennisFan
//
//  Created by OS on 14.11.2022.
//

import UIKit

class TabbarViewController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
//    navigationItem.hidesBackButton = true
    view.backgroundColor = .white
    navigationItem.hidesBackButton = true
    UITabBar.appearance().barTintColor = .systemBackground
    tabBar.tintColor = .label
    setupVCs()
  }
  
  fileprivate func createNavController(for rootViewController: UIViewController,
                                       title: String,
                                       image: UIImage) -> UIViewController
  {
    let navController = UINavigationController(rootViewController: rootViewController)
    navController.tabBarItem.title = title
    navController.tabBarItem.image = image
    navController.navigationBar.prefersLargeTitles = true
    navController.setToolbarHidden(true, animated: true)
    rootViewController.navigationItem.title = title
    return navController
  }
  
  func setupVCs() {
    viewControllers = [
      createNavController(for:EventsViewController(), title: NSLocalizedString("Events", comment: ""), image: UIImage(systemName: "bolt.shield")!),
      createNavController(for: ViewController(), title: NSLocalizedString("Rankings", comment: ""), image: UIImage(systemName: "crown")!),
      createNavController(for: ViewController(), title: NSLocalizedString("Favorites", comment: ""), image: UIImage(systemName: "star")!),
      createNavController(for: ViewController(), title: NSLocalizedString("WatchList", comment: ""), image: UIImage(systemName: "bookmark")!)
    ]
  }
}
