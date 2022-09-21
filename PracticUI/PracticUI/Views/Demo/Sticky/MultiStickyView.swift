//
//  MultiStickyView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/16.
//

import SwiftUI
import Inject

struct MultiStickyView: View {
    
    @ObserveInjection var inject
    
    var body: some View {
        VStack{
            List {
                Text("sticky前的内容")
                    .font(.system(size: 32))
                
                Section(header: HStack {
                    Text("Sticky标题 #1")
                        .font(.system(size: 24))
                    Spacer()
                    Image(systemName: "sun.max.fill")
                }) {
                    ForEach(0 ..< 40) { index in
                        Text("Row #\(index+1)")
                    }
                }
                
                Section(header: HStack {
                    Text("Sticky标题 #2")
                        .font(.system(size: 24))
                    Spacer()
                    Image(systemName: "sun.max.fill")
                }) {
                    ForEach(0 ..< 40) { index in
                        Text("Row #\(index+1)")
                    }
                }
                
            }
            .listStyle(.plain)
        }.enableInjection()
    }
}

struct MultiStickyView_Previews: PreviewProvider {
    static var previews: some View {
        MultiStickyView()
    }
}
