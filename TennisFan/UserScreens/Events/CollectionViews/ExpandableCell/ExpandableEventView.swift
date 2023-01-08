//
//  ExpandableContentView.swift
//  TennisFan
//
//  Created by OS on 22.11.2022.
//

import UIKit
protocol ExpandableEventInterface {
  
  func setupViews()
  func apply(configuration: ExpandableEventConfiguration)
  func setValus()
}

extension ExpandableEventView: ExpandableEventInterface {
  func setupViews() {
    addSubview(eventStack)
//    addSubview(dateStack)
    eventStack.translatesAutoresizingMaskIntoConstraints = false
//    dateStack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
//      dateStack.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
//      dateStack.bottomAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 40),
//      dateStack.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
      eventStack.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 10),
      eventStack.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -5),
      eventStack.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      eventStack.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor)
    ])
    invalidateIntrinsicContentSize()
  }
  func apply(configuration: ExpandableEventConfiguration) {
    guard currentConfiguration != configuration else {return}
    currentConfiguration = configuration
    eventDate.text = configuration.eventDate
    eventHour.text = configuration.eventHour
    homeCountry.text = configuration.homeCountry
    homeRanking.text = configuration.homeRanking
    homeImage.image = configuration.homeImage
    awayCountry.text = configuration.awayCountry
    awayRanking.text = configuration.awayRanking
    awayImage.image = configuration.awayImage
  }
  func setValus() {
    eventDate.text = currentConfiguration.eventDate
    eventHour.text = currentConfiguration.eventHour
    homeCountry.text = currentConfiguration.homeCountry
    homeRanking.text = currentConfiguration.homeRanking
    homeImage.image = currentConfiguration.homeImage
    awayCountry.text = currentConfiguration.awayCountry
    awayRanking.text = currentConfiguration.awayRanking
    awayImage.image = currentConfiguration.awayImage
  }
}
class ExpandableEventView: UIView, UIContentView {
  
  private var currentConfiguration: ExpandableEventConfiguration!
  
  // MARK: -Required property
  var configuration: UIContentConfiguration {
    get {
      currentConfiguration
    }
    set {
      guard let newConfiguration = newValue as? ExpandableEventConfiguration else {
        return
      }
      apply(configuration: newConfiguration)
    }
  }
  
  // MARK: -Custom Properties
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
  lazy var homeCountry: UILabel = {
    let homeName = UILabel()
    homeName.font = .preferredFont(forTextStyle: .subheadline)
    return homeName
  }()
  lazy var awayCountry: UILabel = {
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
    
    targetSign.image = UIImage(systemName: "directcurrent")
    targetSign.tintColor = .orange
    
    return targetSign
  }()
  lazy var eventStack: UIStackView = {
    let homeLabelStack = UIStackView(arrangedSubviews: [eventDate, homeCountry, homeRanking])
    homeLabelStack.axis = .vertical
    homeLabelStack.alignment = .trailing
    homeLabelStack.distribution = .fillProportionally
    let homeStack = UIStackView(arrangedSubviews: [homeImage, homeLabelStack])
    homeStack.axis = .horizontal
    homeStack.spacing = 3
    homeStack.alignment = .fill
    homeStack.distribution = .fillEqually
    let awayLabelStack = UIStackView(arrangedSubviews: [eventHour, awayCountry, awayRanking])
    awayLabelStack.axis = .vertical
    awayLabelStack.alignment = .leading
    awayLabelStack.distribution = .fillProportionally
    let awayStack = UIStackView(arrangedSubviews: [awayLabelStack, awayImage])
    awayStack.axis = .horizontal
    awayStack.spacing = 5
    awayStack.alignment = .fill
    awayStack.distribution = .fillEqually
    let eventStack = UIStackView(arrangedSubviews: [homeStack, targetSign, awayStack])
    eventStack.axis = .horizontal
    eventStack.spacing = 10
    eventStack.alignment = .center
    eventStack.distribution = .fillProportionally
    return eventStack
  }()
//  lazy var dateStack: UIStackView = {
//    let dateStack = UIStackView(arrangedSubviews: [eventDate, targetSign, eventHour])
//    dateStack.axis = .horizontal
//    dateStack.spacing = 5
//    dateStack.alignment = .center
//    dateStack.distribution = .fill
//    return dateStack
//  }()
  
  // MARK: -init contentView
  init(configuration: ExpandableEventConfiguration) {
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
}
