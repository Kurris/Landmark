//
//  ConfirmLoginView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/10/24.
//

import SwiftUI
import Inject
import Alamofire

struct ConfirmLoginView: View {
    
    @ObserveInjection var inject
    
    @EnvironmentObject var model : Model
    
    var body: some View {
        VStack{
            Button("同意"){
                Task{
                   await scan(allow: true)
                }
            }
            .buttonStyle(.bordered)
            
            Button("取消"){
                Task{
                  await  scan(allow: false)
                }
            }
            .buttonStyle(.bordered)
        } .enableInjection()
    }
    
    
    func scan( allow : Bool) async{
        let url = "http://localhost:5001/api/QrCode/process";
     
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(model.accessToken!)",
            "Content-Type":"application/json;charset=UTF-8"
        ]

        let param = [
            "Key": model.loginKey,
            "Allow" : String(allow)
        ]
        
        AF.request(url,method: .post,parameters: param,encoder: .json(),headers: headers).responseDecodable { (response: AFDataResponse<BaseResponse<String>>) in
            switch response.result {
            case .success(let result):
                if(result.status == 200){
                    print(result.data)
                }
                break
            case .failure(let error):
                print(error)
            }
            
            model.isShowConfirmLoginModal = false
        }
    }
}

struct ConfirmLoginView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmLoginView()
    }
}
