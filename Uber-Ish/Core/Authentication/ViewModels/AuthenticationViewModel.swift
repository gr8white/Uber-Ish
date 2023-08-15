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
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthenticationViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
    }
    
}
