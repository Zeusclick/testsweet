import SwiftUI

struct GameOverView: View {
    let movesRemaining: Int
    let onRetry: () -> Void
    let onBackToStart: () -> Void

    var body: some View {
        OverlayContainer {
            VStack(spacing: 18) {
                Text("Out of moves!")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Text("No more taps left in this round. Give it another try and plan those picks carefully!")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(Color.white.opacity(0.85))
                    .multilineTextAlignment(.center)

                VStack(spacing: 6) {
                    Text("Remaining moves")
                        .font(.caption)
                        .foregroundColor(Color.white.opacity(0.7))
                    Text("\(movesRemaining)")
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .fill(Color.white.opacity(0.12))
                )

                OverlayButton(title: "Try again", background: Gradient.pink, action: onRetry)
                OverlayButton(title: "Back to level I", background: Gradient.violet, action: onBackToStart)
            }
        }
    }
}
