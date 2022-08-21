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
}
