/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Phuc Cuong
 ID: s3881006
 Created  date: 05/08/2022
 Last modified: 10/08/2022
 */

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
