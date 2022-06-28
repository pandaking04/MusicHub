//
//  Profile.swift
//  MusicHub2
//
//  Created by suranaree06 on 11/5/2565 BE.
//

import SwiftUI
import Firebase

struct Profile: View {
    @EnvironmentObject var dataModel:DataModel
    @ObservedObject private var viewModel = MusicModel()
    @State var isEdit = false
    @State var isUpload = false
    let storage = Storage.storage()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var showingAlert = false
    @State var songs = [Song]()
    let user = Auth.auth().currentUser
    let db = Firestore.firestore()
    @State var userName:String = ""
    
    func UploadImage(){
        let storageRef =
        storage.reference().child("\(dataModel.user.email).jpg")
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
                }
                
            }
        }
    }
    func LoadImage(){
        let storageRef = storage.reference().child("\(dataModel.user.email).jpg")
        storageRef.getData(maxSize: 1*1024*1024){ data, error in
            if let error = error{
                print("Error: \(error)")
            }else{
                selectedImage = UIImage(data: data!)
            }
        }
    }
    
    func deleteYourMusic(id: String){
        print(id)
        if let user = user{
            let uemail:String = "\(user.email!)"
            db.document("/user/\(uemail)/songs/"+id).delete(){err in
                if let err = err{
                    print(err)
                }else{
                    print("delete success")
                    showingAlert = true
                }
            }

        }
        
        
    }
    
    func deleteAllMusic(id: String){
        print(id)
            db.document("/allsongs/"+id).delete(){err in
                if let err = err{
                    print(err)
                }else{
                    print("delete success")
                    showingAlert = true
                }
            }

        
    }
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    
                    VStack{
                        Text("\(userName)").font(.system(size: 30)).bold().foregroundColor(Color.black).padding()
                        if selectedImage != nil{
                            Button(action:{
                                self.sourceType = .photoLibrary
                                self.isImagePickerDisplay.toggle()
                            }){
                            Image(uiImage: selectedImage!).resizable().foregroundColor(Color.blue).frame(width: 150, height: 150)
                            }
                        }else{
                            Button(action:{
                                self.sourceType = .photoLibrary
                                self.isImagePickerDisplay.toggle()
                            }){
                            Image("Profile")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                                .clipped()
                                
                            }
                        }
                        //                        Button("Photo"){
                        //                            self.sourceType = .photoLibrary
                        //                            self.isImagePickerDisplay.toggle()
                        //                        }
                        
                      
                            
                        
                        
                        
                        if let user = user {
                            let uemail: String = "\(user.email!)"
                            Text(uemail)
                                .font(.system(size: 20)).bold()
                                .foregroundColor(Color.black)
                        }
                        
                        
                        
                        
                        HStack{
                            
//                            Button("ProfilePicture"){
//                                self.sourceType = .photoLibrary
//                                self.isImagePickerDisplay.toggle()
//                            }.frame(width: 185, height: 50)
//                                .background(Color.gray)
//                                .foregroundColor(Color.white)
//                                .cornerRadius(48)
                            
                            NavigationLink(destination: EditProfile(), label: {
                                Text("Edit").bold().frame(width: 185, height: 50)
                                    .background(Color.gray)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(48)
                            })
                            
                            NavigationLink(destination: Upload(), label: {
                                Text("Upload").bold().frame(width: 185, height: 50)
                                    .background(Color.gray)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(48)
                            })
                            //                                Button("Upload"){
                            //
                            //                                }.padding().frame(minWidth:0,maxWidth: .infinity).background(Color.gray).foregroundColor(Color.white).cornerRadius(48)
                            
                        }.padding()
                        
                        
                    }
                    
                    Spacer()
                }
                //music
                List(viewModel.songs){ song in
                    if Auth.auth().currentUser?.email == song.email{
                    VStack{
                            
                            HStack{
                                AsyncImage(url: URL(string: song.image)){ image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }.frame(width: 150, height: 150)
                                
                                VStack(alignment:.leading){
                                    Text(song.name).font(.system(size: 20)).foregroundColor(Color.black).bold()
                                    Text(song.artist)
                                        .font(.system(size: 13)).foregroundColor(Color.gray).bold().padding(.top,15)
                                    
                                }.padding(50)
                                
                            }
                            
                            Button("Delete"){
                                //deleteYourMusic(id: song.docID)
                                deleteAllMusic(id: song.docID)
                            }.frame(width: 185, height: 50)
                            .background(Color.red)
                            .foregroundColor(Color.white)
                            .cornerRadius(48)
                            .alert(isPresented: $showingAlert){
                                Alert(title: Text("Delete Success"))
                            }
                            
                        
                    }
                }
                }
                Spacer()
                Button("Logout"){
                    dataModel.Logout()
                }.padding().frame(minWidth:0,maxWidth: .infinity).background(Color.gray).foregroundColor(Color.white).cornerRadius(48)
            }.onAppear(){
                if let user = user {
                    if user.displayName != nil {
                        let udpName: String = "\(user.displayName!)"
                        self.userName = udpName
                    }
                }
            }
            
                .onAppear(perform: LoadImage)
                .sheet(isPresented: $isImagePickerDisplay, onDismiss: UploadImage){
                    ImagePickerView(selectedImage: $selectedImage, sourceType: sourceType)
                }
        }.onAppear(){
            self.viewModel.fetchData()
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
