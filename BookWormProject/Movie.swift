//
//  Movie.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/07/31.
//

import Foundation

struct Movie {
    let title: String
    let releaseDate: String
    let runtime: Int
    let overview: String
    let rate: Double
    var like: Bool = false
    
    var likeValue: Bool {
        get{return like}
        set {
            like.toggle()
        }
    }
}
