//
//  DifferentPopoverView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/28.
//

import SwiftUI
import Inject

struct DifferentPopoverView: View {
    
    @ObserveInjection var injecet
    
    @State var isShowHalfSheet = false
    @State var isShowHighSheet = false
    @State var isShowQuarterSheet = false
    
    
    @EnvironmentObject var model : Model
    @State var username = ""
    
    
    var body: some View {
        VStack{
            
            Button("show half sheet"){
                withAnimation(.slide){
                    isShowHalfSheet = true
                }
            }
            
            Button("show high sheet"){
                withAnimation(.slide){
                    isShowHighSheet = true
                }
            }
            
            
            Button("show quarter sheet"){
                withAnimation(.slide){
                    isShowQuarterSheet = true
                }
            }
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .halfSheet(isShow: $isShowHalfSheet, draggable: true, isShowCloseButton: true) {
            TextField("Username",text: $username)
            List{
                ForEach(0 ..< 100 , id: \.self){item in
                    Text("\(item)")
                }
            }
        } title: {
            TouchShapeView()
        }
        .highSheet(isShow: $isShowHighSheet, draggable: true, isShowCloseButton: true){
            List{
                ForEach(0 ..< 100 , id: \.self){item in
                    Text("\(item)")
                }
            }
        }
    title: {
        TouchShapeView()
    }
    .quarterSheet(isShow: $isShowQuarterSheet, draggable: true, isShowCloseButton: true){
        List{
            ForEach(0 ..< 100 , id: \.self){item in
                Text("\(item)")
            }
        }
    }
    title: {
        TouchShapeView()
    }
    .onAppear(perform: {
        model.isShowCardDetail = false
    })
    .enableInjection()
    }
}

struct DifferentPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        DifferentPopoverView()
    }
}
