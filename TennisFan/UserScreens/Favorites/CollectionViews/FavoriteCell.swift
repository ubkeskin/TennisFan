//
//  FavoriteCell.swift
//  TennisFan
//
//  Created by OS on 8.01.2023.
//

import UIKit
import Kingfisher
import FirebaseAuth

protocol FavoriteCellInterface {
  func setImage(with url: URL, completion: @escaping ()->())
  func setConfiguration(for configuration: inout FavoriteConfiguration,
                        rankings: Rankings,
                        image: UIImage
  )
}

extension FavoriteCell: FavoriteCellInterface {
  func setImage(with url: URL, completion: @escaping () -> ()) {
    let requestModifier = AnyModifier { request in
      var r = request
      r.setValue("4e8027dec2msh34dd0d1a79d5e4ap14d17fjsnfacdb846ca3e",
                 forHTTPHeaderField: "X-RapidAPI-Key")
      return r
    }
    self.playerImage = UIImageView()
    
    self.playerImage?.kf.setImage(with: url, options: [.requestModifier(requestModifier)]) {
      result in
      switch result {
        case .success(let image):
          self.playerImage?.image = image.image
          completion()
        case .failure(let error): print(error.localizedDescription)
      }
    }
  }
  
  func setConfiguration(for configuration: inout FavoriteConfiguration, rankings: Rankings, image: UIImage) {
    configuration.bestRanking = String(describing: "Best Ranking: \(rankings.bestRanking ?? 0)")
    configuration.ranking = String(describing: "Ranking: \(rankings.ranking ?? 0)")
    configuration.country = String(describing: "Country: \(rankings.team?.country?.name ?? "")")
    configuration.tournamentsPlayed = String(describing: "Tournaments Played \(rankings.tournamentsPlayed ?? 0)")
    configuration.image = image
  }
}

class FavoriteCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: FavoriteCell.self)
  
  var rankings: Rankings?
  var playerImage: UIImageView?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func updateConfiguration(using state: UICellConfigurationState) {
    var newConfiguration = FavoriteConfiguration().updated(for: state)
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
    dispatchGroup.notify(queue: .main) { [self] in
      setConfiguration(for: &newConfiguration, rankings: rankings!, image: playerImage?.image ?? UIImage())
      self.contentConfiguration = newConfiguration
    }
  }
}
