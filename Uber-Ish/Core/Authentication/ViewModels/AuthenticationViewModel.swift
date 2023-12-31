//
//  AuthenticationViewModel.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/14/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine

class AuthenticationViewModel: ObservableObject {
    enum AuthRequestState {
        case loading
        case success
        case error(AuthErrorCode.Code)
    }
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    private let userService = UserService.shared
    private var cancellables = Set<AnyCancellable>()
    
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
                self.fetchUser()
                completion(.success)
            }
        }
    }
    
    func signUp(fullName: String, email: String, password: String, completion: @escaping (AuthRequestState) -> Void) {
        completion(.loading)
        
        guard let location = LocationManager.shared.userLocation else {
            completion(.error(.internalError))
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError, let authError = AuthErrorCode.Code(rawValue: error.code) {
                completion(.error(authError))
                return
            }
            
            if let authResult = authResult {
                Task {
                    try await Task.sleep(for:.seconds(1))
                    
                    let user = User(
                        fullName: fullName,
                        email: email,
                        uid: authResult.user.uid,
                        coordinates: GeoPoint(latitude: location.latitude, longitude: location.longitude),
                        accountType: .passenger
                    )
                    
                    let encodedUser = try Firestore.Encoder().encode(user)
                    
                    try await Firestore.firestore().collection("users").document(authResult.user.uid).setData(encodedUser)
                    
                    DispatchQueue.main.async {
                        self.userSession = authResult.user
                        self.currentUser = user
                    }
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
        userService.$user
            .sink { user in
                self.currentUser = user
            }
            .store(in: &cancellables)
    }
}
