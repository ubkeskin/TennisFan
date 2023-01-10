//
//  FavoriteContentView.swift
//  TennisFan
//
//  Created by OS on 9.01.2023.
//

import UIKit

protocol FavoriteContentViewInterface {
  func setupViews()
  func apply(configuration: FavoriteConfiguration)
  func setValus()
}

extension FavoriteContentView: FavoriteContentViewInterface {
  func setupViews() {
    addSubview(imageLabelStack)
    imageLabelStack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageLabelStack.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      imageLabelStack.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
      imageLabelStack.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: 10),
      imageLabelStack.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -10)
    ])
  }
  
  func apply(configuration: FavoriteConfiguration) {
    guard currentConfiguration != configuration else {return}
    currentConfiguration = configuration
    image.image = configuration.image
    bestRanking.text = configuration.bestRanking
    ranking.text = configuration.ranking
    country.text = configuration.country
    tournamentsPlayed.text = configuration.tournamentsPlayed
  }
  
  func setValus() {
    image.image = currentConfiguration.image
    bestRanking.text = currentConfiguration.bestRanking
    ranking.text = currentConfiguration.ranking
    country.text = currentConfiguration.country
    tournamentsPlayed.text = currentConfiguration.tournamentsPlayed
  }
  
  
}

class FavoriteContentView: UIView, UIContentView {
  // MARK: -Required properties
  private var currentConfiguration: FavoriteConfiguration!
  var configuration: UIContentConfiguration {
    get {
      currentConfiguration
    }
    set {
      guard let newConfiguration = newValue as? FavoriteConfiguration else {
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
  lazy var labelStack: UIStackView = {
    let labelStack = UIStackView(arrangedSubviews: [bestRanking, ranking, country, tournamentsPlayed])
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
  
  init(configuration: FavoriteConfiguration) {
    super.init(frame: .zero)
    self.currentConfiguration = configuration
    setValus()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func layoutSubviews() {
    setupViews()
  }
}
