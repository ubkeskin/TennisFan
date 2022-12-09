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
  var tournament: String {
    event?.tournament?.name ?? "Could not fetch tournament info/ API failure"
  }
  var date: String {
    let eventDate = dateFormatter.string(from:
                                          Date(timeIntervalSince1970:
                                                Double(event?.startTimestamp ?? 0))).prefix {
      character in
      character != "-"
    }
    return eventDate.description
  }
  var time: String {
    let eventHour = dateFormatter.string(from:
                                          Date(timeIntervalSince1970:
                                                Double(event?.startTimestamp ?? 0))).drop {
      character in
      character != "-"
    }.dropFirst()
    return eventHour.description
  }
  var round: String {
    event?.roundInfo?.name?.rawValue ?? "Could not fetch round info. API failure."
  }
  var homeName: String {
    event?.homeTeam?.slug?.replacingOccurrences(of: "-", with: " ") ?? ""
  }
  var awayName: String {
    event?.awayTeam?.slug?.replacingOccurrences(of: "-", with: " ") ?? ""
  }
  var homeRanking: Int {
    rankingsDictionary?["homeRanking"]!?.first?.ranking ?? 0
  }
  var awayRanking: Int {
    rankingsDictionary?["awayRanking"]!?.first?.ranking ?? 0
  }
  var homeBestRanking: Int {
    rankingsDictionary?["homeRanking"]!?.first?.bestRanking ?? 0
  }
  var awayBestRanking: Int {
    rankingsDictionary?["awayRanking"]!?.first?.bestRanking ?? 0
  }
  var homeTournamentsPlayed: Int {
    rankingsDictionary?["homeRanking"]!?.first?.tournamentsPlayed ?? 0
  }
  var awayTournamentsPlayed: Int {
    rankingsDictionary?["awayRanking"]!?.first?.tournamentsPlayed ?? 0
  }
  var homeCountry: String {
    rankingsDictionary?["homeRanking"]!?.first?.team?.country?.name ?? ""
  }
  var awayCountry: String {
    rankingsDictionary?["awayRanking"]!?.first?.team?.country?.name ?? ""
  }
  let dateFormatter: DateFormatter = CustomDateFormatter(useCase: .ranking)

  init(view: EventsDetailViewInterface? = nil) {
    self.view = view
  }
}
