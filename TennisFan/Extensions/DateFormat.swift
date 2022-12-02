//
//  DateFormat.swift
//  TennisFan
//
//  Created by OS on 1.12.2022.
//

import Foundation


class CustomDateFormatter: DateFormatter {
  var useCase: UseCase
  init(useCase: UseCase) {
    self.useCase = useCase
    super.init()
    setDateFormat(for: useCase)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  enum UseCase {
    case request, ranking
    var dateFormat: String {
      switch self {
        case .request: return "dd/MM/yyyy'T'HH:mm:ssZZZZZ"
        case .ranking: return "dd.MM.yy' - 'HH:mm"
      }
    }
  }
  private func setDateFormat(for style: UseCase) {
    self.dateFormat = style.dateFormat
  }
}
