//
//  User.swift
//  Weeky
//
//  Created by Екатерина Кондратьева
//

import Foundation
import Firebase
import FirebaseCore

struct User: Identifiable, Hashable, Codable {
    var id                  = UUID().uuidString
    var name: String        = ""
    var password: String    = ""
    
    var tasksRef: DocumentReference?
    
    func toData()->[String: Any] {
        let user: [String: Any] = [
            "id": self.id,
            "name": self.name,
            "password": self.password
            ]
        return user
    }
}
