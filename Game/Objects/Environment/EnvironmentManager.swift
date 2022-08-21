//
//  EnvironmentManager.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 09/08/2022.
//

import Foundation
import SwiftUI

struct EnvironmentManager: View {
//    @State var playerPosChanging: Bool = false
    @State var environmentObjectArray: [EnvironmentObject]
    var body : some View {
        ZStack{
            ForEach(environmentObjectArray){ object in
                Environment(environment: object)
            }
            DragTest()
        }
    }
}



struct environmentPreview : PreviewProvider {
    static var previews: some View{
        EnvironmentManager(environmentObjectArray: [EnvironmentObject.init(xStart: 0.0, xEnd: 50, yStart: 0, yEnd: 50, alignment: Alignment.center,id: 1)])
    }
}
