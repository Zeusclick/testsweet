import SwiftUI

struct TopBarView: View {
    let levelLabel: String
    let matchedPairs: Int
    let totalPairs: Int
    let isSoundOn: Bool
    let onPauseTap: () -> Void
    let onSoundToggle: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            AvatarView()

            VStack(alignment: .leading, spacing: 10) {
                Text(levelLabel.uppercased())
                    .font(.system(.headline, design: .rounded))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(LinearGradient(colors: [Color(red: 0.99, green: 0.78, blue: 0.91),
                                                          Color(red: 0.8, green: 0.6, blue: 1.0)],
                                                   startPoint: .leading,
                                                   endPoint: .trailing))
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                    )
                    .foregroundColor(Color(red: 0.33, green: 0.12, blue: 0.33))

                ProgressBarView(matchedPairs: matchedPairs, totalPairs: totalPairs)
            }

            Spacer()

            VStack(spacing: 12) {
                CircularIconButton(systemName: "pause.fill", action: onPauseTap)
                CircularIconButton(systemName: isSoundOn ? "speaker.wave.2.fill" : "speaker.slash.fill",
                                   action: onSoundToggle,
                                   filler: isSoundOn ? Color.green.opacity(0.6) : Color.red.opacity(0.6))
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(LinearGradient(colors: [Color(red: 0.99, green: 0.78, blue: 0.91),
                                              Color(red: 0.88, green: 0.65, blue: 0.95)],
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .shadow(color: Color.black.opacity(0.25), radius: 12, x: 0, y: 8)
        )
    }
}

private struct CircularIconButton: View {
    let systemName: String
    let action: () -> Void
    var filler: Color = Color.white.opacity(0.3)

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(
                    Circle()
                        .fill(filler)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.4), lineWidth: 2)
                        )
                )
        }
        .buttonStyle(.plain)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}
