import Foundation

struct GameLevel: Identifiable {
    var id: Int { number }
    let number: Int
    let pairCount: Int
    let shuffleLimit: Int
    let moveLimit: Int?

    var romanNumeral: String {
        number.romanNumeral
    }
}

extension Int {
    var romanNumeral: String {
        let mapping: [(Int, String)] = [
            (1000, "M"), (900, "CM"), (500, "D"), (400, "CD"),
            (100, "C"), (90, "XC"), (50, "L"), (40, "XL"),
            (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")
        ]
        var result = ""
        var number = self
        for (value, numeral) in mapping {
            let count = number / value
            if count > 0 {
                result += String(repeating: numeral, count: count)
                number -= value * count
            }
        }
        return result
    }
}
