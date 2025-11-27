import SwiftUI

struct BottomControlsView: View {
    let remainingMoves: Int?
    let remainingShuffles: Int
    let onShuffle: () -> Void

    private var shuffleDisabled: Bool { remainingShuffles == 0 }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Moves")
                    .font(.caption)
                    .foregroundColor(Color.white.opacity(0.7))
                Text(movesText)
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.white)
            }

            Spacer()

            Button(action: onShuffle) {
                VStack {
                    Image(systemName: "arrow.2.circlepath")
                        .font(.system(size: 22, weight: .semibold))
                    Text("Shuffle")
                        .font(.system(.footnote, design: .rounded))
                }
                .foregroundColor(.white)
                .frame(width: 100, height: 100)
                .background(
                    Circle()
                        .fill(shuffleDisabled ? Color.white.opacity(0.08)
                                              : LinearGradient(colors: [Color(red: 0.98, green: 0.71, blue: 0.92),
                                                                        Color(red: 0.71, green: 0.62, blue: 1.0)],
                                                               startPoint: .top,
                                                               endPoint: .bottom))
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.25), lineWidth: 2)
                        )
                )
                .shadow(color: shuffleDisabled ? .clear : Color.black.opacity(0.25), radius: 12, x: 0, y: 8)
            }
            .buttonStyle(.plain)
            .disabled(shuffleDisabled)

            Spacer()

            VStack(alignment: .trailing) {
                Text("Shuffles")
                    .font(.caption)
                    .foregroundColor(Color.white.opacity(0.7))
                Text("\(remainingShuffles)")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .background(
            RoundedRectangle(cornerRadius: 34, style: .continuous)
                .fill(Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 34, style: .continuous)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 8)
        )
    }

    private var movesText: String {
        if let remainingMoves {
            return "\(remainingMoves)"
        }
        return "∞"
    }
}
