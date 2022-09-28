//
//  ShakeView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/28.
//

import SwiftUI

struct ShakeView: View {
    var body: some View {
        Text("Shake me!")
            .onShake {
                UIAlertController.showAlert(title: "warning", message: "shaken!!!")
            }
    }
}

struct ShakeView_Previews: PreviewProvider {
    static var previews: some View {
        ShakeView()
    }
}
