//
//  MovementHandler.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 18/08/2022.
//

import Foundation
import SwiftUI

class MovementHandler: Identifiable, Codable {
    let id: Int
    var current: CGSize
    var end: CGSize
    var duration: Double
    init(current: CGSize, end: CGSize, id: Int) {
        self.id = id
        self.current = current
        self.end = end
        self.duration = 0.002
    }
    static func getVector(current: CGSize, end: CGSize) ->CGSize{
        return CGSize.init(width: end.width - current.width, height: end.height - current.height)
    }
    static func getDistant(vector: CGSize) -> Double{
        return (vector.width*vector.width + vector.height*vector.height).squareRoot()
    }
    static func addVector(first: CGSize, second: CGSize) ->CGSize{
        return CGSize.init(width: first.width + second.width, height: first.height + second.height)
    }
    static func divideVector(vector: CGSize, divideBy: Double) -> CGSize{
        return CGSize.init(width: vector.width/divideBy, height: vector.height/divideBy)
    }
    func getHitbox()->CGSize{
        return CGSize.init(width: 4*(self.end.width-self.current.width)/abs(self.end.width-self.current.width) + self.end.width, height: 4*(self.end.height-self.current.height)/abs(self.end.height-self.current.height) + self.end.height)
    }
    func checkCollision(environment: [EnvironmentObject])->collisionArea{
        var collisionDetected = false
        var collisionSide = collisionArea.init()
        for obstacles in environment{
            if(collisionDetected) {
                break
            }
            if ((self.end.width <= obstacles.xEnd && self.end.width >= obstacles.xStart) &&
                (self.end.height <= obstacles.yEnd && self.end.height <= obstacles.yStart)){
                if(self.getParallelWith(width: obstacles.xEnd + obstacles.position.offsetX).end.width <= obstacles.xEnd &&
                   self.getParallelWith(width: obstacles.xEnd + obstacles.position.offsetX).end.width >= obstacles.xStart &&
                   self.getParallelWith(width: obstacles.xEnd + obstacles.position.offsetX).end.height <= obstacles.yEnd &&
                   self.getParallelWith(width: obstacles.xEnd + obstacles.position.offsetX).end.height >= obstacles.yStart
                )
                {
                    collisionSide.sides = true;
                    collisionDetected = true;
                    continue;
                }
                if(self.getParallelWith(width: obstacles.xStart + obstacles.position.offsetX).end.width <= obstacles.xEnd &&
                   self.getParallelWith(width: obstacles.xStart + obstacles.position.offsetX).end.width >= obstacles.xStart &&
                   self.getParallelWith(width: obstacles.xStart + obstacles.position.offsetX).end.height <= obstacles.yEnd &&
                   self.getParallelWith(width: obstacles.xStart + obstacles.position.offsetX).end.height >= obstacles.yStart
                )
                {
                    collisionSide.sides = true;
                    collisionDetected = true;
                    continue;
                }
                if(self.getParallelWith(width: obstacles.yEnd + obstacles.position.offsetX).end.width <= obstacles.xEnd &&
                   self.getParallelWith(width: obstacles.yEnd + obstacles.position.offsetX).end.width >= obstacles.xStart &&
                   self.getParallelWith(width: obstacles.yEnd + obstacles.position.offsetX).end.height <= obstacles.yEnd &&
                   self.getParallelWith(width: obstacles.yEnd + obstacles.position.offsetX).end.height >= obstacles.yStart
                )
                {
                    collisionSide.topBot = true;
                    collisionDetected = true;
                    continue;
                }
                if(self.getParallelWith(width: obstacles.xEnd + obstacles.position.offsetX).end.width <= obstacles.xEnd &&
                   self.getParallelWith(width: obstacles.xEnd + obstacles.position.offsetX).end.width >= obstacles.xStart &&
                   self.getParallelWith(width: obstacles.xEnd + obstacles.position.offsetX).end.height <= obstacles.yEnd &&
                   self.getParallelWith(width: obstacles.xEnd + obstacles.position.offsetX).end.height >= obstacles.yStart
                )
                {
                    collisionSide.topBot = true;
                    collisionDetected = true;
                    continue;
                }
            }
        }
        return collisionSide
    }
    
    
    
    
    
    func getParallelWith(width: Double)->MovementHandler{
        var newVect = MovementHandler.getVector(current: self.current, end: self.end)
        newVect.width = newVect.width*abs(width/self.end.width)
        newVect.height = newVect.height*abs(width/self.end.width)
        return MovementHandler.init(current:
                                        self.current,
                                    end:
                                        MovementHandler.addVector(first: self.current, second: newVect),
                                    id: self.id)
    }
    
    func getParallelWith(height: Double)->MovementHandler{
        var newVect = MovementHandler.getVector(current: self.current, end: self.end)
        newVect.width = newVect.width*abs(height/self.end.height)
        newVect.height = newVect.height*abs(height/self.end.height)
        return MovementHandler.init(current:
                                        self.current,
                                    end:
                                        MovementHandler.addVector(first: self.current, second: newVect),
                                    id: self.id)
    }
    
    
    func changeVectDirection(reference: MovementHandler){
        let vectMagnitude = MovementHandler.getDistant(vector: MovementHandler.getVector(current: self.current, end: self.end))
        let refMagnitude = MovementHandler.getDistant(vector: MovementHandler.getVector(current: reference.current, end: reference.end))
        let magnitudeDifference = vectMagnitude/refMagnitude
        let referenceVect = MovementHandler.getVector(current: reference.current, end: reference.end)
        self.current = reference.end
        self.end = MovementHandler.addVector(first: reference.end,
                                  second:
                                    MovementHandler.getVector(current:
                                                                reference.current,
                                                              end:
                                                                reference.getParallelWith(width:
                                                                                            reference.current.width + referenceVect.width*magnitudeDifference
                                                                                         ).end
                                                             )
                                    
                                 )
    }
    func changeVectDirectionWithReturn(reference: MovementHandler) -> MovementHandler{
        let vectMagnitude = MovementHandler.getDistant(vector: MovementHandler.getVector(current: self.current, end: self.end))
        let refMagnitude = MovementHandler.getDistant(vector: MovementHandler.getVector(current: reference.current, end: reference.end))
        let magnitudeDifference = vectMagnitude/refMagnitude
        let referenceVect = MovementHandler.getVector(current: reference.current, end: reference.end)
        return MovementHandler.init(current: reference.end,
                                    end:
                                        MovementHandler.addVector(first: reference.end,
                                                                  second:
                                                                    MovementHandler.getVector(current:
                                                                                                reference.current,
                                                                                              end:
                                                                                                reference.getParallelWith(width:
                                                                                                                            reference.current.width + referenceVect.width*magnitudeDifference
                                                                                                                         ).end
                                                                                             )
                                                                    
                                                                 ),
                                    id: reference.id)
    }
    func checkOutOfBound(){
    }
    func reverseMovement(){
        let temp = self.end
        self.end = self.current
        self.current = temp
    }
    func reverseVector()->MovementHandler{
        return MovementHandler.init(current: self.end, end: self.current, id: self.id)
    }
}



struct collisionArea{
    var topBot: Bool = false
    var sides: Bool = false
}
