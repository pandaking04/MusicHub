//
//  Search.swift
//  MusicHub2
//
//  Created by suranaree06 on 10/5/2565 BE.
//

import SwiftUI

struct Search: View {
    @State var genres = [Genre]()
    
    var body: some View {
        NavigationView{
            VStack{
                    
                    NavigationLink(destination: RockGenre(), label: {
                        CardView(genre: "Rock")
                    })
                    NavigationLink(destination: JazzGenre(), label: {
                        CardView(genre: "Jazz")
                    })
                    NavigationLink(destination: PopGenre(), label: {
                        CardView(genre: "Pop")
                    })
                    NavigationLink(destination: RBGenre(), label: {
                        CardView(genre: "R&B")
                    })
                    NavigationLink(destination: EDMGenre(), label: {
                        CardView(genre: "EDM")
                    })
                
                
                Spacer()
            }
                .navigationTitle(Text("Genre"))
        }
    }
    
}


struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
