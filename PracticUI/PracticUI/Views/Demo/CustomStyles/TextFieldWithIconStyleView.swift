//
//  TextFieldWithIconStyleView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/21.
//

import SwiftUI

struct TextFieldWithIconStyleView: View {
    
    @State var input = ""
    
    var body: some View {
       TextField("用户名", text: $input)
            .inputStyle(icon: "lock")
    }
}
