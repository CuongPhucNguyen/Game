//
//  GameApp.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 07/08/2022.
//

import SwiftUI

@main
struct GameApp: App {
    var body: some Scene {
        WindowGroup {
            EnvironmentManager(environmentObjectArray: [EnvironmentObject.init(xStart: 0, xEnd: 100, yStart: 50, yEnd: 100,id: 1, position: Position.init(offsetX: 50, offsetY: 50))])
        }
    }
}
