//
//  LoginView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/10/6.
//

import SwiftUI
import Alamofire

struct LoginView: View {
    
    @State var userName : String = ""
    @State var password = ""
    @AppStorage("access_token") var accessToken : String?
    @EnvironmentObject var model : Model
    
    var body: some View {
        VStack{
            
                TextField("username", text: $userName)
                    .inputStyle(icon: "person")
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)//自动大写
                    .disableAutocorrection(true)//自动校验拼写错误

                SecureField("password", text: $password)
                    .inputStyle(icon: "lock")
                    .textContentType(.password)
                
                
                Button("登陆"){
                    Task{
                       await loginAsync()
                    }
                }
                .buttonStyle(.bordered)
        }
    }
    
    func loginAsync() async{
        let url = "https://isawesome.cn:5000/connect/token";
        
        let param = [
            "grant_type": "password",
            "client_id" : "reference",
            "client_secret" : "dd80d4c163396e24",
            "scope" : "profile openid",
            "username" : "\(userName)",
            "password" : "\(password)",
        ]
        
        let headers:HTTPHeaders=[
            "Content-Type":"application/x-www-form-urlencoded; charset=UTF-8"
        ]
        
        AF.request(url,method: .post,parameters: param,headers: headers).responseDecodable { (response: AFDataResponse<TokenInfo>) in
            switch response.result {
            case .success(let tokenInfo):
                accessToken = tokenInfo.access_token
                model.isShowLoginModal = false
            case .failure(let error):
                print("error:\(error)")
            }
        }
        
//        AF.request(url,method: .post,parameters: param,encoding: URLEncoding(),headers: headers).responseJSON{
//                response in
//
//            print(response)
//        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
