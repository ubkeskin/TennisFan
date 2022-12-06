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
    return bookMarkButton
  }()
  lazy var homeName: UILabel = {
    let homeName = UILabel()
    return homeName
  }()
  lazy var homeImage: UIImageView = {
    let homeImage = UIImageView()
    return homeImage
  }()
  lazy var awayName: UILabel = {
    let awayName = UILabel()
    return awayName
  }()
  lazy var awayImage: UIImageView = {
    let awayImage = UIImageView()
    return awayImage
  }()
  lazy var viewStack: UIStackView = {
    let imageStack = UIStackView(arrangedSubviews: [homeImage, awayImage])
    imageStack.alignment = .fill
    imageStack.distribution = .fillEqually
    imageStack.axis = .horizontal
    let nameStack = UIStackView(arrangedSubviews: [homeName, awayName])
    nameStack.axis = .horizontal
    nameStack.distribution = .fill
    nameStack.alignment = .fill
    let viewStack = UIStackView(arrangedSubviews: [imageStack, nameStack])
    viewStack.axis = .vertical
    viewStack.distribution = .fill
    viewStack.alignment = .fill
    return viewStack
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func layoutSubviews() {
    addSubview(viewStack)
    viewStack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      viewStack.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      viewStack.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
      viewStack.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      viewStack.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor)
    ])
  }
}
