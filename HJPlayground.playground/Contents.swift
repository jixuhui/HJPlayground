
import UIKit

@objc protocol CarProtocol {
    optional var name: String{get}
    optional var speed: Float{get}
    optional var price: Float{get}
    
    optional func printMe()
    optional func descriptionMe() -> String
}

extension CarProtocol {
    func printMe() {
        print("The car's name is \(self.name), speed is \(String(self.speed)) km/s and price is \(String(self.price)) thousand dollar")
    }
    
    func descriptionMe() -> String {
        return "The car's name is \(self.name), speed is \(String(self.speed)) km/s and price is \(String(self.price)) thousand dollar"
    }
}

class Benz: CarProtocol {
    
    @objc var name: String{
        return "Mercedes-Benz"
    }
    
    @objc var speed: Float{
        return 100.0
    }
    
    @objc var price: Float{
        return 100
    }
}

class Bmw: CarProtocol {
    
    @objc var name: String{
        return "BMW"
    }
    
    @objc var speed: Float{
        return 120.0
    }
    
    @objc var price: Float{
        return 130
    }
}

class RichMan {
    var moneyCount: String
    var car: CarProtocol            //protocol is type
    
    init(moneyCount: String, car: CarProtocol){
        self.moneyCount = moneyCount
        self.car = car
    }
}

protocol TextFormator {
    func textFormat() -> String?
}

extension RichMan: TextFormator {
    func textFormat() -> String? {
        return self.car.name
    }
}

extension CollectionType where Generator.Element: TextFormator {
    func printFormateElements() -> String {
        let itemsAsText: [String] = self.map { $0.textFormat()! }//此处必须定义itemsAsText的类型为[String],否则下一句无法执行
        return "[" + itemsAsText.joinWithSeparator("、") + "]"
    }
}

var benzRich: RichMan = RichMan(moneyCount: "just a number", car: Benz())
var bmwRich: RichMan = RichMan(moneyCount: "10 billion", car: Bmw())

let richMans = [benzRich,bmwRich]
print(richMans.printFormateElements())


/**
*  @author hubbert, 15-12-21 11:12:09
*
*  @brief protocol dice game
*
*  @since
*/

//protocol RandomNumberGenerator {
//    func random() -> Double
//}
//
////线性同余法生成随机数：http://www.cnblogs.com/xkfz007/archive/2012/03/27/2420154.html
//class LinearCongruentialGenerator: RandomNumberGenerator {
//    var lastRandom = 42.0
//    let m = 139968.0
//    let a = 3877.0
//    let c = 29573.0
//    func random() -> Double {
//        lastRandom = ((lastRandom * a + c) % m)//线性同余方程式
//        return lastRandom / m
//    }
//}
//
////骰子[tóu zǐ] 色子[shǎi zǐ]
//
//class Dice {
//    let sides: Int
//    let generator: RandomNumberGenerator
//    init(sides: Int, generator: RandomNumberGenerator) {
//        self.sides = sides
//        self.generator = generator
//    }
//    func roll() -> Int {
//        return Int(generator.random() * Double(sides)) + 1
//    }
//}
////Class-Only Protocols
//@objc protocol TextRepresentable: class {
//    optional var textualDescription: String { get }
//}
//
//extension Dice: TextRepresentable {
//    @objc var textualDescription: String {
//        return "A \(sides)-sided dice"
//    }
//}
//
//protocol DiceGame {
//    var dice: Dice { get }
//    func play()
//}
//protocol DiceGameDelegate {
//    func gameDidStart(game: DiceGame)
//    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
//    func gameDidEnd(game: DiceGame)
//}
//
//class SnakesAndLadders: DiceGame {
//    let finalSquare = 25
//    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
//    var square = 0
//    var board: [Int]
//    init() {
//        board = [Int](count: finalSquare + 1, repeatedValue: 0)
//        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
//        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
//    }
//    var delegate: DiceGameDelegate?
//    func play() {
//        square = 0
//        delegate?.gameDidStart(self)
//        gameLoop: while square != finalSquare {
//            let diceRoll = dice.roll()
//            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
//            switch square + diceRoll {
//            case finalSquare:
//                break gameLoop
//            case let newSquare where newSquare > finalSquare:
//                continue gameLoop
//            default:
//                square += diceRoll
//                square += board[square]
//            }
//        }
//        delegate?.gameDidEnd(self)
//    }
//}
//
//protocol PrettyTextRepresentable: TextRepresentable {
//    var prettyTextualDescription: String { get }
//}
//
//extension SnakesAndLadders: TextRepresentable {
//    @objc var textualDescription: String {
//        return "A game of Snakes and Ladders with \(finalSquare) squares"
//    }
//}
//
//extension SnakesAndLadders: PrettyTextRepresentable {
//    var prettyTextualDescription: String {
//        var output = textualDescription + ":\n"
//        for index in 1...finalSquare {
//            switch board[index] {
//            case let ladder where ladder > 0:
//                output += "▲ "
//            case let snake where snake < 0:
//                output += "▼ "
//            default:
//                output += "○ "
//            }
//        }
//        return output
//    }
//}
//
//class DiceGameTracker: DiceGameDelegate {
//    var numberOfTurns = 0
//    func gameDidStart(game: DiceGame) {
//        numberOfTurns = 0
//        if game is SnakesAndLadders {
//            print("Started a new game of Snakes and Ladders")
//        }
//        print("The game is using a \(game.dice.sides)-sided dice")
//    }
//    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
//        ++numberOfTurns
//        print("Rolled a \(diceRoll)")
//    }
//    func gameDidEnd(game: DiceGame) {
//        print("The game lasted for \(numberOfTurns) turns")
//    }
//}
//
//extension RandomNumberGenerator {
//    func randomBool() -> Bool {
//        return random() > 0.5
//    }
//}
//
//let tracker = DiceGameTracker()
//let game = SnakesAndLadders()
//var strTemp: String?
//
//if let str = strTemp as? DiceGameDelegate {
//    print("strTemp is adopt to DiceGameDelegate")
//}else {
//    print("strTemp is not adopt to DiceGameDelegate")
//}
//
//print(game.textualDescription)
//print(game.prettyTextualDescription)
//game.delegate = tracker
//game.play()
//
//print("Here is a random boolean value:\(game.dice.generator.randomBool())")

