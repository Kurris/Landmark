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

struct ScanView: View {
    
    @ObserveInjection var inject
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var showViewfinder = true//二维码框
    @State var isTorchOn = false//闪光灯
    @State var isGalleryPresented = false //相册
    
    let vibrateGenerator = UINotificationFeedbackGenerator()
    
    func getDevice()->AVCaptureDevice{
        let device = AVCaptureDevice.default(for: .video)
        return device!
    }
    
    var body: some View {
        VStack{
            CodeScannerView(codeTypes: [.qr,.ean8, .ean13, .pdf417],scanMode: .continuous,scanInterval: 2.0,showViewfinder:showViewfinder, shouldVibrateOnSuccess: true,isTorchOn: isTorchOn,
                            isGalleryPresented: $isGalleryPresented,videoCaptureDevice:getDevice()) { response in
                
                switch response {
                case .success(let result):
                    print("Found code: \(result.string)")
                    vibrateGenerator.notificationOccurred(.success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
//        .safeAreaInset(edge: .top){
//            HStack{
//                VStack{
//                    Circle().fill(.white)
//                        .frame(width: 32, height: 32)
//                        .overlay {
//                            Image(systemName: "chevron.backward")
//                        }
//                }
//                .onTapGesture {
//                    presentationMode.wrappedValue.dismiss()
//                }
//                .padding(.leading , 28)
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .bottomLeading)
//            .frame(height:  170)
//        }
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
                                .font(Font.system(size: 28))
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
                                .font(Font.system(size: 28))
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
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
