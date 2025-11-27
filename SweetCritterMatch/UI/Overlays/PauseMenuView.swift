import SwiftUI

struct PauseMenuView: View {
    let onResume: () -> Void
    let onRestart: () -> Void
    let onQuit: () -> Void

    var body: some View {
        OverlayContainer {
            VStack(spacing: 18) {
                Text("Paused")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Text("Take a breather! Tap resume when you're ready to match more critters.")
                    .font(.system(.body, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white.opacity(0.85))
                    .padding(.horizontal)

                OverlayButton(title: "Resume", background: Gradient.pink, action: onResume)
                OverlayButton(title: "Restart level", background: Gradient.blue, action: onRestart)
                OverlayButton(title: "Quit to level I", background: Gradient.violet, action: onQuit)
            }
        }
    }
}
