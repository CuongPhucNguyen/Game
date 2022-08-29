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

import Foundation
import SwiftUI

struct EnvironmentManager: View {
//    @State var playerPosChanging: Bool = false
    @Binding var gameView: Bool
    @Binding var gameOver: Bool
    @Binding var easyMode: Bool
    @State var environmentObjectArray: [EnvironmentObject]
    @State var killBalls: KillBallHandler
    @State var pointBalls: PointBallHandler
    @Binding var points: Int
    @State var allAdded: Bool = false
    var body : some View {
        ZStack{
            
            
            Image("background")
                .resizable()
                .frame(height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            Rectangle()
                .foregroundColor(Color(red: 10/255, green: 88/255, blue: 90/255))
                .frame(width: UIScreen.main.bounds.width, height:250)
                .offset(x: 0.0,y: UIScreen.main.bounds.height/2 - 250 + 64/2 + 250/2)
            ForEach(environmentObjectArray){ object in
                Environment(environment: object)
            }
            DragHandler(points: $points, obstacles: environmentObjectArray, pointBalls: $pointBalls, killHandler: $killBalls, gameOver: $gameOver, easyMode: $easyMode)
                
            if (!pointBalls.positions.isEmpty){
                ForEach(pointBalls.positions){ position in
                    Circle()
                        .foregroundColor(.yellow)
                        .offset(position.position)
                        .frame(width: 64, height: 64)
                        .scaleEffect(1)
                        .opacity((position.added) ? 0:1)
                }
            }
            
            if (!killBalls.positions.isEmpty){
                ForEach(killBalls.positions){ position in
                    Circle()
                        .foregroundColor(.black)
                        .offset(position.position)
                        .frame(width: 64, height: 64)
                        .scaleEffect((gameOver) ? 1.5 : 1)
                }
            }
            Text("Points \(points)")
                .offset(CGSize.init(width: 0.0, height:-(UIScreen.main.bounds.height/2) + 50 + 50/2))
                .foregroundColor(.white)
            RoundedRectangle(cornerSize: CGSize.init(width: 5, height: 5))
                .offset(x: (UIScreen.main.bounds.width/2) - 100/2, y:-(UIScreen.main.bounds.height/2) + 50 + 50/2)
                .frame(width: 100, height: 50)
                .foregroundColor(.orange)
            Button("Exit"){
                gameView = false
            }
            .frame(width: 100, height: 50)
            .offset(x: (UIScreen.main.bounds.width/2) - 100/2, y:-(UIScreen.main.bounds.height/2) + 50 + 50/2)
        }
        .onChange(of: gameOver){ value in
            backgroundMusic?.stop()
        }
        .onChange(of: points){ value in
            UserDefaults.standard.set(points, forKey: "scores")
        }
    }
    init(gameOver: Binding<Bool>, gameView: Binding<Bool>, easyMode: Binding<Bool>, points: Binding<Int>){
        self.environmentObjectArray = []
        self.killBalls = KillBallHandler.init()
        self.pointBalls = PointBallHandler.init()
        self._gameOver = gameOver
        self._gameView = gameView
        self._easyMode = easyMode
        self._points = points
        self.points = UserDefaults.standard.object(forKey: "scores") as? Int ?? 0
        pointBalls = UserDefaults.standard.object(forKey: "pointBalls") as? PointBallHandler ?? PointBallHandler.init()
        if (pointBalls.positions.isEmpty){
            pointBalls.getPosition()
        }
        
        killBalls = UserDefaults.standard.object(forKey: "killBalls") as? KillBallHandler ?? KillBallHandler.init()
        if (killBalls.positions.isEmpty){
            killBalls.getPosition()
            killBalls.checkFair(position: CGSize.init(width:0.0, height: (UIScreen.main.bounds.height/2 - 250)))
        }
        
        playBackground(sound: "newBackground", type: "mp3")
        
        
    }
    init(environmentObjectArray: [EnvironmentObject], gameOver: Binding<Bool>, gameView: Binding<Bool>, easyMode: Binding<Bool>, points: Binding<Int>){
        self.environmentObjectArray = environmentObjectArray
        self.killBalls = KillBallHandler.init()
        self.pointBalls = PointBallHandler.init()
        self._gameOver = gameOver
        self._gameView = gameView
        self._easyMode = easyMode
        self._points = points
        self.points = UserDefaults.standard.object(forKey: "scores") as? Int ?? 0
        pointBalls = UserDefaults.standard.object(forKey: "pointBalls") as? PointBallHandler ?? PointBallHandler.init()
        if (pointBalls.positions.isEmpty){
            pointBalls.getPosition()
        }
        
        killBalls = UserDefaults.standard.object(forKey: "killBalls") as? KillBallHandler ?? KillBallHandler.init()
        if (killBalls.positions.isEmpty){
            killBalls.getPosition()
            killBalls.checkFair(position: CGSize.init(width:0.0, height: (UIScreen.main.bounds.height/2 - 250)))
        }
        self._gameOver = gameOver
        playBackground(sound: "newBackground", type: "mp3")
        
        
    }
}
