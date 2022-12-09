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
  lazy var date: UILabel = {
    let date = UILabel()
    date.font = UIFont(name: "GillSans-Bold", size: 10)
    return date
  }()
  lazy var time: UILabel = {
    let time = UILabel()
    time.font = UIFont(name: "GillSans-Bold", size: 10)
    return time
  }()
  lazy var tournament: UILabel = {
    let tournament = UILabel()
    tournament.font = UIFont(name: "GillSans-Bold", size: 10)
    tournament.numberOfLines = 0
    return tournament
  }()
  lazy var round: UILabel = {
    let round = UILabel()
    round.font = UIFont(name: "GillSans-Bold", size: 10)
    return round
  }()
  lazy var homeRankingClass: UILabel = {
    let homeRankingClass = UILabel()
    homeRankingClass.font = UIFont(name: "GillSans", size: 12)
    return homeRankingClass
  }()
  lazy var homeCountry: UILabel = {
    let homeCountry = UILabel()
    homeCountry.font = UIFont(name: "GillSans", size: 12)
    return homeCountry
  }()
  lazy var homeRanking: UILabel = {
    let homeRanking = UILabel()
    homeRanking.font = UIFont(name: "GillSans", size: 12)
    return homeRanking
  }()
  lazy var homeBestRanking: UILabel = {
    let homeBestRanking = UILabel()
    homeBestRanking.font = UIFont(name: "GillSans", size: 12)
    return homeBestRanking
  }()
  lazy var homeTournamentsPlayed : UILabel = {
    let homeTournamentsPlayed = UILabel()
    homeTournamentsPlayed.font = UIFont(name: "GillSans", size: 12)
    homeTournamentsPlayed.numberOfLines = 2
    return homeTournamentsPlayed
  }()
  lazy var homeName: UILabel = {
    let homeName = UILabel()
    homeName.font = UIFont(name: "GillSans-Bold", size: 15)
    homeName.numberOfLines = 0
    homeName.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    homeName.setContentHuggingPriority(.defaultLow, for: .horizontal)
    return homeName
  }()
  lazy var homeImage: UIImageView = {
    let homeImage = UIImageView()
    return homeImage
  }()
  lazy var awayRankingClass: UILabel = {
    let awayRankingClass = UILabel()
    awayRankingClass.font = UIFont(name: "GillSans", size: 12)
    return awayRankingClass
  }()
  lazy var awayCountry: UILabel = {
    let awayCountry = UILabel()
    awayCountry.font = UIFont(name: "GillSans", size: 12)
    return awayCountry
  }()
  lazy var awayRanking: UILabel = {
    let awayRanking = UILabel()
    awayRanking.font = UIFont(name: "GillSans", size: 12)
    return awayRanking
  }()
  lazy var awayBestRanking: UILabel = {
    let awayBestRanking = UILabel()
    awayBestRanking.font = UIFont(name: "GillSans", size: 12)
    return awayBestRanking
  }()
  lazy var awayTournamentsPlayed : UILabel = {
    let awayTournamentsPlayed = UILabel()
    awayTournamentsPlayed.font = UIFont(name: "GillSans", size: 12)
    awayTournamentsPlayed.numberOfLines = 2
    return awayTournamentsPlayed
  }()
  lazy var awayName: UILabel = {
    let awayName = UILabel()
    awayName.font = UIFont(name: "GillSans-Bold", size: 15)
    awayName.numberOfLines = 0
    awayName.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    awayName.setContentHuggingPriority(.defaultLow, for: .horizontal)
    return awayName
  }()
  lazy var awayImage: UIImageView = {
    let awayImage = UIImageView()
    return awayImage
  }()
  lazy var playerImageStack: UIStackView = {
    let imageStack = UIStackView(arrangedSubviews: [homeImage, tournamentInfoStack, awayImage])
    imageStack.alignment = .fill
    imageStack.spacing = 30
    imageStack.distribution = .fillEqually
    imageStack.axis = .horizontal
    return imageStack
  }()
  lazy var tournamentInfoStack: UIStackView = {
    let dateTimeStack = UIStackView(arrangedSubviews: [date, time])
    dateTimeStack.axis = .horizontal
    dateTimeStack.alignment = .fill
    dateTimeStack.distribution = .fillEqually
    let tournamentInfoStack = UIStackView(arrangedSubviews: [dateTimeStack, tournament, round])
    tournamentInfoStack.axis = .vertical
    tournamentInfoStack.distribution = .fillEqually
    tournamentInfoStack.alignment = .fill
    return tournamentInfoStack
  }()
  lazy var playerInfoStack: UIStackView = {
    let nameStack = UIStackView(arrangedSubviews: [homeName, awayName])
    nameStack.axis = .horizontal
    nameStack.distribution = .equalCentering
    nameStack.alignment = .center
    let rankingStack = UIStackView(arrangedSubviews: [homeRanking, awayRanking])
    rankingStack.axis = .horizontal
    rankingStack.spacing = 25
    rankingStack.distribution = .equalSpacing
    rankingStack.alignment = .center
    let bestRanking = UIStackView(arrangedSubviews: [homeBestRanking, awayBestRanking])
    bestRanking.axis = .horizontal
    bestRanking.spacing = 25
    bestRanking.distribution = .equalSpacing
    bestRanking.alignment = .center
    let country = UIStackView(arrangedSubviews: [homeCountry, awayCountry])
    country.axis = .horizontal
    country.spacing = 25
    country.distribution = .equalSpacing
    country.alignment = .center
    let tournamentsPlayed = UIStackView(arrangedSubviews: [homeTournamentsPlayed, awayTournamentsPlayed])
    tournamentsPlayed.axis = .horizontal
    tournamentsPlayed.spacing = 25
    tournamentsPlayed.distribution = .equalSpacing
    tournamentsPlayed.alignment = .center
    let viewStack = UIStackView(arrangedSubviews: [nameStack, country, tournamentsPlayed,
                                                   rankingStack, bestRanking])
    viewStack.axis = .vertical
    viewStack.distribution = .fillEqually
    viewStack.alignment = .fill
    viewStack.spacing = 30
    return viewStack
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func layoutSubviews() {
    addSubview(playerImageStack)
    addSubview(playerInfoStack)
    addSubview(bookMarkButton)
    playerImageStack.translatesAutoresizingMaskIntoConstraints = false
    playerInfoStack.translatesAutoresizingMaskIntoConstraints = false
    bookMarkButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      playerImageStack.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor, constant: 130),
      playerImageStack.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.topAnchor, constant: 250),
      playerImageStack.leftAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.leftAnchor, constant: 10),
      playerImageStack.rightAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.rightAnchor, constant: -10),
      playerInfoStack.topAnchor.constraint(equalTo: playerImageStack.bottomAnchor, constant: 10),
      playerInfoStack.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor, constant: -10),
      playerInfoStack.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: 10),
      playerInfoStack.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -10),
      bookMarkButton.topAnchor.constraint(greaterThanOrEqualTo: playerInfoStack.bottomAnchor, constant: 10),
      bookMarkButton.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor, constant: -10),
      bookMarkButton.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: 10),
      bookMarkButton.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -10)
    ])
  }
}
