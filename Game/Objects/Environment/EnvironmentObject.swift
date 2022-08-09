//
//  EnvironmentObject.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 09/08/2022.
//

import Foundation
import SwiftUI


struct EnvironmentObject: Identifiable {
    let id: Int
    var xStart: Double
    var xEnd: Double
    var yStart: Double
    var yEnd: Double
    
    
    var objectAlignment: Alignment
    var offsetX: Double = 0.0
    var offsetY: Double = 0.0
    mutating func offsetGetter(object: EnvironmentObject){
        
        
    }
    init(xStart: Double, xEnd: Double, yStart: Double, yEnd: Double, alignment: Alignment){
        self.xStart = xStart
        self.xEnd = xEnd
        self.yStart = yStart
        self.yEnd = yEnd
        self.objectAlignment = alignment
        
        
        
        if(objectAlignment == Alignment.bottomLeading){
            self.offsetX = xStart
            self.offsetY = yStart
        }
        else if(objectAlignment == Alignment.topLeading){
            self.offsetX = xStart
            self.offsetY = yEnd
        }
        else if(objectAlignment == Alignment.bottomTrailing){
            self.offsetX = xEnd
            self.offsetY = yStart
        }
        else if(objectAlignment == Alignment.topTrailing){
            self.offsetX = xEnd
            self.offsetY = yEnd
        }
        else if(objectAlignment == Alignment.bottom){
            self.offsetX = (xEnd - xStart)/2
            self.offsetY = yEnd
        }
        else if(objectAlignment == Alignment.top){
            self.offsetX = (xEnd - xStart)/2
            self.offsetY = yEnd
        }
        else if(objectAlignment == Alignment.leading){
            self.offsetX = xStart
            self.offsetY = (yEnd - yStart)/2
        }
        else if(objectAlignment == Alignment.trailing){
            self.offsetX = xEnd
            self.offsetY = (yEnd - yStart)/2
        }
        else {
            self.offsetX = (xEnd - xStart)/2
            self.offsetY = (yEnd - yStart)/2
        }
    }
}
