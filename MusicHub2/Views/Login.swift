//
//  Login.swift
//  ProjectIOS
//
//  Created by suranaree25 on 10/5/2565 BE.
//

import SwiftUI
import Firebase
import UIKit


struct Login: View {
    
    
    var body: some View {
        Home()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
            .preferredColorScheme(.dark)
    }
}



struct Home :View {
    
  @State var index = 0
    
    var body:some View{
        
        GeometryReader{ _ in
            
            VStack{
                Image("MusicHub")
                    .resizable()
                    .frame(width: 170, height: 60).padding()
                
                ZStack{
                    SignUp(index: self.$index)
                        .zIndex(Double(self.index))
                    
                    login(index: self.$index)
                }
            }
        }
        .background(Color("Color2").edgesIgnoringSafeArea(.all))
    }
}

//Right
struct CShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
            path.move(to: CGPoint(x: rect.width, y:100 ))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x:0, y:rect.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
    }
    
}
//Left
struct CShape1 : Shape {
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
            path.move(to: CGPoint(x: 0, y:100 ))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y:rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
        }
    }
    
}


// Signup Page..


struct SignUp:View {
    @State var email = ""
    @State var pass = ""
    @State var Repass = ""
    @State var name = ""
    @Binding var index : Int
    @State var showAlert = false

    

    var body:some View{
        
        
                ZStack(alignment: .bottom){
                    
                    VStack{
                        HStack{
                            Spacer(minLength: 0)
                            
                            VStack(spacing : 10){
                                Text("Signup")
                                    .foregroundColor(self.index == 1 ? .white : .gray)
                                    .font(.title)
                                    .fontWeight(.bold)
                                Capsule()
                                    .fill(self.index == 1 ? Color.blue : Color.clear)
                                    .frame(width: 100, height: 5)
                            }
                        }
                        .padding(.top,30)
                        
                        VStack{
                            HStack(spacing:15){
                                Image(systemName: "person.fill")
                                    .foregroundColor(Color("Color4"))
                                
                                TextField("Username", text: self.$name).foregroundColor(Color.white).autocapitalization(.none).disableAutocorrection(true)
                            }
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top,40)
                        
                        VStack{
                            HStack(spacing:15){
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color("Color4"))
                                
                                TextField("Email Address", text: self.$email).foregroundColor(Color.white).autocapitalization(.none).disableAutocorrection(true)
                            }
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top,40)
                        
                        VStack{
                            HStack(spacing:15){
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(Color("Color4"))
                                
                                SecureField("Password", text: self.$pass).foregroundColor(Color.white)
                            }
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top,40)
                        
                        VStack{
                            HStack(spacing:15){
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(Color("Color4"))
                                
                                SecureField(" Confirm Password", text: self.$Repass).foregroundColor(Color.white)
                            }
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top,40)
                        
                        
                    }
                    .padding()
                    .padding(.bottom,65)
                    .background(Color("Color3"))
                    .clipShape(CShape1())
                    .contentShape(CShape1())
                    .onTapGesture {
                        self.index = 1
                    }
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
                    .cornerRadius(35)
                    .padding(.horizontal,20)
                    
                    Button(action:{
                        Register()
                    }){
                        Text("SIGNUP")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .padding(.horizontal,50)
                            .background(Color("Color4"))
                            .clipShape(Capsule())
                            .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                    }
                    .alert(isPresented: $showAlert){
                        Alert(title: Text("Register Success"))
                    }
                    .offset(y:25)
                    .opacity(self.index == 1 ? 1 : 0)
                    
                }
            
        
       
    }
    func Register(){
        if self.email != "" && self.name != ""{
            if self.pass == self.Repass{
                Auth.auth().createUser(withEmail: self.email, password: self.pass){
                    AuthDataResult,Error in
                    
                    if let error = Error {
                        return
                    }else{
                        print(self.email)
                        print(self.pass)
                        print("Success")
                        self.pass = ""
                        self.email = ""
                        self.Repass = ""
                    }
                    
                    let chagneRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    chagneRequest?.displayName = self.name
                    chagneRequest?.commitChanges { error in
                        print(error?.localizedDescription)
                    }
                }
                //Alert Password not match
            }
            //Alert email = nil
        }
        showAlert = true
    }
}


/// Login Page
///
struct login :View {
    @EnvironmentObject var dataModel : DataModel
    @State private var email : String = ""
    @State var passwod : String = ""
    @Binding var index : Int
    
   
    var body:some View{
        
        
            
            
                
                ZStack(alignment: .bottom){
                    
                    VStack{
                        HStack{
                            VStack(spacing: 10 ){
                                Text("Login")
                                    .foregroundColor(self.index == 0 ? .white: .gray)
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Capsule()
                                    .fill(self.index == 0 ? Color.blue : Color.clear)
                                    .frame(width: 100, height: 5)
                            }
                            
                            Spacer(minLength: 0)
                        }
                        .padding(.top,30)
                        
                        VStack{
                            HStack(spacing:15){
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color("Color4"))
                                
                                TextField("Email Address", text: $dataModel.user.email).autocapitalization(.none).foregroundColor(Color.white).disableAutocorrection(true)
                            }
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top,40)
                        
                        VStack{
                            HStack(spacing:15){
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(Color("Color4"))
                                
                                SecureField("Password", text: self.$dataModel.user.password).foregroundColor(Color.white)
                            }
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top,40)
                        
                        HStack{
                            Spacer(minLength:0)
                            
                            Button(action:{
                                reset()
                            }) {
                                Text("")
                                    .foregroundColor(Color.white.opacity(0.6))
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top,30)
                        
                        
                    }
                    .padding()
                    .padding(.bottom,65)
                    .background(Color("Color3"))
                    .clipShape(CShape())
                    .contentShape(CShape())
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
                    .onTapGesture {
                        self.index = 0
                    }
                    .cornerRadius(35)
                    .padding(.horizontal,20)
                    
                    Button(action:{
                        dataModel.Login()
                        self.email = ""
                        self.passwod = ""
                    }){
                        Text("LOGIN")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .padding(.horizontal,50)
                            .background(Color("Color4"))
                            .clipShape(Capsule())
                            .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                    }
                    .offset(y:25)
                    .opacity(self.index == 0 ? 1 : 0)
                    
                }
            
        
        
    }
    func reset(){
        print("reset")
        if self.email != "" {
            Auth.auth().sendPasswordReset(withEmail: self.email){
                (err) in
                if err != nil{
                    print(err?.localizedDescription)
                }else{
                    print("success")
                }
            }
            
        }
    }
}
