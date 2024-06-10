//
//  AuthorizationViewModel.swift
//  Weeky
//
//  Created by Екатерина Кондратьева
//

import Foundation

class AuthorizationViewModel: ObservableObject
{
    @Published var name = ""
    @Published var password = ""
    @Published var error = ""

    
    @Published var authorizationManager =  AuthorizationManager()
    @Published var user: User?
    
    
    func login(completion: @escaping (Bool) -> Void) {
        print("LOGIN")
        print(name, password)
        
        authorizationManager.fetchAllUsers { users, error in
            if let error = error {
                print("Error fetching users: \(error)")
                completion(false) // Сообщаем об ошибке через замыкание
                return
            }
            
            guard let users = users else {
                print("No users found")
                completion(false) // Сообщаем, что пользователей нет
                return
            }
            
            let userExists = self.checkedUserExist(users)
            if userExists {
                completion(true)
            } else {
                completion(false)
              print("Пользователь не найден")
// Сообщаем, что пользователь не найден
            }
        }
    }
  func checkIfUsernameExists(completion: @escaping (Bool) -> Void) {
          // Получаем ссылку на коллекцию пользователей
          let usersRef = authorizationManager.db.collection("Users")
          
          // Создаем запрос для поиска пользователя с указанным именем
          let query = usersRef.whereField("name", isEqualTo: name)
          
          // Выполняем запрос и проверяем, существует ли пользователь
          query.getDocuments { snapshot, error in
              if let error = error {
                  print("Error getting users: \(error)")
                  completion(false)
                  return
              }
              
              guard let snapshot = snapshot else {
                  print("No snapshot returned")
                  completion(false)
                  return
              }
              
              // Если пользователь с таким именем не найден, возвращаем false
              if snapshot.documents.isEmpty {
                  completion(false)
                  return
              }
              
              // Если пользователь с таким именем найден, возвращаем true
              completion(true)
          }
      }

    func checkedUserExist(_ users: [User])->Bool {
        users.forEach({
            if $0.name == self.name && $0.password == self.password {
                self.user = $0
            } else {
              print("Пользователь не найден")
            }
        })
        return user != nil ? true : false
    }
  
    func validate()->Bool {
        if (name != "" && password != "") {
            error = ""
            return true
        } else {
            error = "Пустые поля"
            return false
        }
    }
    
  
    func eraseFields() {
        name = ""
        password = ""
    }
    
    func createAccount() {

        let newUser = User(name: name, password: password)
        let dataToUpload = newUser.toData()
        
        let usersRef = authorizationManager.db.collection("Users")
        
        //MARK: - can edit password/ if name is exist
        usersRef.document(newUser.name).setData(dataToUpload)
      
    }
    
}

