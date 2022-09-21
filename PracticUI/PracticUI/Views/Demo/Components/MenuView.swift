//
//  MenuView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/20.
//

import SwiftUI
import Inject

struct MenuView: View {
    @ObserveInjection var inject
    var body: some View {
        Menu{
            Menu("Second"){
                Button("btn#4"){
                    
                }
                Button("btn#5"){
                    
                }
                Button("btn#6"){
                    
                }
            }
            Button("btn#1"){
                
            }
            Button("btn#2"){
                
            }
            Button("btn#3"){
                
            }
           
        }label: {
            Label("Options", systemImage: "paperplane")
        }
        //.menuStyle(.borderlessButton)
        .enableInjection()

    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
