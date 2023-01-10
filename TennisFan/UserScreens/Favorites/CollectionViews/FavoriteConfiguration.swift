//
//  FavoriteConfiguration.swift
//  TennisFan
//
//  Created by OS on 9.01.2023.
//

import UIKit

struct FavoriteConfiguration: UIContentConfiguration, Equatable {
  var image: UIImage?
  var bestRanking: String?
  var ranking: String?
  var country: String?
  var tournamentsPlayed: String?
  
  func makeContentView() -> UIView & UIContentView {
    return FavoriteContentView(configuration: self)
  }
  
  func updated(for state: UIConfigurationState) -> FavoriteConfiguration {
    
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
