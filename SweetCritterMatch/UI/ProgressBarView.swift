import SwiftUI

struct ProgressBarView: View {
    let matchedPairs: Int
    let totalPairs: Int

    private var segmentCount: Int {
        min(max(totalPairs, 1), 18)
    }

    private var filledSegments: Int {
        guard totalPairs > 0 else { return 0 }
        let ratio = Double(matchedPairs) / Double(totalPairs)
        return Int(round(ratio * Double(segmentCount)))
    }

    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<segmentCount, id: \.self) { index in
                Capsule()
                    .fill(fillColor(for: index))
                    .frame(width: 12, height: 24)
                    .overlay(
                        Capsule()
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 2)
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .background(
            Capsule()
                .fill(Color.white.opacity(0.12))
        )
    }

    private func fillColor(for index: Int) -> LinearGradient {
        if index < filledSegments {
            return LinearGradient(colors: [Color(red: 1.0, green: 0.82, blue: 0.35),
                                           Color(red: 1.0, green: 0.5, blue: 0.6)],
                                  startPoint: .top,
                                  endPoint: .bottom)
        } else {
            return LinearGradient(colors: [Color.white.opacity(0.25), Color.white.opacity(0.1)],
                                  startPoint: .top,
                                  endPoint: .bottom)
        }
    }
}
