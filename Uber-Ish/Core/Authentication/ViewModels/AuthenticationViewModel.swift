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
    
    func signUp(fullName: String, email: String, password: String, completion: @escaping (AuthRequestState) -> Void) {
        completion(.loading)
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError, let authError = AuthErrorCode.Code(rawValue: error.code) {
                completion(.error(authError))
                return
            }
        }
    }
}
