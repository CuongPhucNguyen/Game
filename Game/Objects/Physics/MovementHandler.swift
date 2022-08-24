//
//  MovementHandler.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 18/08/2022.
//

import Foundation
import SwiftUI

class MovementHandler: Identifiable {
    let id: Int
    var current: CGSize
    var end: CGSize
    var duration: Double
    init(current: CGSize, end: CGSize, id: Int) {
        self.id = id
        self.current = current
        self.end = end
        self.duration = 0.0
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
    func checkCollision(environment: [EnvironmentObject])->[MovementHandler]{
        var movements: [MovementHandler] = []
        for obstacle in environment{
            let newMovementA = MovementHandler.init(current: CGSize.init(width: 0.0, height: 0.0), end: CGSize.init(width: 0.0, height: 0.0), id: 0)
            
            if (self.getHitbox().width <= obstacle.xEnd && self.getHitbox().width >= obstacle.xStart ){
                
                
                //get bounce direction
                if (obstacle.xStart >= self.current.width && obstacle.xStart <= self.end.width){
                    newMovementA.end.width = self.end.width - obstacle.xStart
                }
                else if (obstacle.xEnd >= self.current.width && obstacle.xEnd <= self.end.width){
                    newMovementA.end.width = self.end.width - obstacle.xEnd
                }
                
                
                
                
                
                
                
                
                
            }
            
            
            
        }
        return movements
    }
}

