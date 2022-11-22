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
    homeName.text = currentConfiguration.homeName
    return homeName
  }()
  lazy var awayName: UILabel = {
    let awayName = UILabel()
    awayName.text = currentConfiguration.awayName
    return awayName
  }()
  lazy var homeRanking: UILabel = {
    let homeRanking = UILabel()
    homeRanking.text = currentConfiguration.homeRanking
    return homeRanking
  }()
  lazy var awayRanking: UILabel = {
    let awayRanking = UILabel()
    awayRanking.text = currentConfiguration.awayRanking
    return awayRanking
  }()
  lazy var stackView: UIStackView = {
    let homeLabelStack = UIStackView(arrangedSubviews: [homeName, homeRanking])
    homeLabelStack.axis = .vertical
    homeLabelStack.alignment = .leading
    homeLabelStack.distribution = .equalCentering
    let homeStack = UIStackView(arrangedSubviews: [/*homeImage,*/ homeLabelStack])
    homeStack.axis = .horizontal
    homeStack.alignment = .fill
    homeStack.distribution = .fillEqually
    let awayLabelStack = UIStackView(arrangedSubviews: [awayName, awayRanking])
    awayLabelStack.axis = .vertical
    awayLabelStack.alignment = .leading
    awayLabelStack.distribution = .equalCentering
    let awayStack = UIStackView(arrangedSubviews: [/*awayImage,*/ awayLabelStack])
    awayStack.axis = .horizontal
    awayStack.alignment = .fill
    awayStack.distribution = .fillEqually
    let stackView = UIStackView(arrangedSubviews: [homeStack, awayStack])
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    return stackView
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
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
      stackView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      stackView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor)
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
