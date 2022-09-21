//
//  CustomNavigation.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/16.
//

import SwiftUI
import Inject

struct CustomNavigation: View {
    
    
    @State var isActived = false
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink{
                    CustomNavigationChild()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("跳转")
                       
                }
                
                
                NavigationLink(destination:   CustomNavigationChild()
                                .navigationBarBackButtonHidden(true), isActive: $isActived) {
                    EmptyView()
                }
                
                Button("设置isActived=true"){
                    isActived = true
                }
            }
        }
        .enableInjection()
    }
}


struct CustomNavigationChild: View {
    
    @ObserveInjection var inject
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button("back"){
                presentationMode.wrappedValue.dismiss()
            }
        }
        .enableInjection()
    }
}

struct CustomNavigation_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigation()
    }
}
