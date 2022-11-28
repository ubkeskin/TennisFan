//
//  CollectionViewExpandableCell.swift
//  TennisFan
//
//  Created by OS on 16.11.2022.
//

import UIKit
import Kingfisher
import Alamofire

class ExpandableCollactionViewCell: UICollectionViewListCell {

  
  // MARK: - properties
  static let reusableID: String = String(describing: ExpandableCollactionViewCell.self)
  var event: Event?

  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func updateConfiguration(using state: UICellConfigurationState) {
    var newConfiguration = ExpandableContentConfiguration().updated(for: state)
      guard let homeID = event?.homeTeam?.id else { return }
      guard let awayID = event?.awayTeam?.id else { return }
      var url = try? Router.playerImage(playerID: homeID).asURLRequest()
      let requestModifier0 = AnyModifier { request in
        var r = request
        r.setValue("4114d82792mshdc17812619ee54dp147cadjsnb495937202d4", forHTTPHeaderField: "X-RapidAPI-Key")
        return r
      }
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.dateFormat = "dd.MM.yy'T'HH:mm"
    let eventDate = dateFormatter.string(from: Date(timeIntervalSince1970: Double(event?.startTimestamp ?? 0)))
    let homeImage = UIImageView()
    let awayImage = UIImageView()
    
    DispatchQueue.main.async(qos: .default) {
      homeImage.kf.setImage(with: url?.url, options: [.requestModifier(requestModifier0)]) {[self] result in
          switch result {
          case .success(let image):
              newConfiguration.eventDate = eventDate
              newConfiguration.homeName = event?.homeTeam?.name
              newConfiguration.awayName = event?.awayTeam?.name
              newConfiguration.homeImage = image.image
              contentConfiguration = newConfiguration
          case .failure(let error):
          print(error)
          }
        }
      url = try? Router.playerImage(playerID: awayID).asURLRequest()
      
      awayImage.kf.setImage(with: url?.url, options: [.requestModifier(requestModifier0)]) {[self] result in
        switch result { 
          case .success(let image):
            newConfiguration.eventDate = eventDate
            newConfiguration.homeName = event?.homeTeam?.name
            newConfiguration.awayName = event?.awayTeam?.name
            newConfiguration.awayImage = image.image
            contentConfiguration = newConfiguration
          case .failure(let error):
          print(error)
        }
      }
    }
  }
}


