//
//  Genre.swift
//  MusicHub2
//
//  Created by suranaree06 on 17/6/2565 BE.
//

import Foundation

struct Genre: Identifiable,Hashable,Codable{
    var id = UUID().uuidString
    var title: String
}

var genre = [
    Genre(title:  "Rock"),
    Genre(title: "Jazz"),
    Genre(title:  "Pop"),
    Genre(title:  "R&B"),
    Genre(title:  "EDM")
]

