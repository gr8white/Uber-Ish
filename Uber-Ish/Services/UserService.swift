//
//  UserService.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/22/23.
//

import Firebase

class UserService: ObservableObject {
    @Published var user: User?
    
    static let shared = UserService()
    
    init() {
        fetchUser()
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard
                let snapshot = snapshot,
                let user = try? snapshot.data(as: User.self)
            else { return }
            
            self.user = user
        }
    }
}
