//
//  CustomProgressView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/16.
//

import SwiftUI
import Inject

struct CustomProgressView: View {
    
    @ObserveInjection var inject
    
    let gradient = Gradient(colors: [.green, .blue])
    let sliceSize = 0.45
     @State  var progress: Double = 0.3
     @State  var progress2: Double = 0.0
    
    private let percentageFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }()
    
    public var body: some View {
        VStack{
           
            ZStack {
                Circle()
                    .trim(from: 0, to: 1 - CGFloat(sliceSize))
                    .stroke( .linearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottom),
                             style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .rotationEffect(.degrees(90 + sliceSize * 360 * 0.5), anchor: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
                
                Circle()
                    .trim(from: 0, to: CGFloat(progress * (1 - sliceSize)))
                    .stroke(Color.orange,
                            style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .rotationEffect(.degrees(90 + sliceSize * 360 * 0.5), anchor: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
                   
                Text("\(self.percentageFormatter.string(from: NSNumber(value: self.progress))!)")
                    .font(.largeTitle)
                    .bold()
            }
            Slider(value: $progress, in: 0 ... 1 , step: 0.01)
            
            
      
            ZStack {
                Circle()
                    .stroke( .linearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottom), lineWidth: 20)
                    .rotationEffect(.degrees(-90), anchor: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)

                Circle()
                    .trim(from: 0, to: CGFloat(progress2))
                    .stroke(Color.orange,lineWidth: 20)
                .rotationEffect(.degrees(-90), anchor: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)


                Text("\(self.percentageFormatter.string(from: NSNumber(value: self.progress2))!)")
                    .font(.largeTitle)
                    .bold()
            }
          

            Slider(value: $progress2, in: 0 ... 1 , step: 0.01).padding()
            
        }
        .frame(width: 200, height: 400)
        .enableInjection()
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView()
    }
}
