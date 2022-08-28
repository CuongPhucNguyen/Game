//
//  PointBall.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 28/08/2022.
//

import Foundation
import SwiftUI

class PointBall: Codable, Identifiable {
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
class PointBallHandler: Codable {
    var positions: [PointBall]
    func getPosition(){
        self.positions.append(PointBall.init(id: positions.endIndex))
    }
    func checkFair(score: Int) {
        if (score > 1 && positions.endIndex-1 < 1){
            self.getPosition()
        }
        if (score > 5 && positions.endIndex-1 < 4){
            self.getPosition()
        }
        if (score > 10 && positions.endIndex-1 < 7){
            self.getPosition()
            self.getPosition()
        }
        if (score > 15 && positions.endIndex-1 < 10){
            self.getPosition()
            self.getPosition()
            self.getPosition()
        }
        if (score > 20 && positions.endIndex-1 < 13){
            self.getPosition()
            self.getPosition()
            self.getPosition()
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
    init(pointBall: PointBall){
        self.positions = [pointBall]
    }
}
