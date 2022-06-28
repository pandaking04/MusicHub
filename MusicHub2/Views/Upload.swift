//
//  Upload.swift
//  MusicHub2
//
//  Created by suranaree06 on 26/5/2565 BE.
//

import SwiftUI
import Firebase
import MobileCoreServices

struct Upload: View {
    @State private var showAlert = false
    @State var artist : String = ""
    @State var music_name : String = ""
    @State var genre : String = ""
    @State private var genreIndex = 0
    var genre_type = ["Rock","Jazz","Pop","R&B","EDM"]
    @State private var selection = "Rock"
    @EnvironmentObject var modelData:DataModel
    @State private var selectedImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var isImagePickerDisplay = false
    let db = Firestore.firestore()
    let storage = Storage.storage()
    @State var show = false
    @State var alert = false
    @State var musicURL = ""
    let imgID = UUID().uuidString
    let user = Auth.auth().currentUser
    
    @State var imgURL = ""
    @State var fileURL = ""
   
    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                VStack{
                    if selectedImage != nil{
                        Image(uiImage: selectedImage!).resizable().foregroundColor(Color.blue).frame(width: 150, height: 150)
                    }else{
                        Button(action:{
                            self.sourceType = .photoLibrary
                            self.isImagePickerDisplay.toggle()
                        }){
                            Image("ImageUpload1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 135, height: 135)
                                .clipped()
                                .padding(.vertical, 20)
                        }
                   
                    }
                    
                    HStack{
                        Text("Artist")
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    TextField(" ",text: self.$artist).background(Color.white).textFieldStyle(RoundedBorderTextFieldStyle())
                        .cornerRadius(20)
                        .padding(.bottom, 20.0)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    HStack{
                        Text("Track Name")
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    TextField(" ",text: self.$music_name).background(Color.white).textFieldStyle(RoundedBorderTextFieldStyle())
                        .cornerRadius(20)
                        .padding(.bottom, 20.0)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    HStack{
                        Text("Genre")
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    HStack{
                    Picker("Select a Genre", selection: $selection){
                        ForEach(genre_type, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.menu)
                        Spacer()
                    }.padding()
                    
                    HStack{
                        Text("Upload File")
                            .foregroundColor(Color.white)
                        Spacer()
                        Button(action: {
                            self.show.toggle()
                        }){
                            Text("Select File")
                        }.padding()
                            .background(Color("Color4"))
                            .cornerRadius(20)
                            .foregroundColor(Color.white)
                            .clipShape(Capsule())
                            .sheet(isPresented: $show){
                                DocumentPicker(alert: self.$alert, musicURL: self.$musicURL   )
                            }
                            .alert(isPresented: $alert){
                                Alert(title: Text("Message"), message: Text("Upload Successfully"), dismissButton: .default(Text("OK")))
                            }
                        
                    }.padding(.bottom, 15.0)
                    HStack{
                        
                        Button("Upload"){
                            print(selection)
                            UploadMusic()
                            
                        }.padding()
                            .background(Color("Color4"))
                            .cornerRadius(20)
                            .foregroundColor(Color.white)
                            .clipShape(Capsule())
                            
                        
                    }.alert(isPresented: $showAlert){
                        Alert(title: Text("Upload Success"), message: Text("You have been upload your file"))
                    }
                    
                }.sheet(isPresented: $isImagePickerDisplay){
                    ImagePickerView(selectedImage: $selectedImage, sourceType: sourceType)
                }
                
                Spacer()
            }
            
            Spacer()
            
        }.background(Color("Color"))
    }
    
    func UploadMusic(){
        
        let storageRef =
        storage.reference().child("\(imgID).jpg")
        let data = selectedImage?.jpegData(compressionQuality: 0.2)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        if let data = data{
            storageRef.putData(data,metadata: metadata){metadata,
                error in
                if let error = error{
                    print("Error: \(error)")
                }
                if metadata != nil{
                    print("Done")
                    storageRef.downloadURL{ (url, error) in
                        if error != nil{
                    
                        }else{
                            if let user = user{
                                let uemail: String = "\(user.email!)"
                            
                            imgURL = url!.absoluteString
                            print("imgURL")
                            let collRef1 = db.collection("allsongs")
//                            let collRef = db.collection("user").document(modelData.user.email)
//                                .collection("songs")
//                            collRef.addDocument(data: ["name" : music_name,
//                                                       "artist" : artist,
//                                                       "genre" : selection,
//                                                       "image" : imgURL,
//                                                       "file" : musicURL,
//                                                       "email" : uemail
//                                                      ])
                            collRef1.addDocument(data: ["name" : music_name,
                                                       "artist" : artist,
                                                       "genre" : selection,
                                                        "image" : imgURL,
                                                        "file" : musicURL,
                                                        "email" : uemail
                                                      ])
                            }
                            
                        }
                    }
                }
                
            }
        }
        print(imgURL)
        showAlert = true
        
    }
}

struct DocumentPicker : UIViewControllerRepresentable{
    func makeCoordinator() -> Coordinator {
        return DocumentPicker.Coordinator(parent1: self)
    }
    @Binding var alert : Bool
    @Binding var musicURL : String
    
    @State var fileURL = ""
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController  {
        let picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeMP3)], in: .open)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        
    }
    
    class Coordinator : NSObject,UIDocumentPickerDelegate{
        var parent : DocumentPicker
        var musicURL : String
        
        init(parent1: DocumentPicker){
            parent = parent1
            musicURL = ""
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            let bucket = Storage.storage().reference()
            let musicRef = bucket.child((urls.first?.deletingPathExtension().lastPathComponent)!)
            musicRef.putFile(from: urls.first!, metadata: nil){
                (_, err) in
                if err != nil{
                    print((err?.localizedDescription)!)
                    return
                }
                musicRef.downloadURL{url, error in
                    if let error = error {
                        print(error.localizedDescription)
                    }else{
                        print(url!.absoluteString)
                        self.parent.musicURL = url!.absoluteString
                    }
                }
                
                print(urls)
                print("success")
                self.parent.alert.toggle()
                
            }
        }
    }
}

struct Upload_Previews: PreviewProvider {
    static var previews: some View {
        Upload()
    }
}
