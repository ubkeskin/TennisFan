//
//  DetailView.swift
//  TennisFan
//
//  Created by OS on 2.12.2022.
//

import UIKit

class EventsDetailView: UIView {
  lazy var bookMarkButton: UIButton = {
    let bookMarkButton = UIButton()
    bookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
    return bookMarkButton
  }()
  lazy var homeRanking: UILabel = {
    let homeRanking = UILabel()
    return homeRanking
  }()
  lazy var homeBestRanking: UILabel = {
    let homeBestRanking = UILabel()
    return homeBestRanking
  }()
  lazy var homeName: UILabel = {
    let homeName = UILabel()
    return homeName
  }()
  lazy var homeImage: UIImageView = {
    let homeImage = UIImageView()
    return homeImage
  }()
  lazy var awayRanking: UILabel = {
    let awayRanking = UILabel()
    return awayRanking
  }()
  lazy var awayBestRanking: UILabel = {
    let awayBestRanking = UILabel()
    return awayBestRanking
  }()
  lazy var awayName: UILabel = {
    let awayName = UILabel()
    return awayName
  }()
  lazy var awayImage: UIImageView = {
    let awayImage = UIImageView()
    return awayImage
  }()
  lazy var labelStack: UIStackView = {
    let nameStack = UIStackView(arrangedSubviews: [homeName, awayName])
    nameStack.axis = .horizontal
    nameStack.distribution = .equalSpacing
    nameStack.alignment = .center
    let rankingStack = UIStackView(arrangedSubviews: [homeRanking, awayRanking])
    rankingStack.axis = .horizontal
    rankingStack.spacing = 25
    rankingStack.distribution = .equalSpacing
    rankingStack.alignment = .center
    let viewStack = UIStackView(arrangedSubviews: [nameStack, rankingStack])
    viewStack.axis = .vertical
    viewStack.distribution = .fillEqually
    viewStack.alignment = .fill
    viewStack.spacing = 30
    return viewStack
  }()
  lazy var imageStack: UIStackView = {
    let imageStack = UIStackView(arrangedSubviews: [homeImage, awayImage])
    imageStack.alignment = .fill
    imageStack.spacing = 30
    imageStack.distribution = .fillEqually
    imageStack.axis = .horizontal
    return imageStack
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func layoutSubviews() {
    addSubview(imageStack)
    addSubview(labelStack)
    addSubview(bookMarkButton)
    imageStack.translatesAutoresizingMaskIntoConstraints = false
    labelStack.translatesAutoresizingMaskIntoConstraints = false
    bookMarkButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageStack.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor, constant: 10),
      imageStack.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.topAnchor, constant: 130),
      imageStack.leftAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.leftAnchor, constant: 10),
      imageStack.rightAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.rightAnchor, constant: -10),
      labelStack.topAnchor.constraint(equalTo: imageStack.bottomAnchor, constant: 10),
      labelStack.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor, constant: -10),
      labelStack.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: 10),
      labelStack.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -10),
      bookMarkButton.topAnchor.constraint(greaterThanOrEqualTo: labelStack.bottomAnchor, constant: 10),
      bookMarkButton.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor, constant: -10),
      bookMarkButton.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: 10),
      bookMarkButton.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -10)
    ])
  }
}
