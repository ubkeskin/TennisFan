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
    APIManager.shared.fetchData(router: Router.events(date: date), completion: {[self] results in
      matches = results
      view?.refreshCollectionView()
    })
  }
}
class EventsViewModel {
  weak var view: EventsViewInterface?
  lazy var dateFormatter: DateFormatter = {
    var dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy'T'HH:mm:ssZZZZZ"
    return dateFormatter
  }()
  lazy var date: String = {
    String(dateFormatter.string(from: Date()).prefix(10))
  }()
  var matches: [Event] = [Event(awayScore: nil, awayTeam: nil, changes: nil, customID: nil, finalResultOnly: nil, firstToServe: nil, hasGlobalHighlights: nil, homeScore: nil, homeTeam: nil, id: nil, lastPeriod: nil, periods: nil, roundInfo: nil, slug: nil, startTimestamp: nil, status: nil, time: nil, tournament: nil, winnerCode: nil)] 
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
