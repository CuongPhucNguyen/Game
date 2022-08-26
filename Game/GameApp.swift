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
            EnvironmentManager(environmentObjectArray: [EnvironmentObject.init(xStart: UIScreen.main.bounds.width, xEnd: 0, yStart: 0, yEnd: 100,id: 1, position: Position.init(offsetX: 0, offsetY: 50))])
        }
    }
}
