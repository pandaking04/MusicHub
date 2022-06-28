import Foundation
import FirebaseFirestore
import SwiftUI
import Firebase

final class MusicModel: ObservableObject {
    
    @Published var songs = [Song]()
    @EnvironmentObject var modelData:DataModel
    let db = Firestore.firestore()
    
    func fetchData() {
        db.collection("allsongs").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
            self.songs = documents.map {(queryDocumentSnapshot) -> Song in
                let data = queryDocumentSnapshot.data()
                let docID = queryDocumentSnapshot.documentID
                let artist = data["artist"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let genre = data["genre"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let file = data["file"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                return Song(name: name, artist: artist, image: image, genre: genre, file: file,docID: docID,email: email)
            }
        }
    }
    
    func fetchMusicUser() {
        //print(modelData.user.email)
        let user = Auth.auth().currentUser
        if let user = user{
            let uemail: String = "\(user.email!)"
            db.collection("user").document(uemail).collection("songs").addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else{
                    print("No Documents")
                    return
                }
                self.songs = documents.map {(queryDocumentSnapshot) -> Song in
                    let data = queryDocumentSnapshot.data()
                    let docID = queryDocumentSnapshot.documentID
                    let artist = data["artist"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let genre = data["genre"] as? String ?? ""
                    let image = data["image"] as? String ?? ""
                    let file = data["file"] as? String ?? ""
                    return Song(name: name, artist: artist, image: image, genre: genre,file: file,docID: docID)
                }
        }
       
        }
    }
    
    func fetchFavoriteMusic() {
        //print(modelData.user.email)
        let user = Auth.auth().currentUser
        if let user = user{
            let uemail: String = "\(user.email!)"
            db.collection("user").document(uemail).collection("favorite").addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else{
                    print("No Documents")
                    return
                }
                self.songs = documents.map {(queryDocumentSnapshot) -> Song in
                    let data = queryDocumentSnapshot.data()
                    let artist = data["artist"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let genre = data["genre"] as? String ?? ""
                    let image = data["image"] as? String ?? ""
                    let file = data["file"] as? String ?? ""
                    let docID = queryDocumentSnapshot.documentID
                    return Song(name: name, artist: artist, image: image, genre: genre,file: file, docID: docID)
                }
            }
            
        }
    }
    
    func fetchRockMusic(){
        db.collection("allsongs").whereField("genre",isEqualTo: "Rock").addSnapshotListener{ querySnapshot, error in
            guard let documents = querySnapshot?.documents else{
                print("No Doc")
                return
            }
            self.songs = documents.map {(queryDocumentSnapshot) -> Song in
                let data = queryDocumentSnapshot.data()
                let artist = data["artist"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let genre = data["genre"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let file = data["file"] as? String ?? ""
                let docID = queryDocumentSnapshot.documentID
                return Song(name: name, artist: artist, image: image, genre: genre,file: file,docID: docID)
            }
           
        }
    }
    
    func fetchJazzMusic(){
        db.collection("allsongs").whereField("genre",isEqualTo: "Jazz").addSnapshotListener{ querySnapshot, error in
            guard let documents = querySnapshot?.documents else{
                print("No Doc")
                return
            }
            self.songs = documents.map {(queryDocumentSnapshot) -> Song in
                let data = queryDocumentSnapshot.data()
                let artist = data["artist"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let genre = data["genre"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let file = data["file"] as? String ?? ""
                let docID = queryDocumentSnapshot.documentID
                return Song(name: name, artist: artist, image: image, genre: genre,file: file,docID: docID)
            }
           
        }
    }
    
    func fetchPopMusic(){
        db.collection("allsongs").whereField("genre",isEqualTo: "Pop").addSnapshotListener{ querySnapshot, error in
            guard let documents = querySnapshot?.documents else{
                print("No Doc")
                return
            }
            self.songs = documents.map {(queryDocumentSnapshot) -> Song in
                let data = queryDocumentSnapshot.data()
                let artist = data["artist"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let genre = data["genre"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let file = data["file"] as? String ?? ""
                let docID = queryDocumentSnapshot.documentID
                return Song(name: name, artist: artist, image: image, genre: genre,file: file,docID: docID)
            }
           
        }
    }
    
    func fetchEDMMusic(){
        db.collection("allsongs").whereField("genre",isEqualTo: "EDM").addSnapshotListener{ querySnapshot, error in
            guard let documents = querySnapshot?.documents else{
                print("No Doc")
                return
            }
            self.songs = documents.map {(queryDocumentSnapshot) -> Song in
                let data = queryDocumentSnapshot.data()
                let artist = data["artist"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let genre = data["genre"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let file = data["file"] as? String ?? ""
                let docID = queryDocumentSnapshot.documentID
                return Song(name: name, artist: artist, image: image, genre: genre,file: file,docID:docID )
            }
           
        }
    }
    
    func fetchRnBMusic(){
        db.collection("allsongs").whereField("genre",isEqualTo: "R&B").addSnapshotListener{ querySnapshot, error in
            guard let documents = querySnapshot?.documents else{
                print("No Doc")
                return
            }
            self.songs = documents.map {(queryDocumentSnapshot) -> Song in
                let data = queryDocumentSnapshot.data()
                let artist = data["artist"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let genre = data["genre"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let file = data["file"] as? String ?? ""
                let docID = queryDocumentSnapshot.documentID
                return Song(name: name, artist: artist, image: image, genre: genre,file: file,docID: docID)
            }
           
        }
    }
}
