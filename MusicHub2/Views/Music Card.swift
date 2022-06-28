//
//  Music Card.swift
//  MusicHub2
//
//  Created by suranaree06 on 11/5/2565 BE.
//

import SwiftUI

struct Music_Card: View {
    var body: some View {
        HStack{
            Image("san").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            
            VStack(alignment:.leading){
                Text("Light").font(.system(size: 20)).foregroundColor(Color.white).bold()
                Text("San Holo")
                    .font(.system(size: 13)).foregroundColor(Color.gray).bold().padding(.top,15)
                    
            }.padding(50)
        }
    }
}

struct Music_Card_Previews: PreviewProvider {
    static var previews: some View {
        Music_Card()
    }
}
