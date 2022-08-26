//
//  EnvironmentObject.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 09/08/2022.
//

import Foundation
import SwiftUI


struct EnvironmentObject: Identifiable, Codable {
    let id: Int
    var xStart: Double
    var xEnd: Double
    var yStart: Double
    var yEnd: Double
    var position: Position
    
    init(xStart: Double, xEnd: Double, yStart: Double, yEnd: Double, id: Int, position: Position){
        self.id = id
        self.xStart = xStart
        self.xEnd = xEnd
        self.yStart = yStart
        self.yEnd = yEnd
        self.position = position
    }
}



struct Position: Codable{
    var offsetX: Double
    var offsetY: Double
}
