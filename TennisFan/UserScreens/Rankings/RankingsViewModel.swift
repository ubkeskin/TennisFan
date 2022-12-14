//
//  RankingsViewModel.swift
//  TennisFan
//
//  Created by OS on 14.12.2022.
//

import Foundation

protocol RankingsViewModelInterface {
  func getATPResults()
  func getWTAResults()
  func viewWillAppear()
}

extension RankingsViewModel: RankingsViewModelInterface {
  func getWTAResults() {
    APIManager.shared.fetchWTARankingData { rankings in
      self.wtaRankings = rankings
    }
  }
  
  func getATPResults() {
    APIManager.shared.fetchATPRankingData{ rankings in
      self.atpRankings = rankings
    }
  }
  
  func viewWillAppear() {
    // Configure viewWillAppear state.
  }
}

class RankingsViewModel {
  weak var view: (RankingsViewInterface)?
  var atpRankings: [Rankings] = [Rankings(bestRanking: nil, bestRankingDateTimestamp: nil,
                                      country: nil, id: nil, points: nil, previousPoints: nil,
                                      previousRanking: nil, ranking: nil, rankingClass: nil,
                                      rowName: nil, team: nil, tournamentsPlayed: nil, type: nil)]
  var wtaRankings: [Rankings] = [Rankings(bestRanking: nil, bestRankingDateTimestamp: nil,
                                          country: nil, id: nil, points: nil, previousPoints: nil,
                                          previousRanking: nil, ranking: nil, rankingClass: nil,
                                          rowName: nil, team: nil, tournamentsPlayed: nil, type: nil)]
  
  init(view: RankingsViewInterface? = nil) {
    self.view = view
    getATPResults()
    getWTAResults()
  }
}
