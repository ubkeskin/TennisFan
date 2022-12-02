//
//  ExpandableViewContentConfiguration.swift
//  TennisFan
//
//  Created by OS on 22.11.2022.
//

import Foundation
import UIKit

struct ExpandableContentConfiguration: UIContentConfiguration, Equatable {
  
  var eventDate: String?
  var eventHour: String?
  var homeImage: UIImage?
  var awayImage: UIImage?
  var homeName: String?
  var awayName: String?
  var homeRanking: String?
  var awayRanking: String?
  func makeContentView() -> UIView & UIContentView {
    return ExpandableContentView(configuration: self)
  }
  
  func updated(for state: UIConfigurationState) -> Self {
    guard let state = state as? UICellConfigurationState else {
      return self
    }
    var updatedConfiguration = self
    //    if state.isExpanded {
    //      // configure selected state logic
    //    }
    return updatedConfiguration
  }
}
