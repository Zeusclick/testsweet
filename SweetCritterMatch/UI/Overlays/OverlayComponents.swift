import SwiftUI

struct OverlayContainer<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        ZStack {
            Color.black.opacity(0.45)
                .ignoresSafeArea()

            content
                .padding(28)
                .background(
                    RoundedRectangle(cornerRadius: 44, style: .continuous)
                        .fill(Color(red: 0.16, green: 0.24, blue: 0.46).opacity(0.96))
                        .overlay(
                            RoundedRectangle(cornerRadius: 44, style: .continuous)
                                .stroke(Color.white.opacity(0.18), lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.4), radius: 28, x: 0, y: 24)
                )
                .padding(.horizontal, 32)
        }
    }
}

struct OverlayButton: View {
    let title: String
    let background: Gradient
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(LinearGradient(gradient: background,
                                             startPoint: .topLeading,
                                             endPoint: .bottomTrailing))
                )
        }
        .buttonStyle(.plain)
    }
}

extension Gradient {
    static let pink = Gradient(colors: [Color(red: 1.0, green: 0.73, blue: 0.87),
                                        Color(red: 0.96, green: 0.43, blue: 0.73)])
    static let blue = Gradient(colors: [Color(red: 0.7, green: 0.87, blue: 1.0),
                                        Color(red: 0.36, green: 0.6, blue: 0.98)])
    static let violet = Gradient(colors: [Color(red: 0.83, green: 0.76, blue: 1.0),
                                          Color(red: 0.55, green: 0.48, blue: 0.96)])
    static let mint = Gradient(colors: [Color(red: 0.74, green: 0.97, blue: 0.85),
                                        Color(red: 0.4, green: 0.88, blue: 0.67)])
}
