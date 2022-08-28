//
//  Kill ball.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 28/08/2022.
//

import Foundation
import SwiftUI


class KillBall: Codable, Identifiable {
    let id: Int
    var position: CGSize
    var added: Bool = false
    
    init(){
        self.id = 0
        self.position = CGSize.init(width: Double.random(in: -(UIScreen.main.bounds.width/2) + 30 ... (UIScreen.main.bounds.width/2 - 30)), height: Double.random(in: -(UIScreen.main.bounds.height/2) + 150.0 ... (UIScreen.main.bounds.height/2 - 250)))
    }
    init(id: Int){
        self.id = id
        self.position = CGSize.init(width: Double.random(in: -(UIScreen.main.bounds.width/2) + 30 ... (UIScreen.main.bounds.width/2 - 30)), height: Double.random(in: -(UIScreen.main.bounds.height/2) + 150.0 ... (UIScreen.main.bounds.height/2 - 250)))
    }
}
class KillBallHandler: Codable {
    var positions: [KillBall]
    func getPosition(){
        self.positions.append(KillBall.init(id: positions.endIndex))
    }
    
    func checkFair(player: PhysicsHandler) {
        for balls in self.positions{
            while(MovementHandler.getDistant(vector: MovementHandler.getVector(current: player.movement.current, end: self.positions[balls.id].position)) <= 200){
                self.positions[balls.id] = KillBall.init(id: balls.id)
            }
        }
    }
    
    
    func checkFair(position: CGSize) {
        for balls in self.positions{
            while(MovementHandler.getDistant(vector: MovementHandler.getVector(current: position, end: self.positions[balls.id].position)) <= 150){
                self.positions[balls.id] = KillBall.init(id: balls.id)
            }
        }
    }
    
    
    func checkFair(score: Int) {
        if (score > 10 && positions.endIndex-1 < 1){
            self.getPosition()
        }
        if (score > 20 && positions.endIndex-1 < 4){
            self.getPosition()
        }
        if (score > 30 && positions.endIndex-1 < 7){
            self.getPosition()
        }
        if (score > 40 && positions.endIndex-1 < 10){
            self.getPosition()
        }
    }
    func restart(){
        self.positions.removeAll()
        self.getPosition()
    }
    init(){
        self.positions = []
    }
}
