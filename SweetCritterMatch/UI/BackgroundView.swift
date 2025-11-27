import SwiftUI

struct BackgroundView: View {
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            LinearGradient(colors: [Color(red: 0.07, green: 0.12, blue: 0.28),
                                     Color(red: 0.1, green: 0.17, blue: 0.38),
                                     Color(red: 0.17, green: 0.25, blue: 0.48)],
                           startPoint: .top,
                           endPoint: .bottom)
                .overlay(backdropShapes(size: size))
        }
    }

    @ViewBuilder
    private func backdropShapes(size: CGSize) -> some View {
        let pastelPink = Color(red: 1.0, green: 0.62, blue: 0.82).opacity(0.25)
        let pastelBlue = Color(red: 0.58, green: 0.78, blue: 1.0).opacity(0.22)
        let mint = Color(red: 0.6, green: 0.92, blue: 0.84).opacity(0.18)

        ZStack {
            Circle()
                .fill(pastelPink)
                .frame(width: size.width * 0.9)
                .position(x: size.width * 0.8, y: size.height * 0.1)
                .blur(radius: 40)

            RoundedRectangle(cornerRadius: 180, style: .continuous)
                .fill(pastelBlue)
                .frame(width: size.width * 0.8, height: size.height * 0.5)
                .rotationEffect(.degrees(-18))
                .position(x: size.width * 0.2, y: size.height * 0.4)
                .blur(radius: 50)

            Circle()
                .fill(mint)
                .frame(width: size.width * 0.7)
                .position(x: size.width * 0.5, y: size.height * 0.85)
                .blur(radius: 65)
        }
    }
}
