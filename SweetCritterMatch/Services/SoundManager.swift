import AudioToolbox
import Foundation

enum GameSound {
    case tap
    case match
    case shuffle
    case win
    case lose

    var systemSoundID: SystemSoundID {
        switch self {
        case .tap:
            return 1104 // keyboard tap
        case .match:
            return 1110 // Tock
        case .shuffle:
            return 4095 // bloop
        case .win:
            return 1113 // victory
        case .lose:
            return 1106 // short fail
        }
    }
}

final class SoundManager {
    static let shared = SoundManager()
    private init() {}

    func play(_ sound: GameSound, enabled: Bool) {
        guard enabled else { return }
        AudioServicesPlaySystemSound(sound.systemSoundID)
    }
}
