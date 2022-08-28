import Foundation
import SwiftUI

class UsersData: Codable{
  var currentPosition: CGSize
  var scores: Int
  var pointBalls: PointBallHandler
  var killBalls: KillBallHandler
  var easyMode: Bool
  var leaderboard: [PlayerData]
}

class PlayerData: Codable{
  var name: String
  var score: Int
}
