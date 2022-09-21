//
//  Coin.swift
//  PracticUI
//
//  Created by 李国扬 on 2022/8/29.
//

import Foundation

struct Coin: Identifiable, Codable {
    var id: Int
    var uid: UUID
    var coin_name: String
    var acronym: String
    var logo: String
}
