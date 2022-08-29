/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Phuc Cuong
 ID: s3881006
 Created  date: 05/08/2022
 Last modified: 28/08/2022
 */


import SwiftUI

@main
struct GameApp: App {
    @State var gameOver = false
    @State var gameView = false
    @State var optionView = false
    @State var leaderboardView = false
    @State var howToPlayView = false
    @State var easyMode = true
    @State var points = 0
    @State var highscore = UserDefaults.standard.object(forKey: "highscores") as? [String:Int] ?? [:]
    var body: some Scene {
        WindowGroup {
            ZStack{
                MenuScreen(gameView: $gameView, optionView: $optionView, leaderboardView: $leaderboardView, howToPlayView: $howToPlayView)
                
                if (optionView){
                    OptionView(easyMode: $easyMode, optionView: $optionView)
                }
                
                if (howToPlayView){
                    HowToPlayView(howToPlayView: $howToPlayView)
                }
                
                if (gameView){
                    EnvironmentManager(environmentObjectArray: [], gameOver: $gameOver, gameView: $gameView, easyMode: $easyMode, points: $points)
                }
                if (leaderboardView){
                    LeaderBoardView(LeaderBoardView: $leaderboardView, highscore: $highscore)
                }
                if (gameOver){
                    GameOverView(gameOver: $gameOver, gameView: $gameView, points: $points, highscores: $highscore)
                }
            }
        }
        
    }
}
