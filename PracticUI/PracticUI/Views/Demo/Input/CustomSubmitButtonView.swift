//
//  CustomSubmitButtonView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/26.
//

import SwiftUI
import Inject

struct CustomSubmitButtonView: View {
    
    @ObserveInjection var inject
    
    @State var text = ""
    
    var body: some View {
        TextField("Username",text: $text)
            .submitLabel(.search)
            .enableInjection()
    }
}

struct CustomSubmitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSubmitButtonView()
    }
}
