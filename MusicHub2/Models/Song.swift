//
//  Song.swift
//  MusicHub2
//
//  Created by suranaree06 on 14/6/2565 BE.
//

import Foundation

struct Song : Identifiable{
    var id = UUID()
    var name : String
    var artist : String
    var image : String
    var genre : String
    var file : String
    var docID : String!
    var email : String!
}
