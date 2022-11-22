//
//  CollectionViewExpandableCell.swift
//  TennisFan
//
//  Created by OS on 16.11.2022.
//

import UIKit

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
    newConfiguration.homeName = event?.homeTeam?.name
    newConfiguration.awayName = event?.awayTeam?.name
    
    contentConfiguration = newConfiguration
  }
}


