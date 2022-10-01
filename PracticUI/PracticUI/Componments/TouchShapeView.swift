//
//  TouchShapeView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/10/2.
//

import SwiftUI
import Inject

struct TouchShapeView: View {
    
    @ObserveInjection var inject
    
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 2.5)
                .frame(width: 40, height: 5)
                .foregroundColor(Color.secondary)
        }
        .enableInjection()
    }
}

struct TouchShapeView_Previews: PreviewProvider {
    static var previews: some View {
        TouchShapeView()
    }
}
