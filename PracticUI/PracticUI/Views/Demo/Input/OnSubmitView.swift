//
//  OnSubmitView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/26.
//

import SwiftUI
import Inject

struct OnSubmitView: View {
    
    @ObserveInjection var inject
    
    var body: some View {
        CustomSubmitButtonView()
            .onSubmit {
                print("on submit")
            }
            .enableInjection()
    }
}

struct OnSubmitView_Previews: PreviewProvider {
    static var previews: some View {
        OnSubmitView()
    }
}
