//
//  DragTest.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 07/08/2022.
//

import Foundation
import SwiftUI



struct DragTest: View {
    // how far the circle has been dragged
    @State private var offset = CGSize.zero
    @State var accumulated: CGSize = CGSize.zero
    @State var prevPos: CGSize = CGSize.zero

    // whether it is currently being dragged or not
    @State private var isDragging = false

    var body: some View {
        Group{
            // a drag gesture that updates offset and isDragging as it moves around
            let dragGesture = DragGesture()
                .onChanged { value in
                    prevPos = accumulated
                    offset = CGSize(width: value.translation.width + accumulated.width, height: value.translation.height + accumulated.height)
                    
                }
                .onEnded { value in
                    withAnimation {
                        isDragging = false
                        offset = CGSize(width:prevPos.width - ( value.translation.width*1.5 + accumulated.width), height: prevPos.height - (value.translation.height*1.5 + accumulated.height))
                        accumulated = offset
                        
                    }
                }
            // a combined gesture that forces the user to long press then drag
    //        let combined = pressGesture.sequenced(before: dragGesture)

            // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
            ZStack{
                Circle()
                    .fill(.blue)
                    .frame(width: 64, height: 64)
                    .scaleEffect(isDragging ? 1.5 : 1)
                    .offset(prevPos)
                Circle()
                    .fill(.red)
                    .frame(width: 64, height: 64)
                    .scaleEffect(isDragging ? 1.5 : 1)
                    .offset(offset)
                    .gesture(dragGesture)
                
            }
            
        }
//        .onChange(of: inertia)
//            { newChange in
//                withAnimation{
//                    offset = CGSize(width: prevPos.width-accumulated.width*2, height:prevPos.height-accumulated.height*2)
//                    accumulated = offset
//                    inertia = false
//                }
//            }
            
    }
}




struct preview: PreviewProvider{
    static var previews: some View{
        DragTest()
    }
}
