//
//  TennisAPIPlayerRankingModel.swift
//  TennisFan
//
//  Created by OS on 30.11.2022.
//

import Foundation

// MARK: - TennisAPIPlayerRankingsModel
struct TennisAPIPlayerRankingsModel: Codable {
  let rankings: [Ranking]?
}

// MARK: - Ranking
struct Ranking: Codable, Equatable {
  let bestRanking: Int?
  let country: RankingCountry?
  let id, points: Int?
  let previousPoints: Int?
  let previousRanking, ranking: Int?
  let rankingClass, rowName: String?
  let team: TeamRanking?
  let tournamentsPlayed: Int?
  let type: Int?
}

// MARK: - RankingCountry
struct RankingCountry: Codable, Equatable {
}

// MARK: - Team
struct TeamRanking: Codable, Equatable {
  let country: TeamCountry?
  let gender: String?
  let id: Int?
  let name, nameCode: String?
  let national: Bool?
  let ranking: Int?
  let shortName, slug: String?
  let sport: Sport?
  let teamColors: TeamColors?
  let type, userCount: Int?
}

// MARK: - TeamCountry
struct TeamCountry: Codable, Equatable {
  let alpha2, name: String?
}

