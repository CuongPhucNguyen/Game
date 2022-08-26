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
        var wallBounce = false
        for dividedMovement in self.movementDivided{
            var dividedMotion: [MovementHandler] = []
            let motion = MovementHandler.init(current:
                                                (dividedMovement.id == 0) ?
                                                (dividedMovement.current):
                                                (self.finalMovement[self.finalMovement.endIndex - 1].end),
                                              end:
                                                (dividedMovement.id == 0) ?
                                                (dividedMovement.end)
                                                :
                                                (dividedMovement.changeVectDirectionWithReturn(reference: self.finalMovement[self.finalMovement.endIndex-1]).end),
//                                                (MovementHandler.addVector(first:
//                                                                              MovementHandler.addVector(first:
//                                                                                                          MovementHandler.getVector(current:
//                                                                                                                                      self.movementDivided[dividedMovement.id-1].current,
//                                                                                                                                    end:
//                                                                                                                                        self.finalMovement[self.finalMovement.endIndex-1].end
//                                                                                                                                   ),
//                                                                                                        second:
//                                                                                                          MovementHandler.getVector(current:
//                                                                                                                                      self.movementDivided[dividedMovement.id-1].end,
//                                                                                                                                    end:
//                                                                                                                                        self.finalMovement[self.finalMovement.endIndex-1].end
//                                                                                                                                   )
//                                                                                                       ),
//                                                                           second:
//                                                                              dividedMovement.end
//                                                                          )
//                                              ),
                                              id: finalMovement.endIndex)
            motion.duration = 0.002
            if (self.finalMovement.endIndex-1 > 0){
                let _ = print("change direction: .\(dividedMovement.changeVectDirectionWithReturn(reference: self.finalMovement[self.finalMovement.endIndex-1]).end)")
            }
            
            var keepFactorTrack = 0.0
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
                let _ = print(keepFactorTrack)
                keepFactorTrack+=factor.end.height




            }
            let _ = print(motion.end)
            
            
            
            
            //Adding bounce
            
//            if (motion.end.height + (UIScreen.main.bounds.height/2) >= UIScreen.main.bounds.height - 25){
//
//                let newMotionA = motion.getParallelWith(height: (UIScreen.main.bounds.height/2) - 150)
//                newMotionA.duration = motion.duration*(
//                    MovementHandler.getVector(current: motion.current, end: motion.end).height /
//                    MovementHandler.getVector(current: newMotionA.current, end: newMotionA.end).height
//                )
//                dividedMotion.append(newMotionA)
//                let newMotionB = MovementHandler.init(current: newMotionA.end,
//                                                      end:
//                                                        CGSize.init(width:
//                                                                        motion.end.width,
//                                                                    height:
//                                                                        (UIScreen.main.bounds.height - 25 - (motion.end.height + (UIScreen.main.bounds.height/2))) + newMotionA.end.height
//                                                                    ),
//                                                      id: newMotionA.id+1)
//                newMotionB.duration = 0.002-newMotionA.duration
//                dividedMotion.append(newMotionB)
//
//                self.finalMovement.append(contentsOf: dividedMotion)
//                wallBounce = true;
//            }
//            if ( motion.end.height + (UIScreen.main.bounds.height/2)  <= 0 + 25){
//
//
//                let newMotionA = motion.getParallelWith(height: -(UIScreen.main.bounds.height/2) + 150)
//                newMotionA.duration = motion.duration*(
//                    MovementHandler.getVector(current: motion.current, end: motion.end).height /
//                    MovementHandler.getVector(current: newMotionA.current, end: newMotionA.end).height
//                )
//                dividedMotion.append(newMotionA)
//                let newMotionB = MovementHandler.init(current: newMotionA.end,
//                                                      end:
//                                                        CGSize.init(width:
//                                                                        motion.end.width,
//                                                                    height:
//                                                                        (0 + 25 - (motion.end.height + (UIScreen.main.bounds.height/2))) + newMotionA.end.height
//                                                                   ),
//                                                      id: newMotionA.id+1)
//                newMotionB.duration = 0.002-newMotionA.duration
//                dividedMotion.append(newMotionB)
//
//                self.finalMovement.append(contentsOf: dividedMotion)
//                wallBounce = true
//            }
//            if (motion.end.width + (UIScreen.main.bounds.width/2) > UIScreen.main.bounds.width - 10){
//
//
//                let _ = print("right")
//                let _ = print((UIScreen.main.bounds.width/2) - 10)
//                let _ = print(motion.end.width)
//                let _ = print((UIScreen.main.bounds.width/2) - 10 - motion.end.width)
//
//                let newMotionA = motion.getParallelWith(width: (UIScreen.main.bounds.width/2) - 10)
//                newMotionA.duration = motion.duration*(
//                    MovementHandler.getVector(current: motion.current, end: motion.end).width /
//                    MovementHandler.getVector(current: newMotionA.current, end: newMotionA.end).width
//                )
//                let _ = print((UIScreen.main.bounds.width/2) - 10 - motion.end.width + newMotionA.end.width)
//                dividedMotion.append(newMotionA)
//                let newMotionB = MovementHandler.init(current: newMotionA.end,
//                                                      end:
//                                                        CGSize.init(width:
//                                                                        ((UIScreen.main.bounds.width/2) - 10) - motion.end.width + newMotionA.end.width,
//                                                                    height:
//                                                                        motion.end.height
//                                                                   ),
//                                                      id: newMotionA.id+1)
//                newMotionB.duration = 0.002-newMotionA.duration
//                dividedMotion.append(newMotionB)
//
//                self.finalMovement.append(contentsOf: dividedMotion)
//            }
//            if (motion.end.width + (UIScreen.main.bounds.width/2)  < 0 + 10){
//                let _ = print("left")
//                let _ = print((UIScreen.main.bounds.width/2) - 10)
//                let _ = print(motion.end.width)
//                let _ = print((UIScreen.main.bounds.width/2) - 10 - motion.end.width)
//                let newMotionA = motion.getParallelWith(width: -(UIScreen.main.bounds.width/2) + 10)
//                newMotionA.duration = motion.duration*(
//                    MovementHandler.getVector(current: motion.current, end: motion.end).width /
//                    MovementHandler.getVector(current: newMotionA.current, end: newMotionA.end).width
//                )
//                dividedMotion.append(newMotionA)
//                let newMotionB = MovementHandler.init(current: newMotionA.end,
//                                                      end:
//                                                        CGSize.init(width:
//                                                                        (0 + 10 - (motion.end.width + (UIScreen.main.bounds.width/2)) + newMotionA.end.width),
//                                                                    height:
//                                                                        motion.end.height
//                                                                   ),
//                                                      id: newMotionA.id+1)
//                newMotionB.duration = 0.002-newMotionA.duration
//                dividedMotion.append(newMotionB)
//
//                self.finalMovement.append(contentsOf: dividedMotion)
//            }
//
//
//
//
//
//
//
//
//
//            if (wallBounce){
//                wallBounce = false
//                continue
//            }
            self.finalMovement.append(motion)
            
            
        }
        
            
            
        
//        while(!touchStop){
//
//
//            let motion = MovementHandler.init(current: self.finalMovement[self.finalMovement.endIndex-1].end,
//                                              end:
//                                                MovementHandler.addVector(first:
//                                                                            MovementHandler.addVector(first:
//                                                                                                        MovementHandler.getVector(current:
//                                                                                                                                    self.finalMovement[self.finalMovement.endIndex-1].current,
//                                                                                                                                  end:
//                                                                                                                                    self.finalMovement[self.finalMovement.endIndex-1].end
//                                                                                                                                 ),
//                                                                                                      second:
//                                                                                                        MovementHandler.getVector(current:
//                                                                                                                                    self.finalMovement[self.finalMovement.endIndex-1].current,
//                                                                                                                                  end:
//                                                                                                                                    self.finalMovement[self.finalMovement.endIndex-1].end
//                                                                                                                                 )
//                                                                                                     ),
//                                                                          second:
//                                                                            self.finalMovement[self.finalMovement.endIndex-1].end
//                                                                         ),
//                                              id: self.finalMovement.endIndex)
//            for factor in self.otherFactor{
//                motion.end  = MovementHandler.addVector(first:
//                                                            MovementHandler.getVector(current:
//                                                                                        factor.current,
//                                                                                      end:
//                                                                                        factor.end
//                                                                                     ),
//                                                        second:
//                                                            motion.end
//                                                        )
//
//
//
//
//            }
//            self.finalMovement.append(motion)
//            if (self.finalMovement[self.finalMovement.endIndex-1].end.height + (UIScreen.main.bounds.height/2) >= UIScreen.main.bounds.height - 25){
//                let _ = print("height: .\(self.finalMovement[self.finalMovement.endIndex-1].end.height)")
//                let _ = print(UIScreen.main.bounds.height)
//                self.finalMovement.removeLast()
//                self.finalMovement[self.finalMovement.endIndex-1].end.height = (UIScreen.main.bounds.height/2) - 150
//                touchStop = true
//            }
//            if ( self.finalMovement[self.finalMovement.endIndex-1].end.height + (UIScreen.main.bounds.height/2)  <= 0 + 25){
//                let _ = print("height: .\(self.finalMovement[self.finalMovement.endIndex-1].end.height)")
//                let _ = print(UIScreen.main.bounds.height)
//                self.finalMovement.removeLast()
//                self.finalMovement[self.finalMovement.endIndex-1].end.height = -(UIScreen.main.bounds.height/2) + 150
//            }
//            if (self.finalMovement[self.finalMovement.endIndex-1].end.width + (UIScreen.main.bounds.width/2) > UIScreen.main.bounds.width - 10){
//                let _ = print("left")
//                let _ = print(UIScreen.main.bounds.height)
//                self.finalMovement.removeLast()
//                self.finalMovement[self.finalMovement.endIndex-1].current.width = (UIScreen.main.bounds.width/2) - 10
//                self.finalMovement[self.finalMovement.endIndex-1].end.width = (UIScreen.main.bounds.width/2) - 10
//                continue
//            }
//            else if (self.finalMovement[self.finalMovement.endIndex-1].end.width + (UIScreen.main.bounds.width/2)  < 0 + 10){
//
//                let _ = print("right")
//                self.finalMovement.removeLast()
//                self.finalMovement[self.finalMovement.endIndex-1].current.width = -(UIScreen.main.bounds.width/2) + 10
//                self.finalMovement[self.finalMovement.endIndex-1].end.width = -(UIScreen.main.bounds.width/2) + 10
//                continue
//            }
//            if (touchStop == true){
//                break;
//            }
//
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


