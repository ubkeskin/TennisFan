//
//  CollectionViewExpandableCell.swift
//  TennisFan
//
//  Created by OS on 16.11.2022.
//

import UIKit
import SwiftFlags
import Kingfisher
import Alamofire

protocol ExpandableEventViewCellInterface {
  func setHomeImage(with url: URL, completion: @escaping ()->())
  func setAwayImage(with url: URL, completion: @escaping ()->())
  func setHomeRanking(with id: Int, completion: @escaping ()->())
  func setAwayRanking(with id: Int, completion: @escaping ()->())
  func setConfiguration(for configuration: inout ExpandableEventConfiguration,
                        eventDate: String,
                        eventHour: String,
                        homeCountry: String,
                        homeRanking: [Ranking],
                        awayCountry: String,
                        awayRanking: [Ranking],
                        awayImage: UIImage?,
                        homeImage: UIImage?)
  func setEventDate() -> String
  func setEventHour() -> String
}

extension ExpandableEventViewCell: ExpandableEventViewCellInterface {
  func setHomeImage(with url: URL,
                            completion: @escaping ()-> ()) {
    let requestModifier0 = AnyModifier { request in
      var r = request
      r.setValue("4e8027dec2msh34dd0d1a79d5e4ap14d17fjsnfacdb846ca3e",
                 forHTTPHeaderField: "X-RapidAPI-Key")
      return r
    }
    let imageView = UIImageView()
    
    imageView.kf.setImage(with: url, options: [.requestModifier(requestModifier0)]) {
      result in
      switch result {
        case .success(let image):
          self.homeImage = UIImageView()
          self.homeImage?.image = image.image
          completion()
        case .failure(let error): print(error.localizedDescription)
      }
    }
  }
  func setAwayImage(with url: URL,
                            completion: @escaping ()-> ()) {
    let requestModifier0 = AnyModifier { request in
      var r = request
      r.setValue("4e8027dec2msh34dd0d1a79d5e4ap14d17fjsnfacdb846ca3e",
                 forHTTPHeaderField: "X-RapidAPI-Key")
      return r
    }
    let imageView = UIImageView()
    
    imageView.kf.setImage(with: url, options: [.requestModifier(requestModifier0)]) {
      result in
      switch result {
        case .success(let image):
          self.awayImage = UIImageView()
          self.awayImage?.image = image.image
          completion()
        case .failure(let error): print(error.localizedDescription)
      }
    }
  }
  func setHomeRanking(with id: Int, completion: @escaping ()-> ()) {
    APIManager.shared.fetchPlayerRankings(router: Router.playerRanking(playerID: id)) { ranking in
      self.homeRanking = ranking
      completion()
    }
  }
  func setAwayRanking(with id: Int, completion: @escaping ()-> ()) {
    APIManager.shared.fetchPlayerRankings(router: Router.playerRanking(playerID: id)) { ranking in
      self.awayRanking = ranking
      completion()
    }
  }
  
  func setConfiguration(for configuration: inout ExpandableEventConfiguration,
                                eventDate: String,
                                eventHour: String,
                                homeCountry: String,
                                homeRanking: [Ranking],
                                awayCountry: String,
                                awayRanking: [Ranking],
                                awayImage: UIImage? = nil,
                                homeImage: UIImage? = nil) {
    configuration.eventDate = eventDate
    configuration.eventHour = eventHour
    configuration.awayRanking =
    awayRanking != [] ? String(describing: awayRanking[0].ranking ?? 0) : String(describing: "⧯")
    configuration.homeRanking =
    homeRanking != [] ? String(describing: homeRanking[0].ranking ?? 0) : String(describing: "⧯")
    configuration.awayCountry = awayCountry
    configuration.homeCountry = homeCountry
    configuration.awayImage = awayImage != nil ? awayImage! : UIImage()
    configuration.homeImage = homeImage != nil ? homeImage! : UIImage()
  }
  func setEventDate() -> String {
    let eventDate = dateFormatter.string(from:
                                          Date(timeIntervalSince1970:
                                                Double(event?.startTimestamp ?? 0))).prefix {
      character in
      character != "-"
    }
    return eventDate.description
  }
  func setEventHour() -> String {
    let eventHour = dateFormatter.string(from:
                                          Date(timeIntervalSince1970:
                                                Double(event?.startTimestamp ?? 0))).drop {
      character in
      character != "-"
    }.dropFirst()
    return eventHour.description
  }
}

class ExpandableEventViewCell: UICollectionViewListCell {
  
  // MARK: - properties
  static let reusableID: String = String(describing: ExpandableEventViewCell.self)
  let dateFormatter: DateFormatter = CustomDateFormatter(useCase: .ranking)
  var event: Event? {
    didSet {
      eventDate = setEventDate()
      eventHour = setEventHour()
    }
  }
  var homeImage: UIImageView?
  var awayImage: UIImageView?
  var homeRanking: [Ranking]?
  var awayRanking: [Ranking]?
  var eventDate: String?
  var eventHour: String?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func updateConfiguration(using state: UICellConfigurationState) {
    var newConfiguration = ExpandableEventConfiguration().updated(for: state)
    guard let homeID = event?.homeTeam?.id,
          let awayID = event?.awayTeam?.id,
          let homeUrl = try? Router.playerImage(playerID: homeID).asURLRequest().url,
          let awayUrl = try? Router.playerImage(playerID: awayID).asURLRequest().url
    else { return }
    
    let dispatchGroup = DispatchGroup()
    dispatchGroup.enter()
    DispatchQueue.main.async {
      self.setHomeImage(with: homeUrl) {
        dispatchGroup.leave()
      }
    }
    dispatchGroup.enter()
    DispatchQueue.main.async() {
      self.setAwayImage(with: awayUrl) {
        dispatchGroup.leave()
      }
    }
    dispatchGroup.enter()
    DispatchQueue.main.async() {
      self.setHomeRanking(with: homeID, completion: {
        dispatchGroup.leave()
      })
    }
    dispatchGroup.enter()
    DispatchQueue.main.async() {
      self.setAwayRanking(with: awayID, completion: {
        dispatchGroup.leave()
      })
    }

    dispatchGroup.notify(queue: .main) { [self] in
      guard let homeRanking = homeRanking else { return }
      guard let awayRanking = awayRanking else { return }
      let homeCountryCode = homeRanking.first?.team?.country?.name
      let awayCountryCode = awayRanking.first?.team?.country?.name
      setConfiguration(for: &newConfiguration, eventDate: eventDate ?? "",
                       eventHour: eventHour ?? "", homeCountry: SwiftFlags.flag(for: homeCountryCode ?? "")  ?? "🏴",
                       homeRanking: homeRanking, awayCountry: SwiftFlags.flag(for: awayCountryCode ?? "") ?? "🏴",
                       awayRanking: awayRanking, awayImage: awayImage?.image,
                       homeImage: homeImage?.image)
      self.contentConfiguration = newConfiguration
    }
  }
}

