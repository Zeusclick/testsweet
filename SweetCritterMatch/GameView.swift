import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea()

            VStack(spacing: 18) {
                TopBarView(
                    levelLabel: "Level \(viewModel.currentLevel.romanNumeral)",
                    matchedPairs: viewModel.matchedPairs,
                    totalPairs: viewModel.currentLevel.pairCount,
                    isSoundOn: viewModel.isSoundOn,
                    onPauseTap: { withAnimation(.spring()) { viewModel.togglePause() } },
                    onSoundToggle: { viewModel.toggleSound() }
                )
                .padding(.top, 8)

                BoardView(tiles: viewModel.tiles) { tile in
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                        viewModel.selectTile(tile)
                    }
                }

                BottomControlsView(
                    remainingMoves: viewModel.remainingMoves,
                    remainingShuffles: viewModel.remainingShuffles,
                    onShuffle: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            viewModel.shuffleBoard()
                        }
                    }
                )
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
        .overlay(alignment: .center) {
            ZStack {
                if viewModel.isPaused {
                    PauseMenuView(
                        onResume: { withAnimation(.spring()) { viewModel.togglePause() } },
                        onRestart: { withAnimation(.spring()) { viewModel.resetLevel() } },
                        onQuit: { withAnimation(.spring()) { viewModel.startLevel(1) } }
                    )
                    .transition(.opacity.combined(with: .scale))
                }

                if viewModel.isLevelCompleted {
                    LevelCompleteView(
                        levelLabel: viewModel.currentLevel.romanNumeral,
                        matchedPairs: viewModel.matchedPairs,
                        totalPairs: viewModel.currentLevel.pairCount,
                        movesUsed: movesUsed,
                        onNextLevel: { withAnimation(.spring()) { viewModel.nextLevel() } },
                        onRestart: { withAnimation(.spring()) { viewModel.resetLevel() } }
                    )
                    .transition(.opacity.combined(with: .scale))
                }

                if viewModel.isGameOver {
                    GameOverView(
                        movesRemaining: viewModel.remainingMoves ?? 0,
                        onRetry: { withAnimation(.spring()) { viewModel.resetLevel() } },
                        onBackToStart: { withAnimation(.spring()) { viewModel.startLevel(1) } }
                    )
                    .transition(.opacity.combined(with: .scale))
                }
            }
        }
    }

    private var movesUsed: Int? {
        guard let limit = viewModel.currentLevel.moveLimit,
              let remaining = viewModel.remainingMoves else { return nil }
        return limit - remaining
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
