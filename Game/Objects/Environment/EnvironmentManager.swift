//
//  EnvironmentManager.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 09/08/2022.
//

import Foundation
import SwiftUI

struct EnvironmentManager: View {
//    @State var playerPosChanging: Bool = false
    @Binding var gameOver: Bool
    @State var environmentObjectArray: [EnvironmentObject]
    @State var killBalls: KillBallHandler
    @State var pointBalls: PointBallHandler
    @State var points: Int = 0
    @State var allAdded: Bool = false
    var body : some View {
        ZStack{
            
            
            Image("background")
                .resizable()
                .frame(height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height:250)
                .offset(x: 0.0,y: UIScreen.main.bounds.height/2 - 250 + 64/2 + 250/2)
            ForEach(environmentObjectArray){ object in
                Environment(environment: object)
            }
            DragHandler(points: $points, obstacles: environmentObjectArray, pointBalls: $pointBalls, killHandler: $killBalls, gameOver: $gameOver)
                
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
                .offset(CGSize.init(width: 0.0, height:-(UIScreen.main.bounds.height/2) + 50))
        }
        .onChange(of: gameOver){ value in
            backgroundMusic?.stop()
        }
        
    }
    init(gameOver: Binding<Bool>){
        self.environmentObjectArray = []
        self.killBalls = KillBallHandler.init()
        self.pointBalls = PointBallHandler.init()
        self._gameOver = gameOver
        pointBalls.getPosition()
        killBalls.getPosition()
        killBalls.checkFair(position: CGSize.init(width:0.0, height: (UIScreen.main.bounds.height/2 - 250)))
        self.points = Int(0)
        playBackground(sound: "newBackground", type: "mp3")
    }
    init(environmentObjectArray: [EnvironmentObject], gameOver: Binding<Bool>){
        self.environmentObjectArray = environmentObjectArray
        self.killBalls = KillBallHandler.init()
        self.pointBalls = PointBallHandler.init()
        self._gameOver = gameOver
        killBalls.getPosition()
        killBalls.checkFair(position: CGSize.init(width:0.0, height: (UIScreen.main.bounds.height/2 - 250)))
        pointBalls.getPosition()
        self.points = Int(0)
        self._gameOver = gameOver
        playBackground(sound: "newBackground", type: "mp3")
    }
}

struct EnvironmentPreview : PreviewProvider{
    static var previews: some View{
        EnvironmentManager(environmentObjectArray: [], gameOver: .constant(false))
    }
}
