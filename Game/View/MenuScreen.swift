//
//  MenuScreen.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 29/08/2022.
//

import Foundation
import SwiftUI

struct MenuScreen : View{
    @Binding var gameView: Bool
    @Binding var optionView: Bool
    @Binding var leaderboardView: Bool
    @Binding var howToPlayView: Bool
    var body: some View{
        ZStack{
            Rectangle()
                .foregroundColor(.cyan)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            VStack{
                ZStack{
                    RoundedRectangle(cornerSize: CGSize.init(width: 5, height: 5))
                        .frame(width: 100, height: 50)
                        .foregroundColor(.orange)
                    Button("Start game"){
                        gameView = true
                    }
                    .frame(width: 100, height: 50)
                    .foregroundColor(.white)
                }
                ZStack{
                    RoundedRectangle(cornerSize: CGSize.init(width: 5, height: 5))
                        .frame(width: 100, height: 50)
                        .foregroundColor(.orange)
                    Button("Option"){
                        optionView = true
                    }
                    .frame(width: 100, height: 50)
                    .foregroundColor(.white)
                }
                ZStack{
                    RoundedRectangle(cornerSize: CGSize.init(width: 5, height: 5))
                        .frame(width: 100, height: 50)
                        .foregroundColor(.orange)
                    Button("Leaderboard"){
                        leaderboardView = true
                    }
                    .frame(width: 100, height: 50)
                    .foregroundColor(.white)
                }
                ZStack{
                    RoundedRectangle(cornerSize: CGSize.init(width: 5, height: 5))
                        .frame(width: 100, height: 50)
                        .foregroundColor(.orange)
                    Button("How to play"){
                        howToPlayView = true
                    }
                    .frame(width: 100, height: 50)
                    .foregroundColor(.white)
                }
            }
        }
    }
    init(gameView: Binding<Bool>, optionView: Binding<Bool>, leaderboardView: Binding<Bool>, howToPlayView: Binding<Bool>){
        self._gameView = gameView
        self._optionView = optionView
        self._leaderboardView = leaderboardView
        self._howToPlayView = howToPlayView
    }
}
