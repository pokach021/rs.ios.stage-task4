import Foundation

public extension Int {
    
    var roman: String? {
        var number = self
        var romanNumber = ""
        let list: [(arabiс: Int, roman: String)] = [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"), (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]
        if number <= 0 {
            return nil
        }
            for i in list {
                while number >= i.arabiс {
                    number -= i.arabiс
                    romanNumber += i.roman
                }
            }
        return romanNumber
    }
}
