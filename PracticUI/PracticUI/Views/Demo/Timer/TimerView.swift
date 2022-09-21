//
//  TimerView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/16.
//

import SwiftUI
import Inject

struct TimerView: View {
    
    @ObserveInjection var inject
    
    @State var count = 0
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func startTimer(){
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func stopTimer(){
        timer.upstream.connect().cancel()
    }
    
    var body: some View {
        VStack{
            Text("\(count)")
                .onReceive(timer) { value in
                    print(value)
                    count+=1
                }
            
            Button("Stop"){
                stopTimer()
            }
            Button("Begin"){
                startTimer()
            }
        }
        .enableInjection()
    }
    
    
    
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
