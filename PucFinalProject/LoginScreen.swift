//
//  LoginScreen.swift
//  PucFinalProject
//
//  Created by Octavio Lemgruber Portugal on 04/10/23.
//

import SwiftUI
import Firebase
import CoreData

struct LoginScreen: View {
    @StateObject var dataManager = DataManager()
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var path = NavigationPath()
    
    var body: some View{
        NavigationStack (path: $path){
            Group{
                TextField("E-mail", text: $email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.done)
            }
            .textFieldStyle(.roundedBorder)
            .overlay{
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 2)
            }
            .padding(.horizontal)
            
            HStack {
                Button {
                    register()
                } label: {
                    Text("Sign Up")
                }
                .padding(.trailing)
                
                Button {
                    login()
                } label: {
                    Text("Login")
                }
                .padding(.leading)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(.blue))
            .font(.title2)
            .padding(.top)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: String.self) { view in
                if view == "ListView" {
                    CreaturesListView()
                }
            }
        }
        .onAppear{
            if Auth.auth().currentUser != nil {
                print("Login successfully")
                path.append("ListView")
            }
        }
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("Ok", role: .cancel) {}
        }
    }
    
    func register(){
        Auth.auth().createUser(withEmail: email, password: password){ result, error in
            if let error = error {
                print("SIGN UP ERROR: \(error.localizedDescription)")
                alertMessage = "SIGN UP ERROR: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("Registration Success")
                path.append("ListView")
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("LOGIN ERROR: \(error.localizedDescription)")
                alertMessage = "LOGIN ERROR: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("Login successfully")
                path.append("ListView")
            }
        }
    }
}


struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

