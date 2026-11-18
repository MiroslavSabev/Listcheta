//
//  GameStore.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 18.11.26.
//

import Foundation

struct GameStore {

    private let fileURL: URL

    init(fileName: String = "current-game.json") {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory,
                                           in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        self.fileURL = dir.appendingPathComponent(fileName)
    }

    func load() -> Game? {
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return try? JSONDecoder().decode(Game.self, from: data)
    }

    func save(_ game: Game) {
        guard let data = try? JSONEncoder().encode(game) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    func clear() {
        try? FileManager.default.removeItem(at: fileURL)
    }
}
