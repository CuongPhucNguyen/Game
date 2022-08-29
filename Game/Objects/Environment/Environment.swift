/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Phuc Cuong
 ID: s3881006
 Created  date: 05/08/2022
 Last modified: 06/08/2022
 */

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

