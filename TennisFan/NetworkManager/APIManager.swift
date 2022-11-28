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
  func fetchData(router: Router, completion: @escaping ([Event]) -> ()) {
    switch router {
      case .events:
        AF.request(router).response(completionHandler:  { response in
          let decoder = JSONDecoder()
          switch response.result {
            case .success(let events):
              let res = try! decoder.decode(TennisAPIModel.self, from: events!)
              guard let results = res.events else { return }
              
              completion(results)
            case .failure(let error):
              print(NSError(domain: error.localizedDescription, code: 0))
          }
        })
      case .playerDetail:
        AF.request(router).responseDecodable(of: TennisAPIModel.self) { response in
          switch response.result {
            case .success(let events):
              guard let results = events.events else { return }
              completion(results)
            case .failure(let error):
              print(NSError(domain: error.localizedDescription, code: 0))
          }
        }
      case .playerImage:
        AF.request(router).responseDecodable(of: TennisAPIModel.self) { response in
          switch response.result {
            case .success(let events):
              guard let results = events.events else { return }
              completion(results)
            case .failure(let error):
              print(NSError(domain: error.localizedDescription, code: 0))
          }
        }
      case .rankings:
        AF.request(router).responseDecodable(of: TennisAPIModel.self) { response in
          switch response.result {
            case .success(let events):
              guard let results = events.events else { return }
              completion(results)
            case .failure(let error):
              print(NSError(domain: error.localizedDescription, code: 0))
          }
        }
      case .search:
        AF.request(router).responseDecodable(of: TennisAPIModel.self) { response in
          switch response.result {
            case .success(let events):
              guard let results = events.events else { return }
              completion(results)
            case .failure(let error):
              print(NSError(domain: error.localizedDescription, code: 0))
          }
        }
    }
  }
}
