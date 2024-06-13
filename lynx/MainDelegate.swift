//
//  MainDelegate.swift
//  lynx
//
//  Created by Arnav Wadehra on 6/17/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var courier = false
    @Published var appOn = false
    
    static let shared = MainViewModel()
    
    let auth = Auth.auth()
    
    init() {
        userSession = auth.currentUser
        fetchUser()
        fetchMaster()
//        self.appOn =
    }
   
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    
    
    func fetchMaster() {
        let query = Firestore.firestore().collection("master").document("BwyNwr47jXKwbjIJNYiV").addSnapshotListener { documentSnapshot, error in
            let app = try? documentSnapshot?.data(as: ApplicationModel.self)
            if let appCheck = app {
                self.appOn = appCheck.app
                print("switched")
            }
        }
        }

    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            guard let user = result?.user else { return }
            self?.userSession = user
            self?.fetchUser()
        }
    }
    
    func signUp(email: String, password: String, phonenumber: String, firstname: String, lastname: String, gender: String, classyear: String) {
        self.auth.createUser(withEmail: email, password: password) { result, error in
        guard result != nil, error == nil else {
            return
        }
            if let thecurrentuser = result {
                let data = ["email": email,
                            "phonenumber": phonenumber,
                            "firstname": firstname,
                            "lastname": lastname,
                            "gender": gender,
                            "classyear": classyear,
                            "balance": 0,
                            "courierBalance": 0,
                            "venmo": ""
                ] as [String : Any]
            Firestore.firestore().collection("users").document(thecurrentuser.user.uid).setData(data)
            
                        guard let user = result?.user else { return }
                        self.userSession = user
                        self.fetchUser()
            }
        }
    }
        
    func signOut() {
        self.userSession = nil
        try? auth.signOut()
        self.currentUser = nil 
            
        }

    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        let query = Firestore.firestore().collection("users").document(uid).addSnapshotListener {  documentSnapshot, error in
            let user = try? documentSnapshot?.data(as: User.self)
            if let User = user {
                self.currentUser = User
            }
        }
    }
            
            

    
    func resetPassword(withEmail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Failed to send link with error \(error.localizedDescription)")
                return
            }
            print("Sent link")
        }
    }
    
    func saveVenmo(venmo: String) {
        guard let uid = MainViewModel.shared.currentUser?.id else { return }
        Firestore.firestore().collection("users").document(uid).updateData(["venmo": venmo])
        fetchUser()
    }
    
    func withdrawBalance() {
        let uid = self.currentUser?.id
        let courierBalance = self.currentUser?.courierBalance
        Firestore.firestore().collection("users").document(uid!).updateData(["courierBalance": 0])
        
        let data = ["userID": self.currentUser?.id,
                    "venmo": self.currentUser?.venmo,
                    "courierAmount": courierBalance
                    ] as [String: Any]
        fetchUser()
        Firestore.firestore().collection("courierPayout").addDocument(data: data)
    }
    
    func deleteAccount() {
        guard let uid = userSession?.uid else {return}
        Firestore.firestore().collection("users").document(uid).delete()
        Auth.auth().currentUser?.delete { error in
            guard let uid = self.userSession?.uid else {return}
            Firestore.firestore().collection("users").document(uid).delete()
            
        }
        
        self.currentUser = nil
        self.userSession = nil
    }
    
    
//    func changeMode() {
//        guard let uid = userSession?.uid else {return}
//        Firestore.firestore().collection("users").document(uid).updateData(["":])
//    }
}



