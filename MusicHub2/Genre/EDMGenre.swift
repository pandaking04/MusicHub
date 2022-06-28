//
//  EDMGenre.swift
//  MusicHub2
//
//  Created by suranaree06 on 17/6/2565 BE.
//

import SwiftUI

struct EDMGenre: View {
    @ObservedObject private var viewModel = MusicModel()
    var body: some View {
        NavigationView{
            
               
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
            }.navigationTitle("EDM")
                
        }.onAppear() {
            self.viewModel.fetchEDMMusic()
        }
        
    }

}

struct EDMGenre_Previews: PreviewProvider {
    static var previews: some View {
        EDMGenre()
    }
}
