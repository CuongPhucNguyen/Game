






import Foundation
import SwiftUI

//decoder and encoder for use when saving and loading continueGame object from UserDefault
let decoder = JSONDecoder()
let encoder = JSONEncoder()
//For use when there is no existing save to load
let defaultData = try! encoder.encode(
    UsersData.init(currentPositionWidth: 0.0, currentPositionHeight: (UIScreen.main.bounds.height/2)-250,
                 scores: 0,
                 pointBalls: PointBallHandler.init(),
                 killBalls: KillBallHandler.init(),
                 easyMode: true,
                 leaderboard: []
  )
)
