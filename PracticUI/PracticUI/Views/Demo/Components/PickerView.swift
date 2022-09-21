//
//  PickerView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/20.
//

import SwiftUI
import Inject

struct PickerView: View {
    
    @ObserveInjection var inject
    
    @State var index = 0
    @State var fruits = ["苹果","西瓜","芒果","猕猴桃"]

    var body: some View {
        VStack{
            Picker(selection: $index,label: Text("水果wheel")) {
                ForEach(0 ..< fruits.count){
                    Text(fruits[$0]).tag($0)
                }
            }.pickerStyle(.wheel)
            
//            Picker(selection: $index,label: Text("水果inline")) {
//                ForEach(0 ..< fruits.count){
//                    Text(fruits[$0]).tag($0)
//                }
//            }.pickerStyle(.inline)
            
            
            Picker(selection: $index,label: Text("水果menu")) {
                ForEach(0 ..< fruits.count){
                    Text(fruits[$0]).tag($0)
                }
            }.pickerStyle(.menu)
            
            
            Picker(selection: $index,label: Text("水果segmented")) {
                ForEach(0 ..< fruits.count){
                    Text(fruits[$0]).tag($0)
                }
            }.pickerStyle(.segmented)
// ios中不可使用
//            Picker(selection: $index,label: Text("水果radioGroup")) {
//                ForEach(0 ..< fruits.count){
//                    Text(fruits[$0]).tag($0)
//                }
//            }.pickerStyle(.radioGroup)
            
            Form{
                Section{
                    Picker(selection: $index,label: Text("水果")) {
                        ForEach(0 ..< fruits.count){
                            Text(fruits[$0]).tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Picker(selection: $index,label: Text("水果")) {
                        ForEach(0 ..< fruits.count){
                            Text(fruits[$0]).tag($0)
                        }
                    }
                }
            }
            
           
        }
        .enableInjection()
    }
}
