//
//  Music.swift
//  MusicHub2
//
//  Created by suranaree06 on 10/5/2565 BE.
//

import SwiftUI


struct Music: View {
    //  @ObservedObject var data : DataModel
    @ObservedObject private var viewModel = MusicModel()
    @State var songs = [Song]()
    
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                Spacer()
                List(viewModel.songs){song in
                    NavigationLink{
                        MusicPlayer(song: song)
                    }label: {
                        
                        AsyncImage(url: URL(string: song.image)){ image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }.frame(width: 105, height: 105)
                        
                        VStack(alignment:.leading){
                            Text(song.name).font(.system(size: 20)).foregroundColor(Color.black).bold()
                            Text(song.artist)
                                .font(.system(size: 13)).foregroundColor(Color.gray).bold().padding(.top,15)
                            
                        }.padding(50)
                        
                    }
                    //                    ForEach(self.songs, id: \.self, content: {
                    //                        song in
                    //                        MusicCard(song: song)
                    //                    })
                }.navigationTitle("Music")
                Spacer()
            }
        }
        
        .onAppear() {
            self.viewModel.fetchData()
            
        }
        
        
    }
    
    struct MusicCard:View{
        var song: Song
        var body: some View{
            
            NavigationLink(destination: MusicPlayer(song: song),
                           label:{
                HStack{
                    Image(song.image).resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                    
                    VStack(alignment:.leading){
                        Text(song.name).font(.system(size: 20)).foregroundColor(Color.white).bold()
                        Text(song.artist)
                            .font(.system(size: 13)).foregroundColor(Color.gray).bold().padding(.top,15)
                        
                    }.padding(50)
                }
                
                
                
                
                
                
            })
        }
    }
}


//struct Music_Previews: PreviewProvider {
//    static var previews: some View {
//        Music()
//    }
//}
