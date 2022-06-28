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

struct MusicPlayer : View{
    var song : Song
    @State private var showAlert = false
    @State var isPlaying : Bool = true
    let db = Firestore.firestore()
    @State var player = AVPlayer()
    var body: some View{
       
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Button(action: self.addFavorite, label: {
                            Image(systemName: "heart").resizable()
                        }).frame(width: 25, height: 25, alignment: .center).foregroundColor(Color.white).padding()
                    }.alert(isPresented: $showAlert){
                        Alert(title: Text("Favorite"), message: Text("You have been added your favorite music"))
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
    
    func addFavorite(){
        let user = Auth.auth().currentUser
        if let user = user{
            let uemail: String = "\(user.email!)"
            let collRef = db.collection("user").document(uemail).collection("favorite")
            
            collRef.addDocument(data: ["name" : song.name,
                                       "artist" : song.artist,
                                       "image" : song.image,
                                       "file" : song.file])
        }
        showAlert = true
    }
    
}

struct MusicPlayer_Preview : PreviewProvider {
    
    static var previews: some View {
        MusicPlayer(song: Song(name: "Light",artist: "San Holo", image: "san",genre: "FutureBass",file: "file",docID: "123"))
        
    }
}
