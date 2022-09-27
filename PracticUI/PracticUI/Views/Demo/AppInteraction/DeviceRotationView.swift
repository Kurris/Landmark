//
//  DeviceRotationView.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/9/26.
//

import SwiftUI

struct DeviceRotationView: View {
    @State private var orientation = UIDeviceOrientation.unknown

       var body: some View {
           Group {
               if orientation.isPortrait {
                   Text("Portrait")
               } else if orientation.isLandscape {
                   Text("Landscape")
               } else if orientation.isFlat {
                   Text("Flat")
               } else {
                   Text("Unknown")
               }
           }
           .onRotate { newOrientation in
               orientation = newOrientation
           }
       }
}

struct DeviceRotationView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceRotationView()
    }
}


// Our custom view modifier to track rotation and
// call our action
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
