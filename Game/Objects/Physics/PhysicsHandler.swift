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
        self.otherFactor = []
        self.movementDivided = []
        self.finalMovement = []
    }
    func getMovement(count: Int){
        if (count < 20){
            //Add movement divider
            let newMovement = MovementHandler.init(
                current:
                    (self.movementDivided.endIndex == 0) ? self.movement.current : self.movementDivided[self.movementDivided.endIndex-1].end,
                end: MovementHandler.addVector(first:
                                                MovementHandler.divideVector(vector:
                                                                                MovementHandler.getVector(current:
                                                                                                            self.movement.current,
                                                                                                          end:
                                                                                                            self.movement.end),
                                                                             divideBy: 20),
                                              second:
                                                (self.movementDivided.endIndex == 0) ? self.movement.current : self.movementDivided[self.movementDivided.endIndex-1].end
                                             ),
                id: self.movementDivided.endIndex
            )
            movementDivided.append(newMovement)
            //End
            let _ = print(self.movementDivided.endIndex-1)
            self.getMovement(count:count+1)
            
        }
    }
    
    func launch(endPosition: CGSize){
        self.movement.end = endPosition
        self.getMovement(count: 0)
        applyFactor()
    }
    func update(){
        self.movement.current = self.finalMovement[self.finalMovement.endIndex-1].end
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
                                            (self.finalMovement[dividedMovement.id - 1].end),
                                         end:(dividedMovement.id == 0) ?
                                            (
                                                MovementHandler.addVector(first:
                                                                                dividedMovement.end,
                                                                          second:
                                                                                MovementHandler.getVector(current: factor.current, end: factor.end)
                                                                         )
                                            ):
                                            (
                                                
//                                                MovementHandler.addVector(first:
//                                                                            MovementHandler.addVector(first:
//                                                                                                        MovementHandler.getVector(current:
//                                                                                                                                    self.finalMovement[dividedMovement.id-1].current,
//                                                                                                                                  end:
//                                                                                                                                    self.finalMovement[dividedMovement.id-1].end
//                                                                                                                                 ),
//                                                                                                      second:
//                                                                                                        MovementHandler.getVector(current: factor.current, end: factor.end)
//                                                                                                     ),
//                                                                          second:
//                                                                            self.finalMovement[dividedMovement.id - 1].end
//                                                                         )
                                                
                                                MovementHandler.addVector(first:
                                                                            MovementHandler.addVector(first:
                                                                                                        MovementHandler.addVector(first:
                                                                                                                                    MovementHandler.getVector(current:
                                                                                                                                                                self.movementDivided[dividedMovement.id-1].end,
                                                                                                                                                              end:
                                                                                                                                                                self.finalMovement[dividedMovement.id-1].end),
                                                                                                                                  second:
                                                                                                                                    MovementHandler.getVector(current:
                                                                                                                                                                self.movementDivided[dividedMovement.id-1].end,
                                                                                                                                                              end:
                                                                                                                                                                self.finalMovement[dividedMovement.id-1].end)
                                                                                                                                  ),
                                                                                                      second:
                                                                                                        self.movementDivided[dividedMovement.id].end),
                                                                          second:
                                                                            MovementHandler.getVector(current: factor.current, end: factor.end)
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
        self.finalMovement.removeAll()
    }
    
    
    

}



struct collisionEdge {
    var sides: Bool
    var topBot: Bool
}
