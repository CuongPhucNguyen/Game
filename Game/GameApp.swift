//
//  GameApp.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 07/08/2022.
//

import SwiftUI

@main
struct GameApp: App {
    @State var gameOver = false
    var body: some Scene {
        WindowGroup {
            EnvironmentManager(environmentObjectArray: [], gameOver: $gameOver)
        }
        
    }
}
