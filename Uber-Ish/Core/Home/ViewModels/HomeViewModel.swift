//
//  HomeViewModel.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/22/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class HomeViewModel: ObservableObject {
    init() {
        fetchDrivers()
    }
    
    func fetchDrivers () {
        Firestore.firestore().collection("users")
            .whereField("accountType", isEqualTo: AccountType.driver.rawValue)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let drivers = documents.map({ try? $0.data(as: User.self)})
                
                print("here", drivers)
            }
    }
}
