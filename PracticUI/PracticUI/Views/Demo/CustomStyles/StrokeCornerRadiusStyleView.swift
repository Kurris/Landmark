//
//  StrokeCornerRadiusStyleView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/21.
//

import SwiftUI
import Inject

struct StrokeCornerRadiusStyleView: View {
    
    @ObserveInjection var inject
    
    var body: some View {
        Color.blue.overlay {
            Image(systemName: "person.crop.circle")
                .frame(width: 32, height: 32)
                .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                .strokeCornerRadiusStyle(cornerRadius: 14)
               
        }
        .ignoresSafeArea()
        .enableInjection()
    }
}

struct StrokeCornerRadiusStyleView_Previews: PreviewProvider {
    static var previews: some View {
        StrokeCornerRadiusStyleView()
    }
}
