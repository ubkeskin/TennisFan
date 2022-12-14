//
//  DetailViewController.swift
//  TennisFan
//
//  Created by OS on 2.12.2022.
//

import UIKit
protocol EventsDetailViewInterface: AnyObject {
  func configureDetailView()
}
extension EventsDetailViewController: EventsDetailViewInterface {
  func configureDetailView() {
    detailView.awayImage.image = UIImage(data: viewModel.imageDictionary!["awayImage"]!!)
    detailView.homeImage.image = UIImage(data: viewModel.imageDictionary!["homeImage"]!!)
  }
}

class EventsDetailViewController: UIViewController {
  let detailView: EventsDetailView = .init(frame: .zero)
  lazy var viewModel: EventsDetailViewModel = EventsDetailViewModel(view: self)
  
  override func viewDidLoad() {
    configureDetailView()
    setupUI()
  }
  private func setupUI() {
    view.addSubview(detailView)
    detailView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
  }
}
