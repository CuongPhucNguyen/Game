//
//  DragTest.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 07/08/2022.
//

import Foundation
import SwiftUI



struct DragTest: View {
    /*
    
     Calculation explaination
     CenVectA: center of the circle (point A)
     CenVectB: center of the circle (point B)
     MouseVectA: mouse location (point A)
     MouseVectB: mouse location (point B)
     
     
     if you take the vector MouseVect(A->B) then add to point A of CenVectA we can draw a vector CenVect(A->B) parallel to vector MouseVect(A->B)
     
        prevMouse = MouseVectA
        currentMouse = MouseVectB
     
        prevPos = CenVectA
        offset = CenVectB
     
     
        MouseVectB - MouseVectA = CenVectB - CenVectA
        => CenVectB = (MouseVectB - MouseVectA) + CenVectA
        
     
        Replace the variables, we have:
        offset = (currentMouse - prevMouse) + prevPos
        
     
     
     
     this eliminates the user's human error and allows the player to use visual cues such as the blue dot as the current position and the red dot as the charging slingshot for accurate aiming
    
     
     Hypothetically, the slingshot once released shoot the object 1.5 times the pull distance, we have:
     
     +slingshot trajectory goes the opposite way, therefore the vector goes the opposite direction:
     
    => (actual placement after release) = prevPos - (currentMouse - prevMouse)*1.5
     
     
     since the circle takes the value of the "offset" value and the "offset" value is no longer used once the user release the button, we can use the "offset" value to store the "actual placement after released" value to update the location of the circle as well as save memory
     
     
     
    
    
    
    
    
    */
    
    // how far the circle has been dragged
    @State private var offset = CGSize.zero
    @State var accumulated: CGSize = CGSize.zero
    @State var prevPos: CGSize = CGSize.zero
    @State var prevMouse: CGSize = CGSize.zero
    @State var currentMouse: CGSize = CGSize.zero
    @State var onClick: Bool = false
    @Binding var changing: Bool

    // whether it is currently being dragged or not
    @State private var isDragging = false

    var body: some View {
        Group{
            // a drag gesture that updates offset and isDragging as it moves around
            let dragGesture = DragGesture()
                .onChanged { value in
                    if (!onClick){
                        prevMouse = CGSize(width: value.translation.width + accumulated.width, height: value.translation.height + accumulated.height)
                        onClick = true
                    }
                    prevPos = accumulated
                    currentMouse = CGSize(width: value.translation.width + accumulated.width - prevMouse.width
                                          , height: value.translation.height + accumulated.height - prevMouse.height)
                    offset = CGSize(width: accumulated.width + currentMouse.width, height: accumulated.height + currentMouse.height)
                    
                }
                .onEnded { value in
                    withAnimation (.easeOut(duration:0.3)) {
                        changing = true
                        isDragging = false
                        offset = CGSize(width:prevPos.width - ( value.translation.width*1.5 + accumulated.width - prevMouse.width), height: prevPos.height - (value.translation.height*1.5 + accumulated.height - prevMouse.height))
                        accumulated = offset
                        onClick = false
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
            
    }
}




//struct preview: PreviewProvider{
//    @State var changing: Bool = false
//    static var previews: some View{
//
//        DragTest(changing: changing)
//    }
//}
