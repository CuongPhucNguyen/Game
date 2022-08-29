//
//  LeaderBoardView.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 29/08/2022.
//

import Foundation
import SwiftUI

struct LeaderBoardView : View {
    @Binding var leaderboardView: Bool
    @State var highscores = UserDefaults.standard.object(forKey: "highscores") as? [String:Int] ?? [:]
    var body: some View{
        ZStack{
            Rectangle()
                .frame(width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
                .foregroundColor(.cyan)
            VStack{
                ForEach(highscores.sorted(by: >), id: \.key) { key, value in
                    ZStack{
                        Rectangle()
                            .frame(width: 105, height: 55)
                            .foregroundColor(.gray)
                        Rectangle()
                            .frame(width: 100, height: 50)
                            .foregroundColor(.white)
                        HStack{
                            Text("\(key)")
                            Text("\(value)")
                        }
                    }
                }
                    
            }
            RoundedRectangle(cornerSize: CGSize.init(width: 5, height: 5))
                .frame(width: 200, height: 50)
                .foregroundColor(.orange)
                .offset(x: (-UIScreen.main.bounds.width/2 + 200/2),y:(-UIScreen.main.bounds.height/2 + 50))
            Button("Exit"){
                leaderboardView = false
            }
            .frame(width: 200, height: 50)
            .foregroundColor(.white)
            .offset(x: (-UIScreen.main.bounds.width/2 + 200/2),y:(-UIScreen.main.bounds.height/2 + 50))
        }
        
    }
    init(LeaderBoardView: Binding<Bool>){
        self._leaderboardView = LeaderBoardView
    }
}
