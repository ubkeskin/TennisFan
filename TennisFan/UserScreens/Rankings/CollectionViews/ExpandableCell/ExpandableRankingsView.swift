//
//  ExpandableRankingsView.swift
//  TennisFan
//
//  Created by OS on 16.12.2022.
//

import UIKit
import FirebaseAuth

protocol ExpandableRankingsInterface {
  
  func setupViews()
  func apply(configuration: ExpandableRankingsConfiguration)
  func setValus()
}
extension ExpandableRankingsView: ExpandableRankingsInterface {
  func setupViews() {
    addSubview(imageLabelStack)
    imageLabelStack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageLabelStack.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      imageLabelStack.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
      imageLabelStack.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
    ])
    invalidateIntrinsicContentSize()
  }
  func apply(configuration: ExpandableRankingsConfiguration) {
    guard currentConfiguration != configuration else {return}
    currentConfiguration = configuration
    addToFavorites.isSelected = configuration.isFavorite ?? false
    image.image = configuration.image
    bestRanking.text = configuration.bestRanking
    ranking.text = configuration.ranking
    country.text = configuration.country
    tournamentsPlayed.text = configuration.tournamentsPlayed
  }
  func setValus() {
    addToFavorites.isSelected = currentConfiguration.isFavorite ?? false
    image.image = currentConfiguration.image
    bestRanking.text = currentConfiguration.bestRanking
    ranking.text = currentConfiguration.ranking
    country.text = currentConfiguration.country
    tournamentsPlayed.text = currentConfiguration.tournamentsPlayed
  }
}

class ExpandableRankingsView: UIView, UIContentView {
  
// MARK: -Required properties
  private var currentConfiguration: ExpandableRankingsConfiguration!
  var configuration: UIContentConfiguration {
    get {
      currentConfiguration
    }
    set {
      guard let newConfiguration = newValue as? ExpandableRankingsConfiguration else {
        return
      }
      apply(configuration: newConfiguration)
    }
  }
  // MARK: -Custom Properties
  lazy var image: UIImageView = {
    let homeImage = UIImageView()
    homeImage.contentMode = .scaleAspectFit
    return homeImage
  }()
  lazy var bestRanking: UILabel = {
    let homeName = UILabel()
    homeName.font = UIFont(name: "GillSans", size: 15)
    return homeName
  }()
  lazy var ranking: UILabel = {
    let homeRanking = UILabel()
    homeRanking.font = UIFont(name: "GillSans", size: 15)
    homeRanking.numberOfLines = 1
    return homeRanking
  }()
  lazy var country: UILabel = {
    let country = UILabel()
    country.font = UIFont(name: "GillSans", size: 15)
    return country
  }()
  lazy var tournamentsPlayed: UILabel = {
    let tournamentsPlayed = UILabel()
    tournamentsPlayed.font = UIFont(name: "GillSans", size: 15)
    return tournamentsPlayed
  }()
  lazy var addToFavorites: UIButton = {
    let addToFavorites = UIButton(type: .system)
    addToFavorites.setImage(UIImage(systemName: "star"), for: .normal)
    addToFavorites.setImage(UIImage(systemName: "star.fill"), for: .selected)
    addToFavorites.addTarget(self, action: #selector(setFavoriteState), for: .touchUpInside)
    return addToFavorites
  }()
  lazy var labelStack: UIStackView = {
    let labelStack = UIStackView(arrangedSubviews: [bestRanking, ranking, country, tournamentsPlayed, addToFavorites])
    labelStack.axis = .vertical
    labelStack.alignment = .leading
    labelStack.distribution = .fillEqually
    return labelStack
  }()
  lazy var imageLabelStack: UIStackView = {
    let imageLabelStack = UIStackView(arrangedSubviews: [image, labelStack])
    imageLabelStack.axis = .horizontal
    imageLabelStack.alignment = .fill
    imageLabelStack.distribution = .fillEqually
    return imageLabelStack
  }()

  
  init(configuration: ExpandableRankingsConfiguration) {
    super.init(frame: .zero)
    currentConfiguration = configuration
    setValus()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func layoutSubviews() {
    setupViews()
  }
  @objc private func setFavoriteState(sender: UIButton) {
    let userID = currentConfiguration.userID!
    let gender = currentConfiguration.gender
    let playerID = currentConfiguration.id
    sender.isSelected.toggle()
    if sender.isSelected {
      // Write data on Firestore
      let _ = AppDelegate.db.collection("\(userID)_favorites").document("\(gender ?? "")_\(playerID ?? "")").setData([:])
    } else {
      // Read data on Firestore
      let docRef = AppDelegate.db.collection("\(userID)_favorites").document("\(gender ?? "")_\(playerID ?? "")")
      docRef.getDocument { documentSnapshot, error in
        if let ds = documentSnapshot, ds.exists {
          docRef.delete()
        }
      }
    }
  }
}

