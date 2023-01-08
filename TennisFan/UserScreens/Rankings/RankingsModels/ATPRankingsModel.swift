//
//  ATPRankingsModel.swift
//  TennisFan
//
//  Created by OS on 14.12.2022.
//

import Foundation

struct ATPRankingsModel: Codable, Hashable {
  let rankings: [Rankings]
}
struct Rankings: Codable, Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  let bestRanking: Int?
  let bestRankingDateTimestamp: Int?
  let country: TeamCountry?
  let id: Int?
  let points: Int?
  let previousPoints: Int?
  let previousRanking: Int?
  let ranking: Int?
  let rankingClass: String?
  let rowName:String?
  let team: ATPTeam?
  let tournamentsPlayed: Int?
  let type: Int?
  
  enum CodingKeys: String, CodingKey, Hashable {
    case bestRanking, bestRankingDateTimestamp, country, id, points, previousPoints,
         previousRanking, ranking, rankingClass, rowName, team, tournamentsPlayed, type
  }
}

struct ATPTeam: Codable, Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  let country: TeamCountry?
  let disabled: Bool?
  let gender: String?
  let id: Int?
  let name: String?
  let nameCode: String?
  let national: Bool?
  let ranking: Int?
  let shortName: String?
  let slug: String?
  let type: Int?
  let userCount: Int?
  let sport: Sport?
  let teamColors: TeamColors?
  
  enum CodingKeys: String, CodingKey, Hashable {
    case country, disabled, gender, id, name, nameCode, national, ranking, shortName, slug, type,
         userCount, sport, teamColors
  }
}
