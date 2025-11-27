import SwiftUI

struct BoardView: View {
    let tiles: [Tile]
    let onTileTap: (Tile) -> Void

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ZStack {
                ForEach(tiles) { tile in
                    TileView(tile: tile)
                        .frame(width: tileSize(for: size), height: tileSize(for: size))
                        .rotationEffect(rotation(for: tile))
                        .offset(offset(for: tile, in: size))
                        .zIndex(tile.isSelected ? 1 : 0)
                        .onTapGesture {
                            onTileTap(tile)
                        }
                        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: tile.isSelected)
                        .animation(.easeInOut(duration: 0.25), value: tile.isMatched)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(minHeight: 320, idealHeight: 420, maxHeight: 520)
        .padding(.vertical, 12)
    }

    private func tileSize(for size: CGSize) -> CGFloat {
        min(min(size.width, size.height) / 4, 110)
    }

    private func offset(for tile: Tile, in size: CGSize) -> CGSize {
        let spread = min(size.width, size.height) * 0.25
        let xSeed = seededValue(for: tile.positionIndex, salt: 7)
        let ySeed = seededValue(for: tile.positionIndex, salt: 13)
        return CGSize(
            width: (xSeed - 0.5) * spread,
            height: (ySeed - 0.5) * spread
        )
    }

    private func rotation(for tile: Tile) -> Angle {
        let seed = seededValue(for: tile.positionIndex, salt: 23)
        return Angle(degrees: (seed - 0.5) * 30)
    }

    private func seededValue(for base: Int, salt: Int) -> CGFloat {
        let combined = abs(base &* 31 &+ salt * 131)
        return CGFloat(combined % 1000) / 1000
    }
}

private struct TileView: View {
    let tile: Tile

    var body: some View {
        tile.shape.anyShape
            .fill(tile.colorTheme.gradient)
            .overlay(
                tile.shape.anyShape
                    .stroke(tile.colorTheme.borderGradient, lineWidth: 4)
            )
            .overlay(
                tile.shape.anyShape
                    .fill(tile.colorTheme.highlight)
                    .opacity(0.25)
                    .blur(radius: 8)
                    .mask(
                        tile.shape.anyShape
                            .fill(LinearGradient(colors: [.white.opacity(0.9), .clear],
                                                 startPoint: .top, endPoint: .bottom))
                    )
            )
            .overlay(
                Text(tile.emoji)
                    .font(.system(size: 44))
                    .minimumScaleFactor(0.5)
            )
            .shadow(color: tile.colorTheme.shadow,
                    radius: tile.isSelected ? 16 : 10,
                    x: 0,
                    y: tile.isSelected ? 14 : 10)
            .scaleEffect(tile.isSelected ? 1.08 : (tile.isMatched ? 0.2 : 1))
            .opacity(tile.isMatched ? 0 : 1)
    }
}
