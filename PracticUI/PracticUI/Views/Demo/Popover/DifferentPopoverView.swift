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
    @EnvironmentObject var model : Model
    
    var body: some View {
        VStack{

            Button("show half sheet"){
                withAnimation(.slide){
                    isShowHalfSheet = true
                }
            }
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(.yellow)
        .overlay{
            HalfSheelView(show: $isShowHalfSheet) {
//                List{
//                    ForEach(0 ..< 100 , id: \.self){item in
//                        Text("\(item)")
//                    }
//                }
                Circle().frame(width: 50, height: 50)
                Circle().frame(width: 50, height: 50)
                Circle().frame(width: 50, height: 50)
                Circle().frame(width: 50, height: 50)
                Circle().frame(width: 50, height: 50)
            }
        }
        .edgesIgnoringSafeArea(.all)
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
