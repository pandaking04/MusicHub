//
//  User.swift
//  MusicHub2
//
//  Created by suranaree06 on 12/5/2565 BE.
//

import Foundation
import UIKit
import Firebase

struct User:Identifiable,Codable{
    var id = UUID()
    var email : String
    var password : String
    
}
