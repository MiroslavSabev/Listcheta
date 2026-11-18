//
//  GamesSession.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 18.11.26.
//

import Foundation
import Observation

@Observable
final class GameSession {

    // MARK: Състояние

    private(set) var game: Game
    /// Времето изтече, но обясняващият може да довърши текущата дума.
    private(set) var isOvertime = false

    private let store: GameStore
    private var timerTask: Task<Void, Never>?

    // MARK: Init

    init(game: Game? = nil, store: GameStore = GameStore()) {
        self.store = store
        var loaded = game ?? store.load() ?? Game()

        // Таймерът не е тичал, докато приложението е било затворено:
        // връщаме се на екрана „Дай телефона на ...".
        if loaded.phase == .PlayerTurn {
            loaded.turn = nil
            loaded.phase = .NextPlayer
        }
        self.game = loaded
    }

    // MARK: - Setup

    func setTeams(firstName: String, secondName: String) {
        game.setTeams(firstName: firstName, secondName: secondName)
        persist()
    }

    func setPlayers(first: [String], second: [String]) {
        game.setPlayers(first: first, second: second)
        persist()
    }

    func submitWords(_ texts: [String], for playerID: Player.ID) {
        game.submitWords(texts, for: playerID)
        persist()
    }

    /// След последния играч, въвел думите си.
    func startGame() {
        game.startGame()
        persist()
    }

    // MARK: - Ход

    /// Бутонът „Дай телефона на ..." / „Готова съм — старт!".
    func beginTurn() {
        game.beginTurn()
        guard game.phase == .PlayerTurn else { return }
        isOvertime = false
        startTimer()
        persist()
    }

    func markGuessed() {
        game.markGuessed()
        afterAction()
    }

    func skip() {
        game.skip()
        afterAction()
    }

    // MARK: - Рундове и край

    func startNextRound() {
        game.startNextRound()
        persist()
    }

    func rematch() {
        stopTimer()
        game.rematch()
        persist()
    }

    func newGame() {
        stopTimer()
        game = Game()
        store.clear()
    }

    // MARK: - Вътрешно

    /// Общата логика след „Позна" / „Пропусни".
    private func afterAction() {
        // купата се изпразни → Game вече е сменил фазата (roundEnd / finished)
        guard game.phase == .PlayerTurn else {
            stopTimer()
            isOvertime = false
            persist()
            return
        }
        // в овъртайм след действието ходът приключва
        if isOvertime { finishTurn() }
    }

    private func finishTurn() {
        stopTimer()
        isOvertime = false
        game.endTurn()
        persist()
    }

    // MARK: Таймер

    private func startTimer() {
        stopTimer()
        timerTask = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(1))
                guard !Task.isCancelled else { return }
                self?.tick()
            }
        }
    }

    private func stopTimer() {
        timerTask?.cancel()
        timerTask = nil
    }

    private func tick() {
        guard game.phase == .PlayerTurn,
              let seconds = game.turn?.secondsLeft else { return }

        if seconds > 1 {
            game.turn?.secondsLeft = seconds - 1          // без запис: само таймерът се мести
        } else {
            game.turn?.secondsLeft = 0
            stopTimer()
            if game.currentWord != nil {
                isOvertime = true                          // дава шанс да довърши думата
            } else {
                finishTurn()
            }
        }
    }

    // MARK: Запис

    private func persist() {
        if game.phase == .Finished {
            store.clear()                                  // завършена игра не се продължава
        } else {
            store.save(game)
        }
    }
}
