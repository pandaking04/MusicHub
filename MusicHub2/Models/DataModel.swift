//
//  DataModel.swift
//  MusicHub2
//
//  Created by suranaree06 on 12/5/2565 BE.
//

import Foundation
import UIKit
import SwiftUI
import Firebase

final class DataModel : ObservableObject{
    @Published var user = User(email: "", password: "")
    @Published var isLogin:Bool = false
    
    let storage = Storage.storage()
    @Published private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func Login(){
        Auth.auth().signIn(withEmail:user.email,password: user.password){
            authResult, error in
            if authResult != nil {
                self.isLogin = true
            }
        }
    }
    
    func Logout(){
        let firebaseauth = Auth.auth()
        do{
            try firebaseauth.signOut()
            self.isLogin = false
        }catch let signoutError as NSError{
            print("Error: \(signoutError)")
        }
    }
    
    func loadSong(){
        Firestore.firestore().collection("Albums").getDocuments { (snapshot, error) in
            if error == nil{
               
                
            } else{
                print(error)
            }
        }
    }
   
    
    
    
}
