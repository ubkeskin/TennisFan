import Foundation

// MARK: - TennisAPIModel
struct TennisAPIModel: Decodable {
  let events: [Event]?
}

// MARK: - Event
struct Event: Decodable, Hashable {
  let awayScore: Score?
  let awayTeam: Team?
  let changes: Changes?
  let customID: String?
  let finalResultOnly: Bool?
  let firstToServe: Int?
  let hasGlobalHighlights: Bool?
  let homeScore: Score?
  let homeTeam: Team?
  let id: Int?
  let lastPeriod: LastPeriod?
  let periods: Periods?
  let roundInfo: RoundInfo?
  let slug: String?
  let startTimestamp: Int?
  let status: Status?
  let time: Time?
  let tournament: Tournament?
  let winnerCode: Int?
  
  enum CodingKeys: String, CodingKey, Hashable {
    case awayScore, awayTeam, changes
    case customID = "customId"
    case finalResultOnly, firstToServe, hasGlobalHighlights, homeScore, homeTeam, id, lastPeriod, periods, roundInfo, slug, startTimestamp, status, time, tournament, winnerCode
  }
}

// MARK: - Score
struct Score: Codable, Hashable {
  let current, display, normaltime: Int?
  let period1: Int?
  let period1TieBreak, period2, period2TieBreak, period3: Int?
  let period3TieBreak, period4, period5, period5TieBreak: Int?
  let point: String?
}

// MARK: - Team
struct Team: Decodable, Hashable {
  let disabled: Bool?
  let id: Int?
  let name, shortName, slug: String?
  let sport: Sport?
  let subTeams: [SubTeam]?
  let teamColors: TeamColors?
  let type, userCount: Int?
}

// MARK: - Sport
struct Sport: Codable, Hashable {
  let id: Int?
  let name: SportName?
  let slug: Slug?
}

enum SportName: String, Codable, Hashable {
  case tennis = "Tennis"
}

enum Slug: String, Codable, Hashable{
  case tennis = "tennis"
}

// MARK: - SubTeam
struct SubTeam: Decodable, Hashable {
  static func == (lhs: SubTeam, rhs: SubTeam) -> Bool {
    lhs.id == rhs.id
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  let disabled: Bool?
  let gender: Gender?
  let id: Int?
  let name: String?
  let nameCode: String?
  let national: Bool?
  let ranking: Int?
  let shortName, slug: String?
  let sport: Sport?
  let subTeams: [AnyDecodable]?
  let teamColors: TeamColors?
  let type, userCount: Int?
}
enum CodingKeys: CodingKey {
  case subTeams
}

enum Gender: String, Codable, Hashable {
  case f = "F"
  case m = "M"
}

// MARK: - TeamColors
struct TeamColors: Codable, Hashable {
  let primary, secondary: Ary?
  let text: Text?
}

enum Ary: String, Codable, Hashable {
  case the52B030 = "#52b030"
}

enum Text: String, Codable {
  case ffffff = "#ffffff"
}

// MARK: - Changes
struct Changes: Codable, Hashable {
  let changeTimestamp: Int?
  let changes: [String]?
}

enum LastPeriod: String, Codable, Hashable {
  case period1 = "period1"
  case period2 = "period2"
  case period3 = "period3"
}

// MARK: - Periods
struct Periods: Codable, Hashable {
  let current: Current?
  let period1, period2, period3: Period1?
  let period4: Period4?
  let period5: Period5?
  let point: Point?
}

enum Current: String, Codable, Hashable {
  case match = "Match"
}

enum Period1: String, Codable, Hashable{
  case canceled = "Canceled"
  case ended = "Ended"
  case interrupted = "Interrupted"
  case notStarted = "Not started"
  case retired = "Retired"
  case the1StSet = "1st set"
  case the2NdSet = "2nd set"
  case the3RDSet = "3rd set"
  case walkover = "Walkover"
  case suspended = "Suspended"
}

enum Period4: String, Codable, Hashable {
  case the4ThSet = "4th set"
}

enum Period5: String, Codable, Hashable {
  case the5ThSet = "5th set"
}

enum Point: String, Codable, Hashable {
  case game = "Game"
}

// MARK: - RoundInfo
struct RoundInfo: Codable, Hashable {
  let cupRoundType: Int?
  let name: RoundInfoName?
  let round: Int?
}

enum RoundInfoName: String, Codable, Hashable {
  case nameFinal = "Final"
  case quarterfinal = "Quarterfinal"
  case roundOf16 = "Round of 16"
  case roundOf32 = "Round of 32"
  case semifinal = "Semifinal"
  case qualificationRound1 = "Qualification round 1"
  case qualificationRound2 = "Qualification round 2"
}

// MARK: - Status
struct Status: Codable, Hashable {
  let code: Int?
  let statusDescription: Period1?
  let type: TypeEnum?
  
  enum CodingKeys: String, CodingKey, Hashable {
    case code
    case statusDescription = "description"
    case type
  }
}

enum TypeEnum: String, Codable, Hashable {
  case canceled = "canceled"
  case finished = "finished"
  case inprogress = "inprogress"
  case interrupted = "interrupted"
  case notstarted = "notstarted"
  case suspended = "suspended"

}

// MARK: - Time
struct Time: Codable, Hashable {
  let currentPeriodStartTimestamp: Int?
}

// MARK: - Tournament
struct Tournament: Codable, Hashable {
  let category: Category?
  let id: Int?
  let name: String?
  let priority: Int?
  let slug: String?
  let uniqueTournament: UniqueTournament?
}

// MARK: - Category
struct Category: Codable, Hashable {
  let flag: Flag?
  let id: Int?
  let name: CategoryName?
  let slug: Flag?
  let sport: Sport?
}

enum Flag: String, Codable, Hashable {
  case atp = "atp"
  case billieJeanKingCup = "billie-jean-king-cup"
  case challenger = "challenger"
  case challengerWomen = "challenger-women"
  case davisCup = "davis-cup"
  case itfMen = "itf-men"
  case itfWomen = "itf-women"
  case juniors = "juniors"
  case legends = "legends"
  case other = "other"
  case wheelchairs = "wheelchairs"
  case wta = "wta"
}

enum CategoryName: String, Codable, Hashable {
  case atp = "ATP"
  case billieJeanKingCup = "Billie Jean King Cup"
  case challenger = "Challenger"
  case challengerWomen = "Challenger Women"
  case davisCup = "Davis Cup"
  case itfMen = "ITF Men"
  case itfWomen = "ITF Women"
  case juniors = "Juniors"
  case legends = "Legends"
  case other = "Other"
  case wheelchairs = "Wheelchairs"
  case wta = "WTA"
}

// MARK: - UniqueTournament
struct UniqueTournament: Codable, Hashable {
  let category: Category?
  let hasEventPlayerStatistics, hasPositionGraph: Bool?
  let id: Int?
  let name, slug: String?
  let userCount: Int?
}

public struct AnyDecodable : Decodable {
  
  let value :Any
  
  public init<T>(_ value :T?) {
    self.value = value ?? ()
  }
  
  public init(from decoder :Decoder) throws {
    let container = try decoder.singleValueContainer()
    
    if let string = try? container.decode(String.self) {
      self.init(string)
    } else if let int = try? container.decode(Int.self) {
      self.init(int)
    } else {
      self.init(())
    }
    // handle all the different types including bool, array, dictionary, double etc
  }
}
