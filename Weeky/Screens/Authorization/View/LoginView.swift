//
//  LoginView.swift
//  Weeky
//
//  Created by Екатерина Кондратьева
//

import SwiftUI
import Firebase


struct Login : View {
    @EnvironmentObject var viewModel : AuthorizationViewModel
    @Binding var index : Int
    @Binding var isAuthorized: Bool
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    VStack(spacing: 10) {
                        Text("Вход")
                            .foregroundColor(self.index == 0 ? .white : .gray)
                            .font(Font.custom("Didot", size: 30))
                            .padding(.top, 10)
                        
                        Capsule()
                            .fill(self.index == 0 ? Color("Yellow light") : Color.clear)
                            .frame(width: 100, height: 5)
                    }
                    Spacer()
                }
                .padding(.top, 30)
                
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "person.fill")
                            .foregroundColor(Color("Orange light"))
                        TextField("Имя пользователя", text: $viewModel.name)
                        .font(Font.custom("Didot", size: 20))

                    }
                    
                    Divider().background(Color.white.opacity(0.8))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                
                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color("Orange light"))
                        SecureField("Пароль", text: $viewModel.password)
                        .font(Font.custom("Didot", size: 20))

                    }
                    
                    Divider()
                        .background(Color.white.opacity(0.8))
                }
                .padding(.horizontal)
                .padding(.top, 50)
            }
            .padding()
            .padding(.bottom, 70)
            .background(Color("Blue light"))
            .clipShape(CShape())
            .contentShape(CShape())
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
            .onTapGesture {
                self.index = 0
            }
            .cornerRadius(35)
            .padding(.horizontal, 20)
            
            LoginButton(isAuthorized: $isAuthorized)
                .opacity(self.index == 1 ? 0 : 1)
          
        }
        .onAppear(perform: {
            viewModel.eraseFields()
          // Проверяем существование пользователя при входе
                     viewModel.checkIfUsernameExists { exists in
                         if !exists {
                             // Если пользователя с таким именем не существует, выводим сообщение об ошибке
                             viewModel.error = "Пользователь с таким именем не найден"

                         } else {
                             viewModel.error = ""
                         }
                       
                     }
                 })

             }
         }

struct LoginButton: View {
    @Binding var isAuthorized: Bool
    @EnvironmentObject var authViewModel: AuthorizationViewModel
    var body: some View {
              Button(action: {
           
            //MARK: - login logic
            authViewModel.user = nil
            authViewModel.login { success in
                if success {
                  print("\(String(describing: authViewModel.user?.name)) logged in successfully")
                    withAnimation {
                        isAuthorized.toggle()
                    }
                }
                else {
                    print("user not found")
                }

            }
        }, label: {
            Text("Войти")
                .foregroundColor(Color("Gray"))
                .font(Font.custom("Didot", size: 18))
                .fontWeight(.bold)
                .padding(.vertical)
                .padding(.horizontal, 50)
                .background(Color("Yellow xlight"))
                .clipShape(Capsule())
                .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                .offset(y: 25)
        })
    }
}


struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            path.move(to: CGPoint(x: rect.width, y: 110))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
    }
}
