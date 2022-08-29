/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Phuc Cuong
 ID: s3881006
 Created  date: 27/08/2022
 Last modified: 27/08/2022
 */

import Foundation
import SwiftUI


struct HowToPlayView : View{
    @Binding var howToPlayView: Bool
    var body: some View{
        ZStack{
            Rectangle()
                .frame(width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
                .foregroundColor(.cyan)
            VStack(spacing: 0){
                Image("tutorial")
                ZStack{
                    Rectangle()
                            .frame(width: UIScreen.main.bounds.width, height: 250)
                            .foregroundColor(.white)
                    Text("Tap on the character and hold \n the blue path is the direction which \n they're launched. Release to launch \n collect the yellow balls to get points \n careful not to touch the black ones")
                }
            }
            
            
            
            
            
            RoundedRectangle(cornerSize: CGSize.init(width: 5, height: 5))
                .frame(width: 200, height: 50)
                .foregroundColor(.orange)
                .offset(x: (-UIScreen.main.bounds.width/2 + 200/2),y:(-UIScreen.main.bounds.height/2 + 50))
            Button("Exit"){
                howToPlayView = false
            }
            .frame(width: 200, height: 50)
            .foregroundColor(.white)
            .offset(x: (-UIScreen.main.bounds.width/2 + 200/2),y:(-UIScreen.main.bounds.height/2 + 50))
        }
    }
    init(howToPlayView: Binding<Bool>){
        self._howToPlayView = howToPlayView
    }
}
