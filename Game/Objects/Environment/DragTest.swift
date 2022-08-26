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
    @State var opacityHandler: Double = 100
    @State var physics: PhysicsHandler
    @State private var offset: CGSize = CGSize.init(width: 0.0, height: (UIScreen.main.bounds.height/2)-250)
    @State var accumulated: CGSize = CGSize.init(width: 0.0, height: (UIScreen.main.bounds.height/2)-250)
    @State var prevPos: CGSize = CGSize.init(width: 0.0, height: (UIScreen.main.bounds.height/2)-250)
    @State var prevMouse: CGSize = CGSize.init(width: 0.0, height: (UIScreen.main.bounds.height/2)-250)
    @State var currentMouse: CGSize = CGSize.init(width: 0.0, height: (UIScreen.main.bounds.height/2)-250)
    @State var onClick: Bool = false
    @State var changing: Bool = false
    @State var delayTimer: Double = 0.0
    @State var durationTimer: Double = 0.0

    // whether it is currently being dragged or not
    @State private var isDragging = false

    var body: some View {
        Group{
            
            

            // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
            ZStack{
                // a drag gesture that updates offset and isDragging as it moves around
                let dragGesture = DragGesture()
                    .onChanged { value in
                        if (!onClick){
                            prevMouse = CGSize(width: value.translation.width + accumulated.width, height: value.translation.height + accumulated.height)
                            onClick = true
                        }
                        opacityHandler = 100
                        
                        currentMouse = CGSize(width: value.translation.width + accumulated.width - prevMouse.width
                                              , height: value.translation.height + accumulated.height - prevMouse.height)
                        offset = CGSize(width: accumulated.width + currentMouse.width, height: accumulated.height + currentMouse.height)
                        
                    }
                    .onEnded { value in
                        
                        
                        isDragging = false
                        physics.launch(endPosition: CGSize(width:prevPos.width - (value.translation.width*1.5 + accumulated.width - prevMouse.width), height: prevPos.height - (value.translation.height*1.5 + accumulated.height - prevMouse.height)))
                        onClick = false
                        opacityHandler = 0.0
                        
                        for motion in physics.finalMovement{
                            withAnimation(.linear(duration: durationTimer).delay(delayTimer)){
                                offset = motion.end
                                
                            }
                            durationTimer += 0.00015
                            delayTimer += durationTimer
                        }
                        durationTimer = 0.0
                        delayTimer = 0.0
                        physics.movement.current = physics.finalMovement[physics.finalMovement.endIndex-1].end
                        physics.update()
                        physics.clearMovement()
                        prevPos = physics.movement.current
                        accumulated = physics.movement.current
                         
                        
                    }
                
                
                
                
                
                
                Circle()
                    .fill(.blue)
                    .frame(width: 64, height: 64)
                    .scaleEffect(isDragging ? 1.5 : 1)
                    .offset(prevPos)
                    .opacity(opacityHandler)
                Circle()
                    .fill(.red)
                    .frame(width: 64, height: 64)
                    .scaleEffect(isDragging ? 1.5 : 1)
                    .offset(offset)
                    .gesture(dragGesture)


            }
            
        }
        
            
    }
    init(){
        self.physics = PhysicsHandler.init(position: CGSize.init(width: 0.0, height: (UIScreen.main.bounds.height/2)-250))
        physics.addFactor(factor: MovementHandler.init(current: CGSize.init(width: 0.0, height: 0.0), end: CGSize.init(width: 0.0, height: 0.3), id: 1))
        self.offset = physics.movement.current
        self.accumulated = physics.movement.current
        self.prevPos = physics.movement.current
        self.prevMouse = physics.movement.current
        self.currentMouse = physics.movement.current
        self.onClick = false
        self.changing = false
        self.delayTimer = 0.0
        self.durationTimer = 0.0
//        physics.addFactor(factor: MovementHandler.init(current: CGSize.init(width: 0.0, height: 0.0), end: CGSize.init(width: 0.0001, height: 0.0), id: 1))
    }
}

