//
//  ExpandableContentView.swift
//  TennisFan
//
//  Created by OS on 22.11.2022.
//

import UIKit

class ExpandableContentView: UIView, UIContentView {
  private var currentConfiguration: ExpandableContentConfiguration!
  var configuration: UIContentConfiguration {
    get {
      currentConfiguration
    }
    set {
      guard let newConfiguration = newValue as? ExpandableContentConfiguration else {
        return
      }
      apply(configuration: newConfiguration)
    }
  }
  lazy var homeImage: UIImageView = {
    let homeImage = UIImageView()
    homeImage.image = currentConfiguration.homeImage
    homeImage.contentMode = .scaleAspectFit
    return homeImage
  }()
  lazy var awayImage: UIImageView = {
    let awayImage = UIImageView()
    awayImage.image = currentConfiguration.awayImage
    awayImage.contentMode = .scaleAspectFit
    return awayImage
  }()
  lazy var homeName: UILabel = {
    let homeName = UILabel()
    homeName.font = .preferredFont(forTextStyle: .subheadline)
    homeName.numberOfLines = 1
    homeName.text = currentConfiguration.homeName
    return homeName
  }()
  lazy var awayName: UILabel = {
    let awayName = UILabel()
    awayName.font = .preferredFont(forTextStyle: .subheadline)
    awayName.numberOfLines = 1
    awayName.text = currentConfiguration.awayName
    return awayName
  }()
  lazy var homeRanking: UILabel = {
    let homeRanking = UILabel()
    homeRanking.numberOfLines = 1
    homeRanking.text = currentConfiguration.homeRanking
    return homeRanking
  }()
  lazy var awayRanking: UILabel = {
    let awayRanking = UILabel()
    awayRanking.numberOfLines = 1
    awayRanking.text = currentConfiguration.awayRanking
    return awayRanking
  }()
  lazy var eventDate: UILabel = {
    let eventDate = UILabel()
    eventDate.numberOfLines = 0
    eventDate.text = currentConfiguration.eventDate
    return eventDate
  }()
  lazy var stackView: UIStackView = {
    let homeLabelStack = UIStackView(arrangedSubviews: [homeName, homeRanking])
    homeLabelStack.axis = .vertical
    homeLabelStack.alignment = .center
    homeLabelStack.distribution = .fill
    let homeStack = UIStackView(arrangedSubviews: [homeImage, homeLabelStack])
    homeStack.axis = .horizontal
    homeStack.alignment = .fill
    homeStack.distribution = .fillEqually
    let awayLabelStack = UIStackView(arrangedSubviews: [awayName, awayRanking])
    awayLabelStack.axis = .vertical
    awayLabelStack.alignment = .center
    awayLabelStack.distribution = .fill
    let awayStack = UIStackView(arrangedSubviews: [awayLabelStack, awayImage])
    awayStack.axis = .horizontal
    awayStack.alignment = .fill
    awayStack.distribution = .fillEqually
    let eventStack = UIStackView(arrangedSubviews: [homeStack, awayStack])
    eventStack.axis = .horizontal
    eventStack.spacing = 10
    eventStack.alignment = .fill
    eventStack.distribution = .fillEqually
//    let stackView = UIStackView(arrangedSubviews: [eventDate, eventStack])
//    stackView.axis = .vertical
//    stackView.spacing = 5
//    stackView.alignment = .fill
//    stackView.distribution = .fill
    return eventStack
  }()
  
  init(configuration: ExpandableContentConfiguration) {
    super.init(frame: .zero)
    currentConfiguration = configuration
    setupViews()
    apply(configuration: configuration)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func setupViews() {
    addSubview(stackView)
    addSubview(eventDate)
    eventDate.translatesAutoresizingMaskIntoConstraints = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      eventDate.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      eventDate.bottomAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 40),
      eventDate.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
      stackView.topAnchor.constraint(equalTo: eventDate.bottomAnchor, constant: 5),
      stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
      stackView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      stackView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
    ])
  }
  private func apply(configuration: ExpandableContentConfiguration) {
    guard currentConfiguration != configuration else {return}
    currentConfiguration = configuration
    
    homeName.text = configuration.homeName
    homeRanking.text = configuration.homeRanking
    homeImage.image = configuration.homeImage
    awayName.text = configuration.awayName
    awayRanking.text = configuration.awayRanking
    awayImage.image = configuration.awayImage
    
  }
}
