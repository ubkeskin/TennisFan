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
      self.view?.refreshCollectionView()
    }
  }
  func getATPResults() {
    APIManager.shared.fetchATPRankingData{ rankings in
      self.atpRankings = rankings
      self.view?.refreshCollectionView()
    }
  }
  func viewWillAppear() {
    view?.refreshCollectionView()
  }
}

class RankingsViewModel {
  weak var view: (RankingsViewInterface)?
  var atpRankings: [Rankings]?
  var wtaRankings: [Rankings]?
  init(view: RankingsViewInterface? = nil) {
    self.view = view
    getATPResults()
    getWTAResults()
  }
}
