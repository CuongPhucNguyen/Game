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
            EnvironmentManager(playerPosChanging: false, environmentObjectArray: [EnvironmentObject.init(xStart: 0.0, xEnd: 50, yStart: 0, yEnd: 50, alignment: Alignment.center,id: 1)])
        }
    }
}
