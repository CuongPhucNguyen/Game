//
//  MovementHandler.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 18/08/2022.
//

import Foundation
import SwiftUI

class MovementHandler {
    var current: CGSize
    var end: CGSize
    init(current: CGSize, end: CGSize) {
        self.current = current
        self.end = end
    }
    static func getVector(current: CGSize, end: CGSize) ->CGSize{
        return CGSize.init(width: current.width - end.width, height: current.height - end.height)
    }
    static func getDistant(vector: CGSize) -> Double{
        return (vector.width*vector.width + vector.height*vector.height).squareRoot()
    }
}
