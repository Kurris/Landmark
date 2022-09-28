//
//  HalfSheelView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/27.
//

import SwiftUI
import Inject


struct HalfSheelView<Content: View> : View {
    
    @ObserveInjection var inject

    @Binding var show: Bool
    let outContent : Content
    
    @State var offsetY = UIScreen.main.bounds.height / 2
    
    init(show: Binding<Bool>, @ViewBuilder content: ()->Content ){
        _show = show
        outContent = content()
    }
    
    func toShow() {
        print("show")
        withAnimation(.slide){
            offsetY = 0.0
        }
    }
    
    func toClose() {
        print("close")
        withAnimation(.slide){
            offsetY = UIScreen.main.bounds.height / 2
            show = false
        }
    }
    
    var body: some View {
        ZStack{
            if show {
                Color.black.opacity(0.2)
                    .padding(0)
                    .onTapGesture {
                        toClose()
                    }
            }
            VStack{
                Spacer()
                showContent
            }
        }
        .onChange(of: show, perform: { newValue in
            if show {
                toShow()
            }
        })
        .frame(maxWidth : .infinity , maxHeight:  .infinity)
        .edgesIgnoringSafeArea(.all)
        .enableInjection()
    }
    
    
    var showContent : some View{
        VStack{
            HStack{
                RoundedRectangle(cornerRadius: CGFloat(5.0) / 2.0)
                    .frame(width: 40, height: CGFloat(5.0))
                    .foregroundColor(Color.secondary)
                    
            }
            .frame(maxWidth : .infinity , maxHeight: .infinity)
            .frame(height : 5)
            .padding(.vertical , 5)

            outContent
            Spacer()
        }
        .frame(maxWidth : .infinity,maxHeight:  .infinity)
        .frame(height: UIScreen.main.bounds.height / 2)
        .background(Color.white)
        .cornerRadius(18.0)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
        .offset(y: offsetY)
        .gesture(
            DragGesture()
                .onChanged({ gesture in
                    guard gesture.location.y > 0  else {return}
                    
                    if gesture.startLocation.y > 20 {
                        return
                    }
                    
                    withAnimation(.slide){
                        offsetY = gesture.location.y
                    }
                })
                .onEnded({gesture in
                    let limit = UIScreen.main.bounds.height / 4 * 0.7
                    
                    withAnimation(.slide) {
                        if gesture.translation.height > limit {
                            toClose()
                        }
                        else {
                            toShow()
                        }
                    }
                })
        )
    }
}


