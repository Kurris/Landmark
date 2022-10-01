//
//  Explore.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/22.
//

import SwiftUI
import Inject

struct ExploreView: View {
    
    @ObserveInjection var inject
    
    @State var text = ""
    @State var email = ""
    @State var password = ""
    
    @State var circleY : CGFloat = .zero
    @State var emailY : CGFloat = .zero
    @State var passwordY : CGFloat = .zero
    
    enum SelectField : Hashable{
        case mail
        case password
    }
    
    @State var popover : Bool  = false
    @FocusState var currentSelectField : SelectField?
 
    var body: some View {
        VStack{
            Text("**登陆界面**")
            Group{
               
                TextField("email", text: $email)
                    .inputStyle(icon: "mail")
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)//自动大写
                    .disableAutocorrection(true)//自动校验拼写错误
                    .focused($currentSelectField, equals: .mail)
                    .shadow(color: currentSelectField == .mail
                            ? Color.primary.opacity(0.3)
                            : .clear, radius: 10, x: 0, y: 3)

                SecureField("password", text: $password)
                    .inputStyle(icon: "lock")
                    .textContentType(.password)
                    .focused($currentSelectField, equals: .password)
                    .shadow(color: currentSelectField == .password
                            ? Color.primary.opacity(0.3)
                            : .clear, radius: 10, x: 0, y: 3)

                Button("Open Popover") {
                    popover = true
                }
                .popover(isPresented: $popover) {
                        Text("Hello world")
                        .padding()
                }
                .buttonStyle(.bordered)
                .tint(.accentColor)
                .controlSize(.large)
            }
            .padding()
        }
        .frame(maxWidth:.infinity , maxHeight: .infinity)
        .strokeCornerRadiusStyle()
        .enableInjection()
    }
}
