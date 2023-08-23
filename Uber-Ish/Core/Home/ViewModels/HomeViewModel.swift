//
//  HomeViewModel.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/22/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine

class HomeViewModel: ObservableObject {
    @Published var drivers: [User] = []
    @Published var currentUser: User?
    
    private let userService = UserService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchUser()
    }
    
    func fetchDrivers () {
        Firestore.firestore().collection("users")
            .whereField("accountType", isEqualTo: AccountType.driver.rawValue)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let drivers = documents.compactMap({ try? $0.data(as: User.self)})
                
                self.drivers = drivers
            }
    }
    
    func fetchUser() {
        userService.$user
            .sink { user in
                guard let user = user else { return }
                self.currentUser = user
                guard user.accountType == .passenger else { return }
                self.fetchDrivers()
            }
            .store(in: &cancellables)
        
    }
}
