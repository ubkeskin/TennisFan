//
//  ExpandableRankingsCell.swift
//  TennisFan
//
//  Created by OS on 16.12.2022.
//


import UIKit
import Kingfisher
import Alamofire
import FirebaseAuth

protocol ExpandableRankingsViewCellInterface {
  func setImage(with url: URL, completion: @escaping ()->())
  func setConfiguration(for configuration: inout ExpandableRankingsConfiguration,
                        rankings: Rankings,
                        image: UIImage
                        )
  func setFavorite(in dispatchGroup: DispatchGroup)
}

extension ExpandableRankingsViewCell: ExpandableRankingsViewCellInterface {
  func setFavorite(in dispatchGroup: DispatchGroup) {
    let gender = rankings?.team?.gender
    let playerID = rankings?.team?.id
    dispatchGroup.enter()
    // Read data on Firestore
    let docRef = AppDelegate.db.collection("\(userID)_favorites").document("\(gender ?? "")_\(playerID ?? 0)")
    docRef.getDocument { ds, error in
      if let document = ds, document.exists {
        self.isFavorite = true
      } else {
        self.isFavorite = false
      }
      dispatchGroup.leave()
    }
  }
  func setImage(with url: URL,
                    completion: @escaping ()-> ()) {
    let requestModifier = AnyModifier { request in
      var r = request
      r.setValue("4e8027dec2msh34dd0d1a79d5e4ap14d17fjsnfacdb846ca3e",
                 forHTTPHeaderField: "X-RapidAPI-Key")
      return r
    }
    let imageView = UIImageView()
    
    imageView.kf.setImage(with: url, options: [.requestModifier(requestModifier)]) {
      result in
      switch result {
        case .success(let image):
          self.playerImage = UIImageView()
          self.playerImage?.image = image.image
          completion()
        case .failure(let error): print(error.localizedDescription)
      }
    }
  }
  func setConfiguration(for configuration: inout ExpandableRankingsConfiguration,
                        rankings: Rankings,
                        image: UIImage) {
    configuration.isFavorite = isFavorite
    configuration.gender = rankings.team?.gender
    configuration.userID = userID
    configuration.id = "\(rankings.team?.id ?? 0)"
    configuration.bestRanking = String(describing: "Best Ranking: \(rankings.bestRanking ?? 0)")
    configuration.ranking = String(describing: "Ranking: \(rankings.ranking ?? 0)")
    configuration.country = String(describing: "Country: \(rankings.team?.country?.name ?? "")")
    configuration.tournamentsPlayed = String(describing: "Tournaments Played \(rankings.tournamentsPlayed ?? 0)")
    configuration.image = image
  }
}

class ExpandableRankingsViewCell: UICollectionViewListCell {
  
  // MARK: - properties
  static let reusableID: String = String(describing: ExpandableEventViewCell.self)
  let userID = Auth.auth().currentUser?.uid ?? ""
  var rankings: Rankings?
  var isFavorite: Bool?
  var playerImage: UIImageView?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func updateConfiguration(using state: UICellConfigurationState) {
    var newConfiguration = ExpandableRankingsConfiguration().updated(for: state)
    guard let playerID = rankings?.team?.id,
          let url = try? Router.playerImage(playerID: playerID).asURLRequest().url
    else { return }
    
    let dispatchGroup = DispatchGroup()
    dispatchGroup.enter()
    DispatchQueue.main.async {
      self.setImage(with: url) {
        dispatchGroup.leave()
      }
    }
    setFavorite(in: dispatchGroup)
    
    dispatchGroup.notify(queue: .main) { [self] in
      setConfiguration(for: &newConfiguration, rankings: rankings!, image: playerImage?.image ?? UIImage())
      self.contentConfiguration = newConfiguration
    }
  }
}
