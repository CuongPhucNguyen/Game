import Foundation
import SwiftUI

class UsersData: Codable{
  var currentPosition: CGSize
  var scores: Int
  var pointBalls: PointBallHandler
  var killBalls: KillBallHandler
  var easyMode: Bool
  var leaderboard: [PlayerData]
    init(currentPosition: CGSize, scores: Int, pointBalls: PointBallHandler, killBalls: KillBallHandler, easyMode: Bool, leaderboard: [PlayerData]){
        self.currentPosition = currentPosition
        self.scores = scores
        self.pointBalls = pointBalls
        self.killBalls  = killBalls
        self.easyMode = easyMode
        self.leaderboard = leaderboard
    }
}

class PlayerData: Codable{
  var name: String
  var score: Int
}
