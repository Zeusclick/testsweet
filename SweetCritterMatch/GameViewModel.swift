import Foundation
import SwiftUI

final class GameViewModel: ObservableObject {
    @Published var currentLevel: GameLevel
    @Published var tiles: [Tile] = []
    @Published var selectedTile: Tile?
    @Published var matchedPairs: Int = 0
    @Published var remainingShuffles: Int = 0
    @Published var remainingMoves: Int?
    @Published var isLevelCompleted: Bool = false
    @Published var isGameOver: Bool = false
    @Published var isPaused: Bool = false
    @Published var isSoundOn: Bool = true

    private let animalEmojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐔", "🦄"]
    private let levels: [GameLevel] = [
        GameLevel(number: 1, pairCount: 10, shuffleLimit: 3, moveLimit: nil),
        GameLevel(number: 2, pairCount: 12, shuffleLimit: 3, moveLimit: 45),
        GameLevel(number: 3, pairCount: 14, shuffleLimit: 3, moveLimit: 40),
        GameLevel(number: 4, pairCount: 16, shuffleLimit: 2, moveLimit: 38),
        GameLevel(number: 5, pairCount: 18, shuffleLimit: 2, moveLimit: 35),
        GameLevel(number: 6, pairCount: 20, shuffleLimit: 2, moveLimit: 32)
    ]
    private var currentLevelIndex: Int = 0

    init() {
        let initialLevel = levels.first ?? GameLevel(number: 1, pairCount: 10, shuffleLimit: 3, moveLimit: 50)
        currentLevel = initialLevel
        currentLevelIndex = levels.firstIndex(where: { $0.number == initialLevel.number }) ?? 0
        setupLevel(initialLevel)
    }

    func startLevel(_ levelNumber: Int) {
        guard let index = levels.firstIndex(where: { $0.number == levelNumber }) else { return }
        currentLevelIndex = index
        let level = levels[index]
        currentLevel = level
        setupLevel(level)
    }

    func selectTile(_ tile: Tile) {
        guard !isPaused, !isLevelCompleted, !isGameOver else { return }
        guard let tappedIndex = tiles.firstIndex(where: { $0.id == tile.id }) else { return }
        guard !tiles[tappedIndex].isMatched else { return }

        if let currentSelection = selectedTile, currentSelection.id == tile.id {
            tiles[tappedIndex].isSelected = false
            selectedTile = nil
            return
        }

        if selectedTile == nil {
            tiles[tappedIndex].isSelected = true
            selectedTile = tiles[tappedIndex]
            SoundManager.shared.play(.tap, enabled: isSoundOn)
            return
        }

        guard let previousSelection = selectedTile,
              let previousIndex = tiles.firstIndex(where: { $0.id == previousSelection.id }) else {
            tiles[tappedIndex].isSelected = true
            selectedTile = tiles[tappedIndex]
            SoundManager.shared.play(.tap, enabled: isSoundOn)
            return
        }

        tiles[tappedIndex].isSelected = true

        if previousSelection.emoji == tile.emoji {
            tiles[previousIndex].isMatched = true
            tiles[tappedIndex].isMatched = true
            tiles[previousIndex].isSelected = false
            tiles[tappedIndex].isSelected = false
            matchedPairs += 1
            selectedTile = nil
            SoundManager.shared.play(.match, enabled: isSoundOn)
        } else {
            tiles[previousIndex].isSelected = false
            selectedTile = tiles[tappedIndex]
            SoundManager.shared.play(.tap, enabled: isSoundOn)
        }

        if let moves = remainingMoves {
            remainingMoves = max(moves - 1, 0)
        }

        checkWinLoseConditions()
    }

    func shuffleBoard() {
        guard remainingShuffles > 0, !isPaused, !isLevelCompleted, !isGameOver else { return }
        var updatedTiles = tiles
        for index in updatedTiles.indices where !updatedTiles[index].isMatched {
            updatedTiles[index].positionIndex = Int.random(in: 0..<2000)
        }
        updatedTiles.shuffle()
        tiles = updatedTiles
        if let selected = selectedTile {
            selectedTile = tiles.first(where: { $0.id == selected.id })
        }
        remainingShuffles -= 1
        SoundManager.shared.play(.shuffle, enabled: isSoundOn)
    }

    func togglePause() {
        guard !isLevelCompleted, !isGameOver else { return }
        isPaused.toggle()
    }

    func toggleSound() {
        isSoundOn.toggle()
    }

    func resetLevel() {
        startLevel(currentLevel.number)
    }

    func nextLevel() {
        let nextIndex = (currentLevelIndex + 1) % levels.count
        startLevel(levels[nextIndex].number)
    }

    private func setupLevel(_ level: GameLevel) {
        matchedPairs = 0
        remainingShuffles = level.shuffleLimit
        remainingMoves = level.moveLimit
        isLevelCompleted = false
        isGameOver = false
        isPaused = false
        selectedTile = nil
        tiles = buildTiles(for: level)
    }

    private func buildTiles(for level: GameLevel) -> [Tile] {
        var result: [Tile] = []
        let emojis = animalEmojis.shuffled()
        for pairIndex in 0..<level.pairCount {
            let emoji = emojis[pairIndex % emojis.count]
            let shape = TileShape.allCases.randomElement() ?? .square
            let color = TileColorTheme.allCases.randomElement() ?? .pink
            let basePosition = Int.random(in: 0..<1000)
            let tileA = Tile(id: UUID(),
                             emoji: emoji,
                             shape: shape,
                             colorTheme: color,
                             isMatched: false,
                             isSelected: false,
                             positionIndex: basePosition)
            let tileB = Tile(id: UUID(),
                             emoji: emoji,
                             shape: TileShape.allCases.randomElement() ?? shape,
                             colorTheme: TileColorTheme.allCases.randomElement() ?? color,
                             isMatched: false,
                             isSelected: false,
                             positionIndex: Int.random(in: 0..<1000))
            result.append(contentsOf: [tileA, tileB])
        }
        return result.shuffled()
    }

    private func checkWinLoseConditions() {
        if matchedPairs >= currentLevel.pairCount {
            withAnimation(.spring()) {
                isLevelCompleted = true
                isPaused = false
            }
            SoundManager.shared.play(.win, enabled: isSoundOn)
            return
        }

        if let moves = remainingMoves, moves <= 0 {
            withAnimation(.spring()) {
                isGameOver = true
                isPaused = false
            }
            SoundManager.shared.play(.lose, enabled: isSoundOn)
        }
    }
}
