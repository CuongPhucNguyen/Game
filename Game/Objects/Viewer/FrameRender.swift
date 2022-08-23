//
//  FrameRender.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 23/08/2022.
//

import Foundation
import SwiftUI


struct FrameRender : View {
    
    @State var redOffset: CGSize

    var body: some View{
        ZStack{
            ZStack{
                
                Circle()
                    .fill(.red)
                    .frame(width: 64, height: 64)
                    .offset(redOffset)
                
            }
        }
    }
    init(red: CGSize){
        self.redOffset = red
    }
    static func RenderAll(physics: PhysicsHandler) -> [FrameRender]{
        var frames: [FrameRender] = []
        for motions in physics.finalMovement{
            frames.append(FrameRender.init(red: motions.end))
        }
        return frames
    }
}
