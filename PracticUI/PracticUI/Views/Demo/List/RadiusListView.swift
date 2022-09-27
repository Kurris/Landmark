//
//  RadiusListView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/21.
//

import SwiftUI
import Inject

struct RadiusListView: View {
     
    @ObserveInjection var inject
    
    @State var singleSelection : Int?
    @State var multiSelection : Set<Int> = Set<Int>()
    
    var body: some View {
        
        VStack{
            List(selection: $singleSelection){
                ForEach(0..<10,id: \.self){ item in
                    Text("row #\(item+1)")
                }
            }
            .toolbar{
                EditButton()
            }
            
            
            List(selection: $multiSelection){
                ForEach(0..<10,id: \.self){ item in
                    Text("row #\(item+1)")
                }
            }
            .toolbar{
                EditButton()
            }
        }
        .enableInjection()
    }
}

