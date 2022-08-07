//
//  PlayerObject.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 07/08/2022.
//

import Foundation



struct PlayerObject{
    var positionX: Double
    var positionY: Double
    
    static func equal(player1: PlayerObject, player2: PlayerObject) -> Bool {
        return (player1.positionX == player2.positionX && player1.positionY == player2.positionY)
        
    }
}
