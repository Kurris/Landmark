//
//  SplashPageView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/28.
//

import SwiftUI
import Inject

struct SplashPageView: View {
    
    @ObserveInjection var inject
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var count = 0
    @Binding var isShow :Bool
    
    func startTimer(){
        count = 0
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func stopTimer(){
        timer.upstream.connect().cancel()
        withAnimation(.toClose) {
            isShow = false
        }
    }
    
    init(isShow : Binding<Bool> ){
        _isShow = isShow
    }

    var body: some View {
        VStack{
            if isShow {
                VStack{
                    Spacer()
                    Text("Splash Page For Initialize")
                        .foregroundColor(.blue)
                        .font(.title3).bold()
                    .frame(maxWidth:.infinity , maxHeight: .infinity)
                    .background(.white)
                    .onReceive(timer, perform: { value in
                        count = count + 1
                        if count >=  2 {
                            stopTimer()
                        }
                    })
                }
                .ignoresSafeArea(.all)
            }
        }
        .onChange(of: isShow, perform: { newValue in
            if isShow {
                startTimer()
            }
        })
        .enableInjection()
    }
}

