//
//  EventsDetailViewModel.swift
//  TennisFan
//
//  Created by OS on 3.12.2022.
//

import Foundation
protocol EventsDetailViewModelInterface {
  func viewDidLoad()
}
extension EventsDetailViewModel: EventsDetailViewModelInterface {
  func viewDidLoad() {
    view?.configureDetailView()
  }
}

class EventsDetailViewModel {
  weak var view: (EventsDetailViewInterface)?
  var event: Event?
  var imageDictionary: [String: Data?]?
  var rankingsDictionary: [String: [Ranking]?]?
  
  init(view: EventsDetailViewInterface? = nil) {
    self.view = view
  }
}
