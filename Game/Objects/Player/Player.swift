//
//  Player.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 07/08/2022.
//

import Foundation
import SwiftUI

struct Player: View {
    @State var currentPositionX: Double = 0.0
    @State var currentPositionY: Double = 0.0
    @State var move: Bool = false
    @State var inputPosition: PlayerObject
    @State var changePosition: Double = 50
    var body: some View{
        Group{
            Button(action: Move){
                Rectangle()
                    .frame(width: 40, height: 40)
                    
            }
            .offset(x: currentPositionX,y: currentPositionY)
            
            
        }
        .onChange(of:move){
            newChange in
            if (currentPositionX != inputPosition.positionX || currentPositionY != inputPosition.positionY){
                withAnimation(Animation.default){
                    currentPositionX = inputPosition.positionX
                    currentPositionY = inputPosition.positionY
                }
            }
        }
        
    }
    
    init(player: PlayerObject){
        self.inputPosition = player
    }
    func nextPosition(player: PlayerObject){
        self.inputPosition = player
    }
    func Move(){
        self.move.toggle()
        self.inputPosition.positionX += self.changePosition
    }
    
    
}


struct playerPreview: PreviewProvider{
    static var previews: some View{
        Player(player: PlayerObject.init(positionX: 0.0, positionY: 0.0))
    }
}
