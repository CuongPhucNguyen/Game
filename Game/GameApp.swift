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
            EnvironmentManager(playerPosChanging: false, environmentObjectArray: [EnvironmentObject.init(xStart: 50, xEnd: 100, yStart: 50, yEnd: 100, alignment: Alignment.center,id: 1)])
        }
    }
}
