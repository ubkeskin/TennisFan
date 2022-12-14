//
//  APIManager.swift
//  TennisFan
//
//  Created by OS on 16.11.2022.
//

import Foundation
import Alamofire

class APIManager {
  static let shared = APIManager()
  func fetchEventData(router: Router, completion: @escaping ([Event]) -> ()) {
    AF.request(router).responseDecodable(of:TennisAPIModel.self) { response in
      guard let events = response.value?.events else {return}
      completion(events)
    }
  }
  func fetchATPRankingData(completion: @escaping ([Rankings]) -> ()) {
    AF.request(Router.rankings(gender: .atp)).responseDecodable(of:ATPRankingsModel.self) { response in
      guard let rankings = response.value?.rankings else {return}
      completion(rankings)
    }
  }
  func fetchWTARankingData(completion: @escaping ([Rankings]) -> ()) {
    AF.request(Router.rankings(gender: .wta)).responseDecodable(of:WTARankingsModel.self) { response in
      guard let rankings = response.value?.rankings else {return}
      completion(rankings)
    }
  }
  func fetchPlayerRankings(router: Router, completion: @escaping ([Ranking]) -> ()) {
    AF.request(router).validate().response(completionHandler: { response in
      guard let data = response.data
      else {
        // If response fails to return data.
        completion([])
        return
      }
      let decoder = JSONDecoder()
      let rankings = try? decoder.decode(TennisAPIPlayerRankingsModel.self, from: data)
      completion(rankings?.rankings ?? [])
    })
  }
}
