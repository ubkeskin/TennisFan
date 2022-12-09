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
    detailView.tournament.text = "\(viewModel.tournament)"
    detailView.date.text = "\(viewModel.date)"
    detailView.time.text = "\(viewModel.time)"
    detailView.round.text = "\(viewModel.round)"
    detailView.homeBestRanking.text = "best ranking: \(viewModel.homeBestRanking)"
    detailView.awayBestRanking.text = "best ranking: \(viewModel.awayBestRanking)"
    detailView.homeCountry.text = "country: \(viewModel.homeCountry)"
    detailView.awayCountry.text = "country: \(viewModel.awayCountry)"
    detailView.homeTournamentsPlayed.text = "tournaments \nplayed: \(viewModel.homeTournamentsPlayed)"
    detailView.awayTournamentsPlayed.text = "tournaments \nplayed: \(viewModel.awayTournamentsPlayed)"
    detailView.homeRanking.text = "ranking: \(viewModel.homeRanking)"
    detailView.awayRanking.text = "ranking: \(viewModel.awayRanking)"
    detailView.awayName.text = viewModel.awayName.capitalized
    detailView.homeName.text = viewModel.homeName.capitalized
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
