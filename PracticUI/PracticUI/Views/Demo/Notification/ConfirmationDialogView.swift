//
//  ConfirmationDialogView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/21.
//

import SwiftUI
import Inject

struct ConfirmationDialogView: View {
    
    @ObserveInjection var inject
    @State private var showingOptions = false
    @State private var selection = "None"
    
    var body: some View {
        VStack{
            Text(selection)
            
            Button("Confirm paint color") {
                showingOptions = true
            }
            .confirmationDialog("Select a color", isPresented: $showingOptions, titleVisibility: .visible) {
                Button("Red") {
                    selection = "Red"
                }
                
                Button("Green") {
                    selection = "Green"
                }
                
                Button("Blue") {
                    selection = "Blue"
                }
            }
        }
        .enableInjection()
    }
}

struct ConfirmationDialogView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationDialogView()
    }
}
