import Foundation
import SwiftUI

class UsersData: Codable{
  var currentPositionWidth: Double
  var currentPositionHeight: Double
  var scores: Int
  var pointBalls: PointBallHandler
  var killBalls: KillBallHandler
  var easyMode: Bool
  var leaderboard: [PlayerData]
    init(currentPositionWidth: Double, currentPositionHeight: Double, scores: Int, pointBalls: PointBallHandler, killBalls: KillBallHandler, easyMode: Bool, leaderboard: [PlayerData]){
        self.currentPositionWidth = currentPositionWidth
        self.currentPositionHeight = currentPositionHeight
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


