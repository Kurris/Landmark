//
//  GeometryReaderView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/28.
//

import SwiftUI
import Inject

struct GeometryReaderView: View {
    
    @ObserveInjection var inject
    
    @State var minY = CGFloat.zero
    
    var body: some View {
        ScrollView{
            geometryDetection
            Text("\(minY)")
        }
        .coordinateSpace(name: "scroll")
        .enableInjection()
    }
    
    var geometryDetection  : some View   {
        GeometryReader { proxy in
            Color.clear.preference(key: GeometryReaderKey.self,
                                   value: proxy.frame(in: .named("scroll")).minY)
        }
        .onPreferenceChange(GeometryReaderKey.self, perform: { value in
            withAnimation(.easeInOut) {
                self.minY = value
            }
        })
        .frame(height: 0)
    }
}

struct GeometryReaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView()
    }
}
