/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Phuc Cuong
 ID: s3881006
 Created  date: 05/08/2022
 Last modified: 28/08/2022
 */


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
            
            
            
            
            
            
            
            
            
            
            
            if (motion.end.height + (UIScreen.main.bounds.height/2) >= UIScreen.main.bounds.height - 250){
                dividedMotion.append(motion.getParallelWith(height: (UIScreen.main.bounds.height/2) - 250))
                let newMovement = MovementHandler.init(current:
                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                       end: MovementHandler.addVector(first:
                                                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                                                      second:
                                                                                        MovementHandler.getVector(current:
                                                                                                                    motion.end,
                                                                                                                  end: CGSize.init(width: (motion.end.width*2 - dividedMotion[dividedMotion.endIndex-1].end.width),
                                                                                                                                   height:
                                                                                                                                    (UIScreen.main.bounds.height/2) - 250
                                                                                                                                  )
                                                                                                                 )
                                                                                     ),
                                                       id: dividedMotion.endIndex)
                let _ = print("motion end .\(motion.end)")
                let _ = print("newMovement .\(dividedMotion[dividedMotion.endIndex-1].end)")
                dividedMotion.append(newMovement)
                wallBounce = true
            }
            if ( motion.end.height + (UIScreen.main.bounds.height/2)  <= 0 + 150){
                dividedMotion.append(motion.getParallelWith(height: -(UIScreen.main.bounds.height/2) + 150))
                let newMovement = MovementHandler.init(current:
                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                       end: MovementHandler.addVector(first:
                                                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                                                      second:
                                                                                        MovementHandler.getVector(current:
                                                                                                                    motion.end,
                                                                                                                  end: CGSize.init(width: (motion.end.width*2 - dividedMotion[dividedMotion.endIndex-1].end.width),
                                                                                                                                   height:
                                                                                                                                    -(UIScreen.main.bounds.height/2) + 150
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
            









            if (wallBounce){
                if (!self.finalMovement.isEmpty){
                    self.finalMovement.removeLast()
                }
                self.finalMovement.append(contentsOf: dividedMotion)
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
            if (self.finalMovement[self.finalMovement.endIndex-1].end.height + (UIScreen.main.bounds.height/2) >= UIScreen.main.bounds.height - 250){
                let _ = print("up")
                self.finalMovement.removeLast()
                dividedMotion.append(self.finalMovement[self.finalMovement.endIndex-1].getParallelWith(height: (UIScreen.main.bounds.height/2) - 250))
                let newMovement = MovementHandler.init(current:
                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                       end: MovementHandler.addVector(first:
                                                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                                                      second:
                                                                                        MovementHandler.getVector(current:
                                                                                                                    motion.end,
                                                                                                                  end: CGSize.init(width: (motion.end.width*2 - dividedMotion[dividedMotion.endIndex-1].end.width),
                                                                                                                                   height:
                                                                                                                                    (UIScreen.main.bounds.height/2) - 250
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
            if ( self.finalMovement[self.finalMovement.endIndex-1].end.height + (UIScreen.main.bounds.height/2)  <= 0 + 150){
                let _ = print("up")
                self.finalMovement.removeLast()
                dividedMotion.append(self.finalMovement[self.finalMovement.endIndex-1].getParallelWith(height: -(UIScreen.main.bounds.height/2) + 150))
                let newMovement = MovementHandler.init(current:
                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                       end: MovementHandler.addVector(first:
                                                                                        dividedMotion[dividedMotion.endIndex-1].end,
                                                                                      second:
                                                                                        MovementHandler.getVector(current:
                                                                                                                    motion.end,
                                                                                                                  end: CGSize.init(width: (motion.end.width*2 - dividedMotion[dividedMotion.endIndex-1].end.width),
                                                                                                                                   height:
                                                                                                                                    -(UIScreen.main.bounds.height/2) + 150
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
            if (self.finalMovement[self.finalMovement.endIndex-1].end.width + (UIScreen.main.bounds.width/2)  < 0 + 30){

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
    
    
    
    
    func checkOutOfBounds(){
        if (self.finalMovement[self.finalMovement.endIndex-1].end.width + (UIScreen.main.bounds.width/2) > UIScreen.main.bounds.width - 30){
            self.finalMovement[self.finalMovement.endIndex-1].end.width = ((UIScreen.main.bounds.width/2) - 30)
        }
        if (self.finalMovement[self.finalMovement.endIndex-1].end.width + (UIScreen.main.bounds.width/2)  < 0 + 30){
            self.finalMovement[self.finalMovement.endIndex-1].end.width = (-(UIScreen.main.bounds.width/2) + 30)
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


