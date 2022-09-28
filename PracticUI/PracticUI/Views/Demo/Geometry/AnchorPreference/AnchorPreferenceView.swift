//
//  AnchorPreferenceView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/28.
//

import SwiftUI
import Inject

struct AnchorPreferenceView: View {
    
    @ObserveInjection var inject
    
    @State var activeIdx = 0
    
    var body: some View {
        HStack {
            ForEach(0 ..< 6, id: \.self){item in
                Button {
                    withAnimation {
                        activeIdx = item
                    }
                } label: {
                    Text("\(item)")
                        .lineLimit(1)
                    .frame(width: 50, height: 50)
                    .background(.ultraThinMaterial)
                }
                .anchorPreference(key: AnchorPreferenceKey.self, value: .bounds,
                                  transform: { [AnchorPreferenceKeyPreferenceData(viewIdx: item, bounds: $0)] })
            }
        }
        .overlayPreferenceValue(AnchorPreferenceKey.self) { preferences in
            GeometryReader { geometry in
                createBorder(geometry,preferences)
            }
        }
        .enableInjection()
    }
    
    func createBorder(_ geometry: GeometryProxy, _ preferences: [AnchorPreferenceKeyPreferenceData]) -> some View {

        let p = preferences.first(where: { $0.viewIdx == activeIdx })
        let bound =  geometry[p!.bounds];
        
        let x = bound.minX;
        
        let width = 28.0
        let offect = (bound.width - width )/2
        
        return Rectangle().fill(.blue)
            .frame(width: width, height: 5,alignment: .trailing)
            .cornerRadius(5)
            .offset(x: x + offect,y:-18)
       }
}

struct AnchorPreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        AnchorPreferenceView()
    }
}
