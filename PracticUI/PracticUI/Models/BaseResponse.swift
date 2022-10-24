//
//  BaseResponse.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/10/24.
//

import Foundation

struct BaseResponse<T: Decodable > : Decodable {
    var message : String
    var data : T
    var status : Int
}
