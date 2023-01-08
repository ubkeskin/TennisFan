//
//  ExpandableRankingsConfiguration.swift
//  TennisFan
//
//  Created by OS on 16.12.2022.
//

import Foundation
import UIKit

struct ExpandableRankingsConfiguration: UIContentConfiguration, Equatable {
  
  var id: String?
  var userID: String?
  var isFavorite: Bool?
  var gender: String?
  var image: UIImage?
  var bestRanking: String?
  var ranking: String?
  var country: String?
  var tournamentsPlayed: String?
  
  func makeContentView() -> UIView & UIContentView {
    return ExpandableRankingsView(configuration: self)
  }
  
  func updated(for state: UIConfigurationState) -> Self {
    guard let state = state as? UICellConfigurationState else {
      return self
    }
    var updatedConfiguration = self
    if state.isSelected {
      // configure selected state logic
    }
    return updatedConfiguration
  }
}
