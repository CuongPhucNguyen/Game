






import Foundation

//decoder and encoder for use when saving and loading continueGame object from UserDefault
let decoder = JSONDecoder()
let encoder = JSONEncoder()
//For use when there is no existing save to load
//let defaultData = try! encoder.encode(continueGame(gameDeck: Deck(), dealerHand: [], playerHand: [], showIntro: true, playerMoney: 100, betAmount: 10, gameLoss: false, gameWin: false, roundBust: false, roundWin: false, doubleDown: false, doubleAvailable: true, continueTrue: false))
