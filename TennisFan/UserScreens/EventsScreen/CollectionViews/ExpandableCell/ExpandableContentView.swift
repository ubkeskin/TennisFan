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
    homeImage.contentMode = .scaleAspectFit
    return homeImage
  }()
  lazy var awayImage: UIImageView = {
    let awayImage = UIImageView()
    awayImage.contentMode = .scaleAspectFit
    return awayImage
  }()
  lazy var homeName: UILabel = {
    let homeName = UILabel()
    homeName.font = .preferredFont(forTextStyle: .subheadline)
    return homeName
  }()
  lazy var awayName: UILabel = {
    let awayName = UILabel()
    awayName.font = .preferredFont(forTextStyle: .subheadline)
    return awayName
  }()
  lazy var homeRanking: UILabel = {
    let homeRanking = UILabel()
    homeRanking.numberOfLines = 1
    return homeRanking
  }()
  lazy var awayRanking: UILabel = {
    let awayRanking = UILabel()
    awayRanking.numberOfLines = 1
    return awayRanking
  }()
  lazy var eventDate: UILabel = {
    let eventDate = UILabel()
    eventDate.numberOfLines = 0
    return eventDate
  }()
  lazy var eventHour: UILabel = {
    let eventHour = UILabel()
    eventHour.numberOfLines = 0
    return eventHour
  }()
  lazy var targetSign: UIImageView = {
    let targetSign = UIImageView()
    
    targetSign.image = UIImage(systemName: "circle.circle")
    targetSign.tintColor = .orange
    
    return targetSign
  }()
  lazy var eventStack: UIStackView = {
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
    return eventStack
  }()
  lazy var dateStack: UIStackView = {
    let dateStack = UIStackView(arrangedSubviews: [eventDate, targetSign, eventHour])
    dateStack.axis = .horizontal
    dateStack.spacing = 5
    dateStack.alignment = .center
    dateStack.distribution = .fill
    return dateStack
  }()
  
  init(configuration: ExpandableContentConfiguration) {
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
  private func setupViews() {
    addSubview(eventStack)
    addSubview(dateStack)
    eventStack.translatesAutoresizingMaskIntoConstraints = false
    dateStack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dateStack.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      dateStack.bottomAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 40),
      dateStack.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
      eventStack.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 50),
      eventStack.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -5),
      eventStack.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      eventStack.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor)
    ])
    invalidateIntrinsicContentSize()
  }
  private func apply(configuration: ExpandableContentConfiguration) {
    guard currentConfiguration != configuration else {return}
    currentConfiguration = configuration
    eventDate.text = configuration.eventDate
    eventHour.text = configuration.eventHour
    homeName.text = configuration.homeName
    homeRanking.text = configuration.homeRanking
    homeImage.image = configuration.homeImage
    awayName.text = configuration.awayName
    awayRanking.text = configuration.awayRanking
    awayImage.image = configuration.awayImage
  }
  private func setValus() {
    eventDate.text = currentConfiguration.eventDate
    eventHour.text = currentConfiguration.eventHour
    homeName.text = currentConfiguration.homeName
    homeRanking.text = currentConfiguration.homeRanking
    homeImage.image = currentConfiguration.homeImage
    awayName.text = currentConfiguration.awayName
    awayRanking.text = currentConfiguration.awayRanking
    awayImage.image = currentConfiguration.awayImage
  }
}
