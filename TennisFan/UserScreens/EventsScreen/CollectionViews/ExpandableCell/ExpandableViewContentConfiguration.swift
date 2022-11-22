//
//  ExpandableViewContentConfiguration.swift
//  TennisFan
//
//  Created by OS on 22.11.2022.
//

import Foundation
import UIKit

struct ExpandableContentConfiguration: UIContentConfiguration, Hashable {
  var homeImage: UIImage?
  var awayImage: UIImage?
  var homeName: String?
  var awayName: String?
  var homeRanking: String?
  var awayRanking: String?
  func makeContentView() -> UIView & UIContentView {
    return ExpandableContentView(configuration: self)
  }
  
  func updated(for state: UIConfigurationState) -> ExpandableContentConfiguration {
    guard let state = state as? UICellConfigurationState else {
      return self
    }
    var updatedConfiguration = self
    if state.isSelected {
      
    }
    return updatedConfiguration
  }
}
