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
            .frame(width: abs(environment.xEnd - environment.xStart), height: abs(environment.yEnd - environment.yStart), alignment: environment.objectAlignment)
            .offset(x: environment.offsetX, y: environment.offsetY)
    }

    init(environment: EnvironmentObject){
        self.environment = environment
    }
}

struct preview: PreviewProvider{
    static var previews: some View{
        Environment(environment: EnvironmentObject.init(xStart: 0, xEnd: 0, yStart: 50, yEnd: 50, alignment: Alignment.center))
    }
}


