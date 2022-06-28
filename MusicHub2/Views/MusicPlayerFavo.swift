//
//  MusicPlayer.swift
//  MusicHub2
//
//  Created by suranaree06 on 7/6/2565 BE.
//

import Foundation
import SwiftUI
import AVKit
import Firebase

struct MusicPlayerFavo : View{
    var song : Song
    @State private var showAlert = false
    @State var isPlaying : Bool = true
    let db = Firestore.firestore()
    @State var player = AVPlayer()
    @State private var showingAlert = false
    let user = Auth.auth().currentUser
    func deleteYourMusic(id: String){
        print(id)
        if let user = user{
            let uemail:String = "\(user.email!)"
            db.document("/user/\(uemail)/favorite/"+id).delete(){err in
                if let err = err{
                    print(err)
                }else{
                    print("delete success")
                    showingAlert = true
                    
                }
            }
        }
        
        
    }
    var body: some View{
       
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Spacer()
                    }
                    
                    AsyncImage(url: URL(string: song.image)){ image in
                        image.resizable().padding(.bottom)
                    } placeholder: {
                        ProgressView()
                    }.frame(width: 250, height: 250)
//                    Image(song.image).resizable().aspectRatio(contentMode: .fit)
//                        .frame(width: 250, height: 250).padding(.bottom)
                    Text(song.name).bold().foregroundColor(Color.white).padding()
                    Text(song.artist).foregroundColor(Color.white.opacity(0.5)).font(.system(size: 13))
                    
                    
                    HStack{
                        
                        Button(action: self.playPause, label: {
                            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill").resizable()
                        }).frame(width: 50, height: 50, alignment: .center).padding().foregroundColor(Color.white)
                        
                    }
                    Button("Delete From Favorite"){
                        deleteYourMusic(id: song.docID)
                    }.frame(width: 185, height: 50)
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(48)
                    
                    Spacer()
                }.background(Color("Color")).edgesIgnoringSafeArea(.all)
            .onAppear(){
                let storage = Storage.storage().reference(forURL: song.file)
                storage.downloadURL { (url, error) in
                    if error != nil{
                        print(error)
                    } else{
                        player = AVPlayer(playerItem: AVPlayerItem(url: url!))
                        player.play()
                    }
                }
                
                
            }
            
    }
    
    
    func playPause(){
        self.isPlaying.toggle()
        if isPlaying == false{
            player.pause()
        }else{
            player.play()
        }
    }
    func next(){
        
    }
    func previous(){
        
    }
    
   
    
}

struct MusicPlayerFavo_Preview : PreviewProvider {
    
    static var previews: some View {
        MusicPlayer(song: Song(name: "Light",artist: "San Holo", image: "san",genre: "FutureBass",file: "file",docID: "123"))
        
    }
}

