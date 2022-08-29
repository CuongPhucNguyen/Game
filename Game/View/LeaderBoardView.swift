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
    @Binding var highscore: [String:Int]
    var body: some View{
        ZStack{
            Rectangle()
                .frame(width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
                .foregroundColor(.cyan)
            VStack{
                ForEach(highscore.sorted(by: >), id: \.key) { key, value in
                    ZStack{
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width, height: 55)
                            .foregroundColor(.gray)
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width, height: 50)
                            .foregroundColor(.white)
                        HStack{
                            Spacer()
                                .frame(width: 10)
                            Text("Name: \(key)")
                            Spacer()
                            Text("Score: \(value)")
                            Spacer()
                                .frame(width: 10)
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
    init(LeaderBoardView: Binding<Bool>, highscore: Binding<[String:Int]>){
        self._leaderboardView = LeaderBoardView
        self._highscore = highscore
    }
}
