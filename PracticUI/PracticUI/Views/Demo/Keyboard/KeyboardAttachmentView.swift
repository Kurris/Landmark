//
//  KeyboardAttachmentView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/26.
//

import SwiftUI
import Inject

struct KeyboardAttachmentView: View {
    
    @ObserveInjection var inject
    @State var comment = ""
    
    var body: some View {
        TextField("Comment",text: $comment)
            .textInputAutocapitalization(.never)//首字母大写
            .disableAutocorrection(true)//自动纠正拼写
            .keyboardType(.emailAddress)//键盘类型
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("自定义内容"){}
                }
            }
            .enableInjection()
    }
}

struct KeyboardAttachmentView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardAttachmentView()
    }
}
