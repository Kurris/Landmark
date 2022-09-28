//
//  AlertView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/21.
//

import SwiftUI
import Inject

struct AlertView: View {
    
    @ObserveInjection var inject
    
    @State var isShowAlert = false
    @State var isShowAlert2 = false
    @State var isShowAlert3 = false
    
    func confirm(){
       print("confirm")
    }
    
    func cancel(){
        print("cancel...")
    }
    
    
    var body: some View {
        VStack{
            Button("alert"){
                isShowAlert.toggle()
            }
            .alert(isPresented: $isShowAlert) {
                Alert(title: Text("title"), message: Text("message"), dismissButton: .default(Text("Ok")))
            }
            
            Button("alert2"){
                isShowAlert2.toggle()
            }
            .alert(isPresented: $isShowAlert2) {
                Alert(title: Text("title"), message: Text("message"),
                      primaryButton: .destructive(Text("是否确定?"), action:confirm),
                      secondaryButton: .cancel(Text("取消"), action: cancel))
            }
            
            Button("alert3"){
                isShowAlert3.toggle()
            }
            .alert("message",isPresented: $isShowAlert3) {
                Button("btn1"){
                    simpleSuccess()
                }
                Button("btn2"){}
                Button("btn3"){}
                Button("btn4"){}
            }
            
            Button("alert4"){
                UIAlertController.showAlert(title: "title", message: "message")
            }
        }
        .enableInjection()
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
