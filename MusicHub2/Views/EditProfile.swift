//
//  EditProfile.swift
//  MusicHub2
//
//  Created by suranaree06 on 26/5/2565 BE.
//

import SwiftUI
import Firebase

struct EditProfile: View {
    @EnvironmentObject var dataModel:DataModel
    @State private var showAlert = false
    @State var username : String = ""
    @State var des : String = ""
    @State var genre : String = ""
    @State private var genreIndex = 0
    var genre_type = ["Rock","Jazz","Pop","R&B","EDM"]
    @State private var selection = "Rock"
    @State private var sourceType:UIImagePickerController.SourceType = .photoLibrary
    let storage = Storage.storage()
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State var name = ""
    func Update(){
        let chageRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        chageRequest?.displayName = self.username
        chageRequest?.commitChanges{ err in
            print(err?.localizedDescription)
            if err?.localizedDescription != nil {
                print("error")
            }
        }
        showAlert = true
    }
   
    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                VStack{
                    HStack{
                        Text("Username")
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    TextField(" ",text: self.$username).background(Color.white).textFieldStyle(RoundedBorderTextFieldStyle())
                        .cornerRadius(20)
                        .padding(.bottom, 20.0)
                    
                    Button(action:{
                        if self.username != ""{
                            Update()
                        }
                    }){
                        Text("Save").foregroundColor(.white)
                    }.alert(isPresented: $showAlert){
                        Alert(title: Text("Change Username Successful"))
                    }
                    .cornerRadius(48).frame(width: 185, height: 50)
                    .background(Color("Color4"))
                        .onAppear(){
                            var user = Auth.auth().currentUser
                            if let user = user {
                                var udpName: String = "\(user.displayName!)"
                                
                                self.username = udpName
                            }
                        }
                }
                
                Spacer()
            }
            
            Spacer()
            
        }.background(Color("Color"))
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}
