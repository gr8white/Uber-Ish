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
    
    static let shared = AuthenticationViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
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
                self.userSession = authResult.user
                completion(.success)
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
}
