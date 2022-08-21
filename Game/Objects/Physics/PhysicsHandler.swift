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
    var finalMovement: [MovementHandler]
    var movement: MovementHandler
    init(position:CGSize) {
        self.movement = MovementHandler.init(current: position, end: position, id: 0)
        self.otherFactor = [MovementHandler.init(current: CGSize.init(width: 0.0, height: 0.0), end: CGSize.init(width: 0.0, height: 0.0), id: 0)]
        self.movementDivided = [MovementHandler.init(current: CGSize.init(width: 0.0, height: 0.0), end: CGSize.init(width: 0.0, height: 0.0), id: 0)]
        self.finalMovement = [MovementHandler.init(current: CGSize.init(width: 0.0, height: 0.0), end: CGSize.init(width: 0.0, height: 0.0), id: 0)]
    }
    func getMovement(count: Int){
        if (count < 60){
            //Add movement divider
            let newMovement = MovementHandler.init(
                current:MovementHandler.addVector(
                    first: MovementHandler.divideVector(
                        vector: MovementHandler.getVector(
                            current: movement.current,end: movement.end),
                        divideBy: 60),
                    second: movement.current),
                end: movement.end, id: self.movementDivided.endIndex)
            movementDivided.append(newMovement)
            //End
            self.getMovement(count:count+1)
        }
    }
    func launch(endPosition: CGSize){
        self.movement.end = endPosition
        self.getMovement(count: 0)
        applyFactor()
        self.movement.current = self.finalMovement[self.finalMovement.endIndex-1].current
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
    func checkCollision(environmentStuff: EnvironmentObject) -> collisionEdge{
        var collisionBool: collisionEdge = collisionEdge.init(sides: false, topBot: false)
        if (self.movement.current.width + getHitbox().width >= environmentStuff.xStart && self.movement.current.width + getHitbox().width <= environmentStuff.xEnd){
            collisionBool.sides = true
        }
        if (self.movement.current.width + getHitbox().height >= environmentStuff.yStart && self.movement.current.width + getHitbox().height <= environmentStuff.yEnd){
            collisionBool.topBot = true
        }
        return collisionBool
    }
    
    
    
    
    
    
    
    func applyFactor(){
        for dividedMovement in self.movementDivided{
            
            for factor in self.otherFactor{
                
                self.finalMovement.append(
                    MovementHandler.init(current: (dividedMovement.id == 0) ?
                        (dividedMovement.current):
                        (MovementHandler.addVector(
                            first: dividedMovement.current, second: movementDivided[dividedMovement.id - 1].end)),
                             end: (dividedMovement.id == 0) ?
                                (MovementHandler.addVector(first: dividedMovement.end, second:
                                                            MovementHandler.getVector(current: factor.current, end: factor.end))):
                                (MovementHandler.addVector(first:
                                                            MovementHandler.getVector(current: movementDivided[dividedMovement.id-1].current,
                                                                                      end: movementDivided[dividedMovement.id-1].end),second:
                                                            MovementHandler.addVector(first: dividedMovement.end, second:
                                                                                        MovementHandler.getVector(current: factor.current, end: factor.end)
                                                                                     )
                                                          )
                                ),
                             id: movement.id
                        )
                )
            }
            
        }
    }
    
    
    func addFactor(factor: MovementHandler){
        self.otherFactor.append(factor)
    }
    
    
    func clearMovement(){
        self.movementDivided.removeAll()
        self.movementDivided = [MovementHandler.init(current: CGSize.init(width: 0.0, height: 0.0), end: CGSize.init(width: 0.0, height: 0.0), id: 1)]
    }
    
    
    

}



struct collisionEdge {
    var sides: Bool
    var topBot: Bool
}
