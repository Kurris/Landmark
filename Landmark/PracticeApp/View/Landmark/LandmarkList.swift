//
//  LandmarkList.swift
//  PracticeApp
//
//  Created by 李国扬 on 2022/8/19.
//

import SwiftUI

struct LandmarkList: View {
    
    @EnvironmentObject var modelData : ModelData
    @State private var showFavoriteOnly = false
    
    var filterLandmarks :[Landmark] {
        modelData.landmarks.filter{x in
            (!showFavoriteOnly || x.isFavorite)
        }
    }
    
    var body: some View {
        NavigationView{
            List(){
                Toggle(isOn: $showFavoriteOnly){
                    Text("Favorite Only")
                }
                ForEach(filterLandmarks){ landmark in
                    NavigationLink{
                        LandmarkDetail(landmark: landmark)
                    }label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
//        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
//                   LandmarkList()
//                       .previewDevice(PreviewDevice(rawValue: deviceName))
//               }
        
        LandmarkList().environmentObject(ModelData())
    }
}
