import SwiftUI

struct AvatarView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(LinearGradient(colors: [Color(red: 0.98, green: 0.75, blue: 0.9),
                                              Color(red: 0.9, green: 0.58, blue: 0.85)],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing))
                .frame(width: 76, height: 90)
                .shadow(color: Color.black.opacity(0.2), radius: 12, x: 0, y: 10)

            VStack(spacing: 4) {
                ZStack {
                    Circle()
                        .fill(Color(red: 1.0, green: 0.86, blue: 0.8))
                        .frame(width: 60, height: 60)

                    VStack(spacing: 6) {
                        HStack(spacing: 10) {
                            eye
                            eye
                        }
                        smile
                    }
                    .offset(y: 4)
                }

                Capsule()
                    .fill(LinearGradient(colors: [Color(red: 0.97, green: 0.66, blue: 0.82),
                                                   Color(red: 0.85, green: 0.45, blue: 0.73)],
                                          startPoint: .leading,
                                          endPoint: .trailing))
                    .frame(width: 70, height: 28)
                    .overlay(
                        Capsule()
                            .stroke(Color.white.opacity(0.6), lineWidth: 2)
                    )
                    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
            }
            .offset(y: 2)

            hoodieEars
        }
        .frame(width: 90, height: 110)
    }

    private var eye: some View {
        Circle()
            .fill(Color(red: 0.2, green: 0.15, blue: 0.3))
            .frame(width: 8, height: 8)
            .shadow(color: Color.white.opacity(0.4), radius: 1, x: 0, y: 1)
    }

    private var smile: some View {
        Capsule()
            .trim(from: 0.1, to: 0.9)
            .stroke(Color(red: 0.85, green: 0.3, blue: 0.45), style: StrokeStyle(lineWidth: 3, lineCap: .round))
            .frame(width: 24, height: 12)
    }

    private var hoodieEars: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(red: 0.9, green: 0.58, blue: 0.85))
                .frame(width: 32, height: 38)
                .rotationEffect(.degrees(-18))
                .offset(x: -26, y: -42)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.white.opacity(0.4), lineWidth: 2)
                )

            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(red: 0.9, green: 0.58, blue: 0.85))
                .frame(width: 32, height: 38)
                .rotationEffect(.degrees(18))
                .offset(x: 26, y: -42)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.white.opacity(0.4), lineWidth: 2)
                )
        }
    }
}
