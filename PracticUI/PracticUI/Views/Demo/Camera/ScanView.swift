//
//  ScanView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/28.
//

import SwiftUI
import CodeScanner
import Inject

struct ScanView: View {
    
    @ObserveInjection var inject
    
    var body: some View {
        CodeScannerView(codeTypes: [.qr]) { response in
            print(response)
            switch response {
            case .success(let result):
                print("Found code: \(result.string)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .enableInjection()
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
