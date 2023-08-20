//
//  AuthenticationViewModel.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/14/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthenticationViewModel: ObservableObject {
    enum AuthRequestState {
        case loading
        case success
        case error(AuthErrorCode.Code)
    }
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthenticationViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func signIn(email: String, password: String, completion: @escaping (AuthRequestState) -> Void) {
        completion(.loading)
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError, let authError = AuthErrorCode.Code(rawValue: error.code) {
                completion(.error(authError))
            }
            
            if let authResult = authResult {
                self.userSession = authResult.user
                completion(.success)
            }
        }
    }
    
    func signUp(fullName: String, email: String, password: String, completion: @escaping (AuthRequestState) -> Void) {
        completion(.loading)
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError, let authError = AuthErrorCode.Code(rawValue: error.code) {
                completion(.error(authError))
                return
            }
            
            if let authResult = authResult {
                Task {
                    try await Task.sleep(for:.seconds(1))
                    
                    let user = User(fullName: fullName, email: email, uid: authResult.user.uid)
                    
                    let encodedUser = try Firestore.Encoder().encode(user)
                    
                    try await Firestore.firestore().collection("users").document(authResult.user.uid).setData(encodedUser)
                    
                    DispatchQueue.main.async {
                        self.userSession = authResult.user
                    }
                    
                    self.fetchUser()
                }
            }
        }
    }
    
    func signOut(completion: @escaping (AuthRequestState) -> Void) {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            completion(.success)
        } catch {
            completion(.error(.internalError))
        }
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard
                let snapshot = snapshot,
                let user = try? snapshot.data(as: User.self)
            else { return }
            
            self.currentUser = user
        }
    }
}
