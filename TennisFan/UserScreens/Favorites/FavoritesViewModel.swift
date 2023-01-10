//
//  FavoritesViewModel.swift
//  TennisFan
//
//  Created by OS on 8.01.2023.
//

import Foundation
import FirebaseAuth

protocol FavoritesViewModelInterface {
  func getATPResults(in: DispatchGroup)
  func getWTAResults(in: DispatchGroup)
  func getFavorites(in: DispatchGroup)
}
extension FavoritesViewModel: FavoritesViewModelInterface {
 
  func getATPResults(in group: DispatchGroup) {
    group.enter()
    APIManager.shared.fetchATPRankingData { rankings in
      let atpFavorites = self.favorites.filter { favorite in
        favorite.starts(with: "M")
      }.map({$0.dropFirst(2)})
      self.atpRankings = rankings.filter { rankings in
        atpFavorites.contains("\(rankings.team?.id ?? 0)")
      }
      group.leave()
    }
  }
  
  func getWTAResults(in group: DispatchGroup) {
    group.enter()
    
    APIManager.shared.fetchWTARankingData { rankings in
      let wtaFavorites = self.favorites.filter { favorite in
        favorite.starts(with: "F")
      }.map({$0.dropFirst(2)})
      self.wtaRankings = rankings.filter { rankings in
        wtaFavorites.contains("\(rankings.team?.id ?? 0)")
      }
      group.leave()
    }
  }
  
  func getFavorites(in group: DispatchGroup) {
    group.enter()
    let userID = Auth.auth().currentUser?.uid ?? ""
    let docRef = AppDelegate.db.collection("\(userID)_favorites").getDocuments { querySnapshot, error in
      if let error = error {
        print("Error getting documents: \(error)")
      }
      else {
        querySnapshot?.documents.forEach({ document in
          self.favorites.append(document.documentID)
        })
      }
      group.leave()
    }
  }
}

class FavoritesViewModel {
  weak var view: (FavoritesViewInterface)?
  
  var atpRankings: [Rankings] = []
  var wtaRankings: [Rankings] = []
  var rankings: [Rankings]?
  var favorites: [String] = []
  
  init(view: FavoritesViewInterface? = nil) {
    self.view = view
    let dispatch = DispatchGroup()
    getFavorites(in: dispatch)
    getATPResults(in: dispatch)
    getWTAResults(in: dispatch)
    dispatch.notify(queue: .main) {
      let atpS = self.atpRankings.compactMap({$0})
      let wtaS = self.wtaRankings.compactMap({$0})
      self.rankings = atpS + wtaS
      view?.refreshCollectionView()
    }
  }
}
