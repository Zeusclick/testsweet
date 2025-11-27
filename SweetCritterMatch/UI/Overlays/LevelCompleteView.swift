import SwiftUI

struct LevelCompleteView: View {
    let levelLabel: String
    let matchedPairs: Int
    let totalPairs: Int
    let movesUsed: Int?
    let onNextLevel: () -> Void
    let onRestart: () -> Void

    var body: some View {
        OverlayContainer {
            VStack(spacing: 16) {
                Text("Level \(levelLabel) Completed!")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)

                Text(statsText)
                    .font(.system(.body, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white.opacity(0.8))

                HStack(spacing: 12) {
                    statCard(title: "Pairs", value: "\(matchedPairs)/\(totalPairs)", icon: "heart.fill")
                    statCard(title: "Moves", value: movesUsedText, icon: "bolt.fill")
                }

                OverlayButton(title: "Next level", background: Gradient.mint, action: onNextLevel)
                OverlayButton(title: "Replay", background: Gradient.blue, action: onRestart)
            }
        }
    }

    private var statsText: String {
        "You cleared every critter tile. Ready for a trickier pile?"
    }

    private var movesUsedText: String {
        if let movesUsed {
            return "\(movesUsed)"
        }
        return "Free"
    }

    @ViewBuilder
    private func statCard(title: String, value: String, icon: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.white)
            Text(value)
                .font(.system(.title2, design: .rounded))
                .foregroundColor(.white)
            Text(title)
                .font(.system(.caption, design: .rounded))
                .foregroundColor(Color.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Color.white.opacity(0.12))
        )
    }
}
