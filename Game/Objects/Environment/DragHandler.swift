//
//  DragTest.swift
//  Game
//
//  Created by Cuong Nguyen Phuc on 07/08/2022.
//

import Foundation
import SwiftUI



struct DragHandler: View {
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
    @Binding var pointBalls: PointBallHandler
    @Binding var killBalls: KillBallHandler
    @Binding var points: Int
    @Binding var gameOver: Bool
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
    @State var standing = 1.0
    @State var startJumping = 0.0
    @State var jumping = 0.0
    @State var hitCount = 0
    @State var scores: Int = UserDefaults.standard.object(forKey: "scores") as? Int : nil

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
                        if (!physics.finalMovement.isEmpty){
                            physics.clearMovement()
                        }
                        physics.launch(endPosition: CGSize(width:prevPos.width - (value.translation.width*1.5 + accumulated.width - prevMouse.width), height: prevPos.height - (value.translation.height*1.5 + accumulated.height - prevMouse.height)))
                        isDragging = true
                        
                    }
                    .onEnded { value in
                        
                        
                        isDragging = false
                        
                        onClick = false
                        opacityHandler = 0.0
                        var jump = 0
                        var motionCount = 0
                        var death = false
                        for motion in physics.finalMovement{
                            motionCount += 1
                            withAnimation(.linear(duration: durationTimer).delay(delayTimer)){
                                if (jump < 3){
                                    standing = 0.0
                                    startJumping = 1.0
                                }
                                else if (jump >= 3 && jump < physics.finalMovement.endIndex-1){
                                    startJumping = 0.0
                                    jumping = 1.0
                                }
                                else {
                                    jumping = 0.0
                                    standing = 1.0
                                }
                                
                                for balls in pointBalls.positions{
                                    if (MovementHandler.getDistant(vector: MovementHandler.getVector(current: motion.end, end: balls.position)) <= 97.0 && !balls.added){
                                        hitCount += 1
                                        balls.added = true
                                        points += 1;
                                        UserDefaults.standard.set(points, forKey: "scores")
                                        withAnimation(.linear.delay(delayTimer)){
                                            playSound(sound: "points", type: "mp3")
                                        }
                                        
                                    }
                                    
                                    
                                }
                                for kills in killBalls.positions{
                                    if (MovementHandler.getDistant(vector: MovementHandler.getVector(current: motion.end, end: kills.position)) <= 35.0 && !kills.added){
                                        death = true
                                        playSound(sound: "oof", type: "mp3")
                                        break;
                                    }
                                }
                                
                                
                                offset = motion.end
                            }
                            if (death){
                                gameOver = true
                                break
                            }
                            
                            durationTimer += 0.0005
                            delayTimer += durationTimer
                            jump += 1;
                            
                        }
                        if (hitCount >= pointBalls.positions.endIndex && motionCount >= physics.finalMovement.endIndex && !gameOver){
                            killBalls.restart()
                            killBalls.checkFair(player: physics)
                            pointBalls.restart()
                            killBalls.checkFair(score: points)
                            pointBalls.checkFair(score: points)
                            hitCount = 0
                        }
                              
                        UserDefaults.standard.set(offset, forKey: "currentPosition")
                        durationTimer = 0.0
                        delayTimer = 0.0
                        physics.movement.current = physics.finalMovement[physics.finalMovement.endIndex-1].end
                        prevPos = physics.movement.current
                        accumulated = physics.movement.current
                        physics.update()
                        physics.checkOutOfBounds()
                        isDragging = false
                        
                    }
                
                
                
                
                
                Image("Sprite-2")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .scaleEffect(1)
                    .offset((isDragging) ? prevPos : offset)
                    .opacity(standing)
                Image("Sprite-3")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .scaleEffect(1)
                    .offset((isDragging) ? prevPos : offset)
                    .opacity(startJumping)
                Image("Sprite-4")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .scaleEffect(1)
                    .offset((isDragging) ? prevPos : offset)
                    .opacity(jumping)
                
                if (!physics.finalMovement.isEmpty){
                    ForEach(physics.finalMovement){position in
                        Circle()
                            .fill(.blue)
                            .frame(width: 64, height: 64)
                            .scaleEffect(0.2)
                            .offset(position.end)
                            .opacity(isDragging ? 0.5 : 0.0)
                    }
                }
                
                Circle()
                    .fill(.red)
                    .frame(width: 64, height: 64)
                    .scaleEffect(isDragging ? 1 : 0)
                    .offset(offset)
                    .opacity(0.5)
                    .gesture(dragGesture)


            }
            
        }
        
            
    }
    init(points: Binding<Int>, pointsHandler: Binding<PointBallHandler>, killHandler: Binding<KillBallHandler>, gameOver: Binding<Bool>){
        let newPhysics = PhysicsHandler.init(position: CGSize.init(width: 0.0, height: (UIScreen.main.bounds.height/2)-250))
        newPhysics.addFactor(factor: MovementHandler.init(current: CGSize.init(width: 0.0, height: 0.0), end: CGSize.init(width: 0.0, height: 0.3), id: 1))
        self.physics = newPhysics
        self.onClick = false
        self.changing = false
        self.delayTimer = 0.0
        self.durationTimer = 0.0
        self._points = points
        self._pointBalls = pointsHandler
        self._killBalls = killHandler
        self._gameOver = gameOver
//        physics.addFactor(factor: MovementHandler.init(current: CGSize.init(width: 0.0, height: 0.0), end: CGSize.init(width: 0.0001, height: 0.0), id: 1))
    }
    init(points: Binding<Int>, obstacles: [EnvironmentObject], pointBalls: Binding<PointBallHandler>, killHandler: Binding<KillBallHandler>, gameOver: Binding<Bool>){
        let newPhysics = PhysicsHandler.init(position: CGSize.init(width: 0.0, height: (UIScreen.main.bounds.height/2)-250))
        newPhysics.addFactor(factor: MovementHandler.init(current: CGSize.init(width: 0.0, height: 0.0), end: CGSize.init(width: 0.0, height: 0.3), id: 1))
        self.physics = newPhysics
        self.onClick = false
        self.changing = false
        self.delayTimer = 0.0
        self.durationTimer = 0.0
        self._points = points
        self._pointBalls = pointBalls
        self._killBalls = killHandler
        self._gameOver = gameOver
        physics.addObstacle(obstacles: obstacles)
//        physics.addFactor(factor: MovementHandler.init(current: CGSize.init(width: 0.0, height: 0.0), end: CGSize.init(width: 0.0001, height: 0.0), id: 1))
    }
}

