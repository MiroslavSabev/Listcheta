//
//  Game.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 18.11.26.
//

import Foundation


enum GamePhase: String, Codable {
    case Setup
    case RoundIntro
    case NextPlayer
    case PlayerTurn
    case RoundEnd
    case Finished
}

struct GameSettings: Codable {
    var wordsPerPlayer = 10
    var turnSeconds = 60
    var roundsCount = 3
}

struct Game: Codable {
    var settings = GameSettings()
    var phase: GamePhase = .Setup
    
    // Setup
    var teams: [Team] = []
    var players: [Player] = []
    var words: [Word] = []
    
    // Игра
    var round = 0                              // 0, 1, 2
    var pool: [Word.ID] = []                   // оставащи в купата
    var currentTeamID: Team.ID?
    var nextExplainerIndex: [Team.ID: Int] = [:]
    var turn: Turn?
    var scores: [Team.ID: [Int]] = [:]         // scores[teamID][round]
    
    // Пренос между рундовете (02б / 02в)
    var carriedSeconds: Int?
    var carriedExplainerID: Player.ID?
    
    mutating func startGame() {
        round = 0
        pool = words.map(\.id).shuffled()
        scores = Dictionary(uniqueKeysWithValues: teams.map {
            ($0.id, Array(repeating: 0, count: settings.roundsCount))
        })
        nextExplainerIndex = Dictionary(uniqueKeysWithValues: teams.map { ($0.id, 0) })
        currentTeamID = teams.first?.id
        carriedSeconds = nil
        carriedExplainerID = nil
        turn = nil
        phase = .RoundIntro
    }
    
    /// От „Край на рунда" към следващия рунд.
    mutating func startNextRound() {
        round += 1
        pool = words.map(\.id).shuffled()
        if carriedSeconds == nil { switchTeam() }   // няма пренос → първи обяснява другият отбор
        phase = .RoundIntro
    }
    
    /// От „Дай телефона на ..." към самия ход.
    mutating func beginTurn() {
        guard let teamID = currentTeamID else { return }
        
        let explainerID: Player.ID
        if let carried = carriedExplainerID {
            explainerID = carried                    // продължава този, който е довършил рунда
        } else if let next = takeNextExplainer(of: teamID) {
            explainerID = next.id
        } else { return }
        
        turn = Turn(explainerID: explainerID,
                    secondsLeft: carriedSeconds ?? settings.turnSeconds,
                    currentWordID: pool.first)
        carriedSeconds = nil
        carriedExplainerID = nil
        phase = .PlayerTurn
    }
    
    mutating func markGuessed() {
        guard var t = turn,
              let wordID = t.currentWordID,
              let teamID = currentTeamID else { return }
        
        scores[teamID, default: Array(repeating: 0, count: settings.roundsCount)][round] += 1
        pool.removeAll { $0 == wordID }
        
        t.guessedCount += 1
        t.currentWordID = pool.first
        turn = t
        
        if pool.isEmpty { finishRound() }
    }
    
    mutating func skip() {
        guard var t = turn, let wordID = t.currentWordID else { return }
        pool.removeAll { $0 == wordID }
        pool.append(wordID)                          // връща се накрая на купата
        t.currentWordID = pool.first
        turn = t
    }
    
    /// Времето изтече.
    mutating func endTurn() {
        turn = nil
        switchTeam()
        phase = .NextPlayer
    }
    
    // MARK: Помощни
    
    private mutating func finishRound() {
        let secondsLeft = turn?.secondsLeft ?? 0
        carriedSeconds = secondsLeft > 0 ? secondsLeft : nil
        carriedExplainerID = secondsLeft > 0 ? turn?.explainerID : nil
        turn = nil
        phase = (round + 1 == settings.roundsCount) ? .Finished : .RoundEnd
    }
    
    private mutating func switchTeam() {
        guard let current = currentTeamID,
              let other = teams.first(where: { $0.id != current }) else { return }
        currentTeamID = other.id
    }
    
    /// Връща следващия играч на отбора и мести индекса напред.
    private mutating func takeNextExplainer(of teamID: Team.ID) -> Player? {
        let members = players.filter { $0.teamID == teamID }
        guard !members.isEmpty else { return nil }
        let index = nextExplainerIndex[teamID, default: 0]
        nextExplainerIndex[teamID] = (index + 1) % members.count
        return members[index % members.count]
    }
    
    func score(of teamID: Team.ID, round: Int? = nil) -> Int {
        let list = scores[teamID] ?? []
        if let round { return list.indices.contains(round) ? list[round] : 0 }
        return list.reduce(0, +)
    }

    var currentWord: Word? {
        guard let id = turn?.currentWordID else { return nil }
        return words.first { $0.id == id }
    }

    var currentExplainer: Player? {
        guard let id = turn?.explainerID else { return nil }
        return players.first { $0.id == id }
    }
    
    mutating func setTeams(firstName: String, secondName: String) {
        teams = [
            Team(slot: .First, name: firstName),
            Team(slot: .Second, name: secondName)
        ]
        players = []
        words = []
    }

    mutating func setPlayers(first: [String], second: [String]) {
        guard teams.count == 2 else { return }
        players = first.map  { Player(name: $0, teamID: teams[0].id) }
                + second.map { Player(name: $0, teamID: teams[1].id) }
    }

    mutating func submitWords(_ texts: [String], for playerID: Player.ID) {
        words.removeAll { $0.authorID == playerID }
        words += texts.map { Word(text: $0, authorID: playerID) }
    }
    
    mutating func rematch() {
        words = []
        pool = []
        scores = [:]
        round = 0
        turn = nil
        carriedSeconds = nil
        carriedExplainerID = nil
        phase = .Setup
    }
}
