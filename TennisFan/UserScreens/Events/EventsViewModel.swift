//
//  EventsViewModel.swift
//  TennisFan
//
//  Created by OS on 16.11.2022.
//

import Foundation
protocol EventsViewModelInterface {
  func getResults()
  func viewWillAppear()
}
extension EventsViewModel: EventsViewModelInterface {
  func viewWillAppear() {
    getResults()
  }
  func getResults() {
    APIManager.shared.fetchEventData(router: Router.events(date: date), completion: {[self] results in
      matches = results.prefix(through: 50).filter({ event in
        event.tournament?.name?.hasSuffix("Doubles") == false
      }).compactMap({matches in
        matches
      }).sorted(by: {$0.startTimestamp! < $1.startTimestamp!})
      view?.refreshCollectionView()
    })
  }
}
class EventsViewModel {
  weak var view: EventsViewInterface?
  lazy var dateFormatter: DateFormatter = {
    var dateFormatter = CustomDateFormatter(useCase: .request)
    return dateFormatter
  }()
  lazy var date: String = {
    String(dateFormatter.string(from: Date()).prefix(10))
  }()
  var matches: [Event] = [Event(awayScore: nil, awayTeam: nil, changes: nil, customID: nil,
                                finalResultOnly: nil, firstToServe: nil, hasGlobalHighlights: nil,
                                homeScore: nil, homeTeam: nil, id: nil, lastPeriod: nil, periods: nil,
                                roundInfo: nil, slug: nil, startTimestamp: nil, status: nil, time: nil,
                                tournament: nil, winnerCode: nil)]
  
  init(view: EventsViewInterface? = nil) {
    self.view = view
    getResults()
  }
}
extension EventsViewModel {
  subscript (safe index: Int) -> Event? {
    matches.indices.contains(index) ? matches[index] : nil
  }
}
