//
//  AutorizationManager.swift
//  Weeky
//
//  Created by Екатерина Кондратьева 
//

import SwiftUI
import Firebase
import FirebaseCore

class AuthorizationManager: ObservableObject {
    let db = Firestore.firestore()
    
    func fetchAllUsers(completion: @escaping ([User]?, Error?) -> Void) {
        db.collectionGroup("Users").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                var users = [User]()
                for document in querySnapshot!.documents {
                    let userData = document.data()
                    
                    users.append(self.constructUser(from: userData))
                }
                completion(users, nil)
            }
        }
    }
    
    
    //MARK: - helpers
    func constructUser(from userData: [String : Any]) -> User {
        User(id: userData["id"] as? String ?? "", name: userData["name"] as? String ?? "", password: userData["password"] as? String ?? "", tasksRef: userData["tasksRef"] as? DocumentReference)
        
    }
}

