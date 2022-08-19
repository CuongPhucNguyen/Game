//
//  PhysicsHandler.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 18/08/2022.
//

import Foundation
import SwiftUI

class PhysicsHandler{
    var otherFactor: [MovementHandler]
    var movementDivided: [MovementHandler]
    var movement: MovementHandler
    init(position:CGSize) {
        self.movement = MovementHandler.init(current: position, end: position)
        self.otherFactor = []
        self.movementDivided = []
        self.getMovement()
    }
    func getMovement(){
        if (self.movement.current != self.movement.end){
            //Add movement divider
            
            
            
            
            
            //End
            self.getMovement()
        }
    }
    func launch(endPosition: CGSize){
        self.movement.end = endPosition
    }
    func update(){
        self.movement.current = self.movement.end
    }
    func checkInPath(environmentStuff:EnvironmentObject)->Bool{
        var withinXAxis = false
        if (environmentStuff.xStart >= self.movement.current.width && environmentStuff.xEnd <= self.movement.end.width){
            withinXAxis = true
        }
        var withinYAxis = false
        if (environmentStuff.yStart >= self.movement.current.height && environmentStuff.yEnd <= self.movement.end.height){
            withinYAxis = true
        }
        
        if (withinXAxis && withinYAxis){
            return true
        }
        return false
    }
    
    func getHitbox()->CGSize{
        return CGSize.init(width: 4*abs((self.movement.end.width - self.movement.current.width))/(self.movement.end.width - self.movement.current.width), height: 4*abs((self.movement.end.height - self.movement.current.height))/(self.movement.end.height - self.movement.current.height))
    }
    
    //Add checking for collision direction then changing direction if true
    func checkCollision(environmentStuff: EnvironmentObject){
        if (self.movement.current.width + getHitbox().width >= environmentStuff.xStart && self.movement.current.width + getHitbox().width >= environmentStuff.xEnd){
            
        }
    }

}
