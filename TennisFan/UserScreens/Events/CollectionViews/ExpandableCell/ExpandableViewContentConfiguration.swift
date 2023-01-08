//
//  ExpandableViewContentConfiguration.swift
//  TennisFan
//
//  Created by OS on 22.11.2022.
//

import Foundation
import UIKit

struct ExpandableEventConfiguration: UIContentConfiguration, Equatable {
  
  var eventDate: String?
  var eventHour: String?
  var homeImage: UIImage?
  var awayImage: UIImage?
  var homeCountry: String?
  var awayCountry: String?
  var homeRanking: String?
  var awayRanking: String?
  func makeContentView() -> UIView & UIContentView {
    return ExpandableEventView(configuration: self)
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
