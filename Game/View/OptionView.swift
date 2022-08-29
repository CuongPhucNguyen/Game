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

struct OptionView: View{
    @Binding var optionView: Bool
    @Binding var easyMode: Bool
    var body: some View{
        ZStack{
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
                .foregroundColor(.cyan)
            RoundedRectangle(cornerSize: CGSize.init(width: 5, height: 5))
                .frame(width: 200, height: 50)
                .foregroundColor(.orange)
                .offset(x: (-UIScreen.main.bounds.width/2 + 200/2),y:(-UIScreen.main.bounds.height/2 + 50))
            Button("Exit"){
                optionView = false
            }
            .frame(width: 200, height: 50)
            .foregroundColor(.white)
            .offset(x: (-UIScreen.main.bounds.width/2 + 200/2),y:(-UIScreen.main.bounds.height/2 + 50))
            
            
            RoundedRectangle(cornerSize: CGSize.init(width: 5, height: 5))
                .frame(width: 200, height: 50)
                .foregroundColor(.orange)
            Button("Easy mode: \((easyMode) ? "On" : "Off")"){
                easyMode.toggle()
            }
            .frame(width: 200, height: 50)
            .foregroundColor(.white)
            
            Text("This option turns on or off the aim assist: \n if the player turns this option off \n the jumping trajectory will be disabled")
                .background(.white)
                .offset(x: 0.0,y: 100)
        }
    }
    init(easyMode: Binding<Bool>, optionView: Binding<Bool>){
        self._easyMode = easyMode
        self._optionView = optionView
    }
}
