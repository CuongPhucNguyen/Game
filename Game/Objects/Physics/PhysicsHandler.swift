//
//  PhysicsHandler.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 18/08/2022.
//

import Foundation
import SwiftUI

class PhysicsHandler: Codable{
    var otherFactor: [MovementHandler]
    var movementDivided: [MovementHandler]
    var finalMovement: [MovementHandler]
    var movement: MovementHandler
    var obstacles: [EnvironmentObject]
    init(position:CGSize) {
        self.movement = MovementHandler.init(current: position, end: position, id: 0)
        self.otherFactor = []
        self.movementDivided = []
        self.finalMovement = []
        self.obstacles = []
    }
    
    
    func addObstacle(obstacles: [EnvironmentObject]){
        self.obstacles = obstacles
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
        var dividedMotion: [MovementHandler] = []
        for dividedMovement in self.movementDivided{
            
            let motion = MovementHandler.init(current:
                                                (dividedMovement.id == 0) ?
                                                (dividedMovement.current):
                                                (self.finalMovement[self.finalMovement.endIndex - 1].end),
                                              end:
                                                (dividedMovement.id == 0) ?
                                                (dividedMovement.end)
                                                :
                                                (dividedMovement.changeVectDirectionWithReturn(reference: self.finalMovement[self.finalMovement.endIndex-1]).end),
                                              id: finalMovement.endIndex)
            motion.duration = 0.002
            
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
            
            
            if (self.obstacles.endIndex > 0){
                let collisionCheck = motion.checkCollision(environment: self.obstacles)
                if (collisionCheck.start){
                    let _ = print("start hit")
                    dividedMotion.append(motion.getParallelWith(height: collisionCheck.collidedObstacle.xStart + collisionCheck.collidedObstacle.position.offsetX - (collisionCheck.collidedObstacle.xEnd - collisionCheck.collidedObstacle.xStart)/2))
                    
                    //Adding in progress
                    
                    let newMovement = MovementHandler.init(current:
                                                            motion.getParallelWith(width:
                                                                                   collisionCheck.collidedObstacle.xStart + collisionCheck.collidedObstacle.position.offsetX - (collisionCheck.collidedObstacle.xEnd - collisionCheck.collidedObstacle.xStart)/2
                                                                                  ).end,
                                                           end:
                                                            MovementHandler.addVector(first:
                                                                                        motion.getParallelWith(width:
                                                                                                               collisionCheck.collidedObstacle.xStart + collisionCheck.collidedObstacle.position.offsetX - (collisionCheck.collidedObstacle.xEnd - collisionCheck.collidedObstacle.xStart)/2
                                                                                                              ).end,
                                                                                      second:
                                                                                        MovementHandler.getVector(current:
                                                                                                                    motion.end,
                                                                                                                  end: CGSize.init(width: collisionCheck.collidedObstacle.xStart,
                                                                                                                                   height:
                                                                                                                                    (motion.end.width*2 - dividedMotion[dividedMotion.endIndex-1].end.width)
                                                                                                                                  )
                                                                                                                 )
                                                                                     ),
                                                           id: dividedMotion.endIndex)
                    dividedMotion.append(newMovement)
                    wallBounce = true
                }
                if (collisionCheck.end){
                    let _ = print("end hit")
                    dividedMotion.append(motion.getParallelWith(height: collisionCheck.collidedObstacle.xEnd))
                    let newMovement = MovementHandler.init(current:
                                                            dividedMotion[dividedMotion.endIndex-1].end,
                                                           end: MovementHandler.addVector(first:
                                                                                            dividedMotion[dividedMotion.endIndex-1].end,
                                                                                          second:
                                                                                            MovementHandler.getVector(current:
                                                                                                                        motion.end,
                                                                                                                      end: CGSize.init(width: (motion.end.width*2 - dividedMotion[dividedMotion.endIndex-1].end.width),
                                                                                                                                       height:
                                                                                                                                        (UIScreen.main.bounds.height/2) - 200
                                                                                                                                      )
                                                                                                                     )
                                                                                         ),
                                                           id: dividedMotion.endIndex)
                    dividedMotion.append(newMovement)
                    wallBounce = true
                }
                if (collisionCheck.top){
                    let _ = print("top hit")
                    dividedMotion.append(motion.getParallelWith(height: collisionCheck.collidedObstacle.yStart))
                    let newMovement = MovementHandler.init(current:
                                                            dividedMotion[dividedMotion.endIndex-1].end,
                                                           end: MovementHandler.addVector(first:
                                                                                            dividedMotion[dividedMotion.endIndex-1].end,
                                                                                          second:
                                                                                            MovementHandler.getVector(current:
                                                                                                                        motion.end,
                                                                                                                      end: CGSize.init(width: (motion.end.width*2 - dividedMotion[dividedMotion.endIndex-1].end.width),
                                                                                                                                       height:
                                                                                                                                        (UIScreen.main.bounds.height/2) - 200
                                                                                                                                      )
                                                                                                                     )
                                                                                         ),
                                                           id: dividedMotion.endIndex)
                    dividedMotion.append(newMovement)
                    wallBounce = true
                }
                if (collisionCheck.bottom){
                    let _ = print("bottom hit")
                    dividedMotion.append(motion.getParallelWith(height: collisionCheck.collidedObstacle.yEnd + collisionCheck.collidedObstacle.position.offsetY - (collisionCheck.collidedObstacle.yEnd - collisionCheck.collidedObstacle.yEnd)/2))
                    let newMovement = MovementHandler.init(current:
                                                            motion.getParallelWith(height: collisionCheck.collidedObstacle.yEnd + collisionCheck.collidedObstacle.position.offsetY - (collisionCheck.collidedObstacle.yEnd - collisionCheck.collidedObstacle.yEnd)/2).end,
                                                           end: MovementHandler.addVector(first:
                                                                                            motion.getParallelWith(height: collisionCheck.collidedObstacle.yEnd + collisionCheck.collidedObstacle.position.offsetY - (collisionCheck.collidedObstacle.yEnd - collisionCheck.collidedObstacle.yEnd)/2).end,
                                                                                          second:
                                                                                            MovementHandler.getVector(current:
                                                                                                                        motion.end,
                                                                                                                      end: CGSize.init(width:
                                                                                                                                        (collisionCheck.collidedObstacle.yEnd),
                                                                                                                                       height:
                                                                                                                                        (motion.end.height*2 - dividedMotion[dividedMotion.endIndex-1].end.height)
                                                                                                                                      )
                                                                                                                     )
                                                                                         ),
                                                           id: dividedMotion.endIndex)
                    dividedMotion.append(newMovement)
                    wallBounce = true
                }
            }
            
            
            
            
            
            
            
            //Adding bounce
            
            if (motion.end.height + (UIScreen.main.bounds.height/2) >= UIScreen.main.bounds.height - 200){
                dividedMotion.append(motion.getParallelWith(height: (UIScreen.main.bounds.height/2) - 200))
                let newMovement = MovementHandler.init(current:
                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                       end: MovementHandler.addVector(first:
                                                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                                                      second:
                                                                                        MovementHandler.getVector(current:
                                                                                                                    motion.end,
                                                                                                                  end: CGSize.init(width: (motion.end.width*2 - dividedMotion[dividedMotion.endIndex-1].end.width),
                                                                                                                                   height:
                                                                                                                                    (UIScreen.main.bounds.height/2) - 200
                                                                                                                                  )
                                                                                                                 )
                                                                                     ),
                                                       id: dividedMotion.endIndex)
                let _ = print("motion end .\(motion.end)")
                let _ = print("newMovement .\(dividedMotion[dividedMotion.endIndex-1].end)")
                dividedMotion.append(newMovement)
                wallBounce = true
            }
            if ( motion.end.height + (UIScreen.main.bounds.height/2)  <= 0 + 200){
                dividedMotion.append(motion.getParallelWith(height: -(UIScreen.main.bounds.height/2) + 200))
                let newMovement = MovementHandler.init(current:
                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                       end: MovementHandler.addVector(first:
                                                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                                                      second:
                                                                                        MovementHandler.getVector(current:
                                                                                                                    motion.end,
                                                                                                                  end: CGSize.init(width: (motion.end.width*2 - dividedMotion[dividedMotion.endIndex-1].end.width),
                                                                                                                                   height:
                                                                                                                                    -(UIScreen.main.bounds.height/2) + 200
                                                                                                                                  )
                                                                                                                 )
                                                                                     ),
                                                       id: dividedMotion.endIndex)
                let _ = print("motion end .\(motion.end)")
                let _ = print("newMovement .\(dividedMotion[dividedMotion.endIndex-1].end)")
                dividedMotion.append(newMovement)
                wallBounce = true
            }
            if (motion.end.width + (UIScreen.main.bounds.width/2) > UIScreen.main.bounds.width - 10){
            }
            if (motion.end.width + (UIScreen.main.bounds.width/2)  < 0 + 10){
                dividedMotion.append(motion.getParallelWith(width: -(UIScreen.main.bounds.width/2) + 30))
                let newMovement = MovementHandler.init(current:
                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                       end: MovementHandler.addVector(first:
                                                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                                                      second:
                                                                                        MovementHandler.getVector(current:
                                                                                                                    motion.end,
                                                                                                                  end: CGSize.init(width:-(UIScreen.main.bounds.width/2) + 30,
                                                                                                                                   height:(motion.end.height*2 - dividedMotion[dividedMotion.endIndex-1].end.height)
                                                                                                                                  )
                                                                                                                 )
                                                                                     ),
                                                       id: dividedMotion.endIndex)
                let _ = print("motion end .\(motion.end)")
                let _ = print("newMovement .\(dividedMotion[dividedMotion.endIndex-1].end)")
                dividedMotion.append(newMovement)
                wallBounce = true
            }









            if (wallBounce){
                self.finalMovement.append(contentsOf: dividedMotion)
                wallBounce = false
                dividedMotion.removeAll()
                continue
            }
            self.finalMovement.append(motion)
            
            
        }
        
            
            
        
        while(!touchStop){


            let motion = MovementHandler.init(current: self.finalMovement[self.finalMovement.endIndex-1].end,
                                              end:
                                                (self.finalMovement[self.finalMovement.endIndex-1].changeVectDirectionWithReturn(reference: self.finalMovement[self.finalMovement.endIndex-1]).end),
                                              id: self.finalMovement.endIndex)
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
            if (self.finalMovement[self.finalMovement.endIndex-1].end.height + (UIScreen.main.bounds.height/2) >= UIScreen.main.bounds.height - 200){
                let _ = print("up")
                self.finalMovement.removeLast()
                dividedMotion.append(self.finalMovement[self.finalMovement.endIndex-1].getParallelWith(height: (UIScreen.main.bounds.height/2) - 200))
                let newMovement = MovementHandler.init(current:
                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                       end: MovementHandler.addVector(first:
                                                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                                                      second:
                                                                                        MovementHandler.getVector(current:
                                                                                                                    motion.end,
                                                                                                                  end: CGSize.init(width: (motion.end.width*2 - dividedMotion[dividedMotion.endIndex-1].end.width),
                                                                                                                                   height:
                                                                                                                                    (UIScreen.main.bounds.height/2) - 200
                                                                                                                                  )
                                                                                                                 )
                                                                                     ),
                                                       id: dividedMotion.endIndex)
                let _ = print("motion end .\(motion.end)")
                let _ = print("newMovement .\(dividedMotion[dividedMotion.endIndex-1].end)")
                dividedMotion.append(newMovement)
                self.finalMovement.append(contentsOf: dividedMotion)
                dividedMotion.removeAll()
                touchStop = true
                return
            }
            if ( self.finalMovement[self.finalMovement.endIndex-1].end.height + (UIScreen.main.bounds.height/2)  <= 0 + 200){
                let _ = print("up")
                self.finalMovement.removeLast()
                dividedMotion.append(self.finalMovement[self.finalMovement.endIndex-1].getParallelWith(height: -(UIScreen.main.bounds.height/2) + 200))
                let newMovement = MovementHandler.init(current:
                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                       end: MovementHandler.addVector(first:
                                                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                                                      second:
                                                                                        MovementHandler.getVector(current:
                                                                                                                    motion.end,
                                                                                                                  end: CGSize.init(width: (motion.end.width*2 - dividedMotion[dividedMotion.endIndex-1].end.width),
                                                                                                                                   height:
                                                                                                                                    -(UIScreen.main.bounds.height/2) + 200
                                                                                                                                  )
                                                                                                                 )
                                                                                     ),
                                                       id: dividedMotion.endIndex)
                let _ = print("motion end .\(motion.end)")
                let _ = print("newMovement .\(dividedMotion[dividedMotion.endIndex-1].end)")
                dividedMotion.append(newMovement)
                self.finalMovement.append(contentsOf: dividedMotion)
                dividedMotion.removeAll()
                continue
            }
            if (self.finalMovement[self.finalMovement.endIndex-1].end.width + (UIScreen.main.bounds.width/2) > UIScreen.main.bounds.width - 30){
                
                
                let _ = print("right")
                self.finalMovement.removeLast()
                dividedMotion.append(self.finalMovement[self.finalMovement.endIndex-1].getParallelWith(width: (UIScreen.main.bounds.width/2) - 30))
                let newMovement = MovementHandler.init(current:
                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                       end: MovementHandler.addVector(first:
                                                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                                                      second:
                                                                                        MovementHandler.getVector(current:
                                                                                                                    motion.end,
                                                                                                                  end: CGSize.init(width: (UIScreen.main.bounds.width/2) - 30,
                                                                                                                                   height:(motion.end.height*2 - dividedMotion[dividedMotion.endIndex-1].end.height)
                                                                                                                                  )
                                                                                                                 )
                                                                                     ),
                                                       id: dividedMotion.endIndex)
                let _ = print("motion end .\(motion.end)")
                let _ = print("newMovement .\(dividedMotion[dividedMotion.endIndex-1].end)")
                dividedMotion.append(newMovement)
                self.finalMovement.append(contentsOf: dividedMotion)
                dividedMotion.removeAll()
                continue
            }
            else if (self.finalMovement[self.finalMovement.endIndex-1].end.width + (UIScreen.main.bounds.width/2)  < 0 + 30){

                let _ = print("left")
                self.finalMovement.removeLast()
                dividedMotion.append(self.finalMovement[self.finalMovement.endIndex-1].getParallelWith(width: -(UIScreen.main.bounds.width/2) + 30))
                let newMovement = MovementHandler.init(current:
                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                       end: MovementHandler.addVector(first:
                                                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                                                      second:
                                                                                        MovementHandler.getVector(current:
                                                                                                                    motion.end,
                                                                                                                  end: CGSize.init(width:-(UIScreen.main.bounds.width/2) + 30,
                                                                                                                                   height:(motion.end.height*2 - dividedMotion[dividedMotion.endIndex-1].end.height)
                                                                                                                                  )
                                                                                                                 )
                                                                                     ),
                                                       id: dividedMotion.endIndex)
                let _ = print("motion end .\(motion.end)")
                let _ = print("newMovement .\(dividedMotion[dividedMotion.endIndex-1].end)")
                dividedMotion.append(newMovement)
                self.finalMovement.append(contentsOf: dividedMotion)
                dividedMotion.removeAll()
                continue
            }
            if (touchStop == true){
                break;
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


