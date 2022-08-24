//
//  Environment.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 09/08/2022.
//

import Foundation
import SwiftUI



struct Environment : View {
    let environment: EnvironmentObject
    var body : some View {
        Rectangle()
            .frame(width: abs(environment.xEnd - environment.xStart), height: abs(environment.yEnd - environment.yStart))
            .offset(x: environment.position.offsetX, y: environment.position.offsetY)
            .foregroundColor(.gray)
    }

    init(environment: EnvironmentObject){
        self.environment = environment
    }
}

