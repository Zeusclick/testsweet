import SwiftUI

struct Tile: Identifiable, Equatable {
    let id: UUID
    let emoji: String
    let shape: TileShape
    let colorTheme: TileColorTheme
    var isMatched: Bool
    var isSelected: Bool
    var positionIndex: Int
}

enum TileShape: CaseIterable {
    case square
    case hexagon
    case circle
    case triangle

    var anyShape: AnyShape {
        switch self {
        case .square:
            return AnyShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        case .hexagon:
            return AnyShape(HexagonShape())
        case .circle:
            return AnyShape(Circle())
        case .triangle:
            return AnyShape(TriangleShape())
        }
    }
}

struct AnyShape: Shape {
    private let builder: (CGRect) -> Path

    init<S: Shape>(_ shape: S) {
        builder = { rect in
            shape.path(in: rect)
        }
    }

    func path(in rect: CGRect) -> Path {
        builder(rect)
    }
}

struct HexagonShape: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.size.width
        let height = rect.size.height
        let spacing = width * 0.1
        let topHeight = height * 0.25

        var path = Path()
        path.move(to: CGPoint(x: width / 2, y: 0))
        path.addLine(to: CGPoint(x: width - spacing, y: topHeight))
        path.addLine(to: CGPoint(x: width - spacing, y: height - topHeight))
        path.addLine(to: CGPoint(x: width / 2, y: height))
        path.addLine(to: CGPoint(x: spacing, y: height - topHeight))
        path.addLine(to: CGPoint(x: spacing, y: topHeight))
        path.closeSubpath()
        return path
    }
}

struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

enum TileColorTheme: CaseIterable {
    case pink
    case lightBlue
    case mint
    case yellow
    case violet

    var gradient: LinearGradient {
        LinearGradient(colors: [palette.start, palette.end],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }

    var borderGradient: LinearGradient {
        LinearGradient(colors: [palette.borderStart, palette.borderEnd],
                       startPoint: .top,
                       endPoint: .bottom)
    }

    var highlight: Color {
        Color.white.opacity(0.35)
    }

    var shadow: Color {
        palette.shadow
    }

    private var palette: (start: Color, end: Color, borderStart: Color, borderEnd: Color, shadow: Color) {
        switch self {
        case .pink:
            return (
                start: Color(red: 1.0, green: 0.78, blue: 0.9),
                end: Color(red: 1.0, green: 0.54, blue: 0.78),
                borderStart: Color(red: 1.0, green: 0.45, blue: 0.71),
                borderEnd: Color(red: 1.0, green: 0.86, blue: 0.94),
                shadow: Color(red: 0.94, green: 0.3, blue: 0.6).opacity(0.8)
            )
        case .lightBlue:
            return (
                start: Color(red: 0.73, green: 0.89, blue: 1.0),
                end: Color(red: 0.4, green: 0.7, blue: 1.0),
                borderStart: Color(red: 0.33, green: 0.56, blue: 0.97),
                borderEnd: Color(red: 0.78, green: 0.93, blue: 1.0),
                shadow: Color(red: 0.2, green: 0.42, blue: 0.85).opacity(0.8)
            )
        case .mint:
            return (
                start: Color(red: 0.76, green: 0.96, blue: 0.87),
                end: Color(red: 0.43, green: 0.86, blue: 0.7),
                borderStart: Color(red: 0.28, green: 0.73, blue: 0.56),
                borderEnd: Color(red: 0.82, green: 0.98, blue: 0.92),
                shadow: Color(red: 0.17, green: 0.55, blue: 0.44).opacity(0.8)
            )
        case .yellow:
            return (
                start: Color(red: 1.0, green: 0.95, blue: 0.75),
                end: Color(red: 1.0, green: 0.82, blue: 0.44),
                borderStart: Color(red: 0.95, green: 0.68, blue: 0.25),
                borderEnd: Color(red: 1.0, green: 0.98, blue: 0.85),
                shadow: Color(red: 0.77, green: 0.52, blue: 0.18).opacity(0.8)
            )
        case .violet:
            return (
                start: Color(red: 0.86, green: 0.8, blue: 1.0),
                end: Color(red: 0.65, green: 0.55, blue: 0.98),
                borderStart: Color(red: 0.49, green: 0.38, blue: 0.89),
                borderEnd: Color(red: 0.9, green: 0.84, blue: 1.0),
                shadow: Color(red: 0.38, green: 0.28, blue: 0.74).opacity(0.8)
            )
        }
    }
}
