//
//  PhysicsHandler.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 18/08/2022.
//

import Foundation
import SwiftUI

class PhysicsHandler: Identifiable{
    let id: Int
    var movement: [MovementHandler]
    var current: CGSize
    var end: CGSize
    init(position:CGSize) {
        self.current = position
        self.current = position
    }
    func launch(endPosition: CGSize){
        self.end = endPosition
    }
    func update(){
        self.current = self.end
    }
    func bounce(){
    }
    
}
