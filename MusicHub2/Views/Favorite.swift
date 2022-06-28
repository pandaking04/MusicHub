//
//  Favorite.swift
//  MusicHub2
//
//  Created by suranaree06 on 26/5/2565 BE.
//

import SwiftUI
import Firebase

struct Favorite: View {
    @ObservedObject private var viewModel = MusicModel()
    @State private var showAlert = false
    @State var FSong: [Song] = []
    let db = Firestore.firestore()
    //    func DeleteFavorite(){
    //        let user = Auth.auth().currentUser
    //        if let user = user{
    //            let uemail: String = "\(user.email!)"
    //            db.collection("user").document(uemail).collection("favorite") {
    //                err in
    //                if let err = err{
    //                    print("Error removing document")
    //                }else{
    //                    print("Success")
    //                }
    //            }
    //        }
    //    }
    var body: some View {
        NavigationView{
            
            
            List(viewModel.songs){ song in
                NavigationLink{
                  MusicPlayerFavo(song: song)
                }label: {
                   VStack{
                        HStack{
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
                           //                        Button(action: self.DeleteFavorite, label: {
                          //                            Image(systemName: "heart").resizable()
                           //                        }).frame(width: 25, height: 25, alignment: .center).foregroundColor(Color.black).padding()
                       }
                       
                   }
               }
            }.navigationBarTitle("Favorite")
                
        }
        .onAppear(){
            self.viewModel.fetchFavoriteMusic()
        }
    }
    
    private func removeRows(at offsets: IndexSet){
        offsets.forEach{ index in
            let user = Auth.auth().currentUser
            if let user = user{
                let uemail: String = "\(user.email)"
                let store = FSong[index]
                db.collection("user").document(uemail).collection("favorite").whereField("Id", isEqualTo: store.docID!).getDocuments() {(qs,err) in
                    if let err = err {
                        print(err)
                    }else{
                        for doc in qs!.documents{
                            print(doc.documentID)
                            db.collection("user").document(uemail).collection("favorite").document(doc.documentID).delete()
                            showAlert = true
                            self.viewModel.fetchFavoriteMusic()
                        }
                    }
                }
            }
        }
    }
}

struct Favorite_Previews: PreviewProvider {
    static var previews: some View {
        Favorite()
    }
}
