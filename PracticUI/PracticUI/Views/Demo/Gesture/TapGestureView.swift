//
//  TagGestureView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/26.
//

import SwiftUI

struct TapGestureView: View {
    
    @State var count = 0
    
    var body: some View {
        Text("Count: \(count)")
            .onTapGesture {
                count+=1
            }
        
        //双击
        Text("Count: \(count)")
            .onTapGesture(count:2) {
                count+=1
            }
    }
}

struct TagGestureView_Previews: PreviewProvider {
    static var previews: some View {
        TapGestureView()
    }
}
