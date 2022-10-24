//
//  ScanView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/28.
//

import SwiftUI
import CodeScanner
import Inject
import AVFoundation
import Alamofire

struct ScanView: View {
    
    @ObserveInjection var inject
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var showViewfinder = true//二维码框
    @State var isTorchOn = false//闪光灯
    @State var isGalleryPresented = false //相册
    
    let vibrateGenerator = UINotificationFeedbackGenerator()

    @EnvironmentObject var model : Model
    
    //    func getDevice()->AVCaptureDevice{
    //        let device = AVCaptureDevice.default(for: .video)
    //        return device!
    //    }
    
    var body: some View {
//        scanMode: .continuous, scanInterval: 2.0,
        VStack{
            CodeScannerView(codeTypes: [.qr,.ean8, .ean13, .pdf417], showViewfinder:showViewfinder, simulatedData: "login:CfDJ8FKyxQEd2BlEg7yAknTdB4x_C21c2ZTd5Jza3Hk1eQ8CmjUEOjKYbb1l8YCXJI-AcmlMj8kIOALBEMfcmXdoUA2Y531WFLhZmXf0ebk5CN35qgQ55XCM__BwP1yyD3gMd7TepmyQ7xtBTY63amWym6A", shouldVibrateOnSuccess: true,isTorchOn: isTorchOn,
                            isGalleryPresented: $isGalleryPresented) { response in
                
                switch response {
                case .success(let result):
                    handlerResult(code: result.string)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all,edges: [.bottom])
        .safeAreaInset(edge: .bottom){
            HStack{
                Spacer()
                VStack{
                    Button("取消"){
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                Spacer()
                
                VStack{
                    Circle().fill(.white)
                        .frame(width: 50, height: 50)
                        .overlay {
                            Image(systemName: "photo")
                                .font(Font.system(size: 15))
                        }
                    
                    Text("使用相册")
                        .foregroundColor(.white)
                        .font(.caption)
                }
                .onTapGesture {
                    isGalleryPresented=true
                }
                
                Spacer()
                VStack{
                    Circle().fill(.white)
                        .frame(width: 50, height: 50)
                        .overlay {
                            Image(systemName: "lightbulb")
                                .symbolVariant(isTorchOn ? .fill : .none)
                                .font(Font.system(size: 15))
                        }
                    
                    Text("闪光灯")
                        .foregroundColor(.white)
                        .font(.caption)
                }
                .onTapGesture {
                    isTorchOn.toggle()
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .leading)
            .frame(height: 150)
            .background(.black)
        }
        .edgesIgnoringSafeArea(.all)
        .enableInjection()
    }
    
    func handlerResult(code : String){
        print("Found code: \(code)")
        
        let codes =  code.split(separator: ":")
        guard codes.count == 2 else {return}
        
        let type = codes.first!
        let content = codes.last!
        
        if type == "login"{
            Task{
                await  scan(key: String(content))
            }
        }
    }
    
    func scan( key : String) async{
        let url = "http://localhost:5001/api/QrCode/scan";
     
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(model.accessToken!)",
            "Content-Type":"application/json;charset=UTF-8"
        ]

        let param = [
            "Key": key
        ]
        AF.request(url,method: .post,parameters: param,encoder: .json(),headers: headers).responseDecodable { (response: AFDataResponse<BaseResponse<String>>) in
            switch response.result {
            case .success(let result):
                if(result.status == 200){
                    print(result.data)
                    if result.data == "WaitConfirm"{
                        vibrateGenerator.notificationOccurred(.success)
                        presentationMode.wrappedValue.dismiss()
                        
                        model.loginKey = key
                        model.isShowConfirmLoginModal = true
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
