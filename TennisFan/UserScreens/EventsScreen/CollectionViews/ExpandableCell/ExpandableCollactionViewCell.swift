//
//  CollectionViewExpandableCell.swift
//  TennisFan
//
//  Created by OS on 16.11.2022.
//

import UIKit
import Kingfisher
import Alamofire

protocol ExpandableCollectionViewCellInterface {
  func setHomeImage(with url: URL, completion: @escaping ()->())
  func setAwayImage(with url: URL, completion: @escaping ()->())
  func setHomeRanking(with id: Int, completion: @escaping ()->())
  func setAwayRanking(with id: Int, completion: @escaping ()->())
  func setConfiguration(for configuration: inout ExpandableContentConfiguration,
                        eventDate: String,
                        eventHour: String,
                        homeName: String,
                        homeRanking: [Ranking],
                        awayName: String,
                        awayRanking: [Ranking],
                        awayImage: UIImage?,
                        homeImage: UIImage?)
  func setEventDate() -> String
  func setEventHour() -> String
}

extension ExpandableCollactionViewCell: ExpandableCollectionViewCellInterface {
  func setHomeImage(with url: URL,
                            completion: @escaping ()-> ()) {
    let requestModifier0 = AnyModifier { request in
      var r = request
      r.setValue("59c909b774msh5cb09e94339cc05p1ef428jsn85ffa3ed06c4",
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
      r.setValue("59c909b774msh5cb09e94339cc05p1ef428jsn85ffa3ed06c4",
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
  
  func setConfiguration(for configuration: inout ExpandableContentConfiguration,
                                eventDate: String,
                                eventHour: String,
                                homeName: String,
                                homeRanking: [Ranking],
                                awayName: String,
                                awayRanking: [Ranking],
                                awayImage: UIImage? = nil,
                                homeImage: UIImage? = nil) {
    configuration.eventDate = eventDate
    configuration.eventHour = eventHour
    configuration.awayRanking =
    awayRanking != [] ? String(describing: awayRanking[0].ranking ?? 0) : String(describing: "")
    configuration.homeRanking =
    homeRanking != [] ? String(describing: homeRanking[0].ranking ?? 0) : String(describing: "")
    configuration.awayName = awayName
    configuration.homeName = homeName
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

class ExpandableCollactionViewCell: UICollectionViewListCell {
  
  // MARK: - properties
  static let reusableID: String = String(describing: ExpandableCollactionViewCell.self)
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
    var newConfiguration = ExpandableContentConfiguration().updated(for: state)
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
      setConfiguration(for: &newConfiguration, eventDate: eventDate ?? "",
                       eventHour: eventHour ?? "", homeName: event?.homeTeam?.name ?? "",
                       homeRanking: homeRanking, awayName: event?.awayTeam?.name ?? "",
                       awayRanking: awayRanking, awayImage: awayImage?.image,
                       homeImage: homeImage?.image)
      self.contentConfiguration = newConfiguration
    }
  }
}

