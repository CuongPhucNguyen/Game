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
    
    
    
    
    
    
    
    
    
    func applyFactor(){
        var touchStop = false
        for dividedMovement in self.movementDivided{
            let motion = MovementHandler.init(current:
                                                (dividedMovement.id == 0) ?
                                                (dividedMovement.current):
                                                (self.finalMovement[dividedMovement.id - 1].end),
                                              end:
                                                (dividedMovement.id == 0) ?
                                                (dividedMovement.end)
                                                :
                                                (MovementHandler.addVector(first:
                                                                            MovementHandler.addVector(first:
                                                                                                        MovementHandler.getVector(current:
                                                                                                                                    self.movementDivided[dividedMovement.id-1].end,
                                                                                                                                  end:
                                                                                                                                    self.finalMovement[dividedMovement.id-1].end
                                                                                                                                 ),
                                                                                                      second:
                                                                                                        MovementHandler.getVector(current:
                                                                                                                                    self.movementDivided[dividedMovement.id-1].end,
                                                                                                                                  end:
                                                                                                                                    self.finalMovement[dividedMovement.id-1].end
                                                                                                                                 )
                                                                                                     ),
                                                                          second:
                                                                            dividedMovement.end
                                                                         )
                                                ),
                                              id: dividedMovement.id)
            motion.duration = 0.01
            
            
            
            for factor in self.otherFactor{
                motion.end  = MovementHandler.addVector(first:
                                                            MovementHandler.getVector(current:
                                                                                        factor.current,
                                                                                      end:
                                                                                        factor.end
                                                                                     ),
                                                        second:
                                                            motion.end
                                                        )
                
                
                
                
            }
            self.finalMovement.append(motion)
            
        }
        
            
            
        
//        while(!touchStop){
//
//            //Add touch bottom bound stops
//        }
        
    }
    func addFactor(factor: MovementHandler){
        self.otherFactor.append(factor)
    }
    
    
    func clearMovement(){
        self.movementDivided.removeAll()
        self.finalMovement.removeAll()
    }
    
    
    

}


