//
//  ProfileHost.swift
//  PracticeApp
//
//  Created by 李国扬 on 2022/8/19.
//

import SwiftUI

struct ProfileHost: View {
    
    @Environment(\.editMode) var editMode
    @State private var profile = Profile.default
    @EnvironmentObject var modelData : ModelData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack{
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) {
                        profile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }
            if editMode?.wrappedValue == .inactive{
                ProfileSummary(profile: modelData.profile)
            }else{
                ProfileEditor(profile: $profile)
                    .onAppear{
                        profile = modelData.profile
                    }
                    .onDisappear{
                        modelData.profile = profile
                    }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(ModelData())
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
