/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Phuc Cuong
 ID: s3881006
 Created  date: 24/08/2022
 Last modified: 28/08/2022
 */


import Foundation
import SwiftUI


struct GameOverView : View {
    @Binding var gameOver: Bool
    @Binding var gameView: Bool
    @Binding var points: Int
    @Binding var highscores: [String:Int]
    @State var name: String = ""
    var body: some View{
        ZStack{
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            VStack{
                Text("GAME OVER")
                Text("YOUR POINTS: \(points)")
                TextField("Enter your name", text: $name)
                Button("Return to menu"){
                    gameOver = false
                    gameView = false
                    highscores[name] = points
                    highscores[name] = points
                    UserDefaults.standard.set(highscores,forKey: "highscores")
                    UserDefaults.standard.set(0, forKey: "scores")
                    UserDefaults.standard.set(0, forKey: "currentPositionWidth")
                    UserDefaults.standard.set(-(UIScreen.main.bounds.height/2 - 250), forKey: "currentPositionHeight")
                    points = 0
                }
            }
        }
    }
    init(gameOver: Binding<Bool>, gameView: Binding<Bool>, points: Binding<Int>, highscores: Binding<[String:Int]>){
        self._gameOver = gameOver
        self._gameView = gameView
        self._points = points
        self._highscores = highscores
    }
}
