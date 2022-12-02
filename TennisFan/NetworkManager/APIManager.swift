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
  func fetchPlayerRankings(router: Router, completion: @escaping ([Ranking]) -> ()) {
    AF.request(router).response(completionHandler: { response in
      guard let data = response.data else { return }
      let decoder = JSONDecoder()
      let rankings = try? decoder.decode(TennisAPIPlayerRankingsModel.self, from: data)
      completion(rankings?.rankings ?? [])
      })
  }
}
