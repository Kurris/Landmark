//
//  ModelData.swift
//  PracticeApp
//
//  Created by 李国扬 on 2022/8/19.
//

import Foundation

final class ModelData : ObservableObject{
    @Published  var landmarks : [Landmark] = Load(fileName : "landmarkData.json")
    var hikes:[Hike] = Load(fileName: "hikeData.json")
    @Published var profile = Profile.default
    
    var features :[Landmark]{
        landmarks.filter { $0.isFeatured }
    }
    
    var categories :[String:[Landmark]] {
        Dictionary(grouping: landmarks, by: {$0.category.rawValue})
    }
}

func Load<T: Decodable>(fileName: String) -> T {
    let data : Data
    
    guard let file =  Bundle.main.url(forResource: fileName, withExtension: nil)
    else{
        fatalError("找不到文件\(fileName)")
    }
    
    do{
        data = try Data(contentsOf: file)
    }catch{
        fatalError("加载文件错误")
    }
    
    do{
        return  try JSONDecoder().decode(T.self, from:data)
    }catch{
        fatalError("json解析错误")
    }
}
