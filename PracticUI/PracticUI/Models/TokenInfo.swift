//
//  TokenInfo.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/10/6.
//

import Foundation
import SwiftUI

struct TokenInfo : Decodable{
    var access_token : String
    var expires_in : Int64
    var token_type : String
    var scope : String
}
