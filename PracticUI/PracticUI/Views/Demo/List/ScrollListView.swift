//
//  ScrollListView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/21.
//

import SwiftUI
import Inject

struct ScrollListView: View {
    
    @ObserveInjection var inject

    var body: some View {
        ScrollViewReader{ proxy in
            VStack{
                
                Button("Jump to #50"){
                    withAnimation {
                        proxy.scrollTo(50-1,anchor: .top)
                    }
                }
                
                List{
                    ForEach(0..<100,id: \.self){ item in
                        Text("row #\(item+1)")
                    }
                }
            }
        }
        .enableInjection()
    }
}

struct ScrollListView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollListView()
    }
}
