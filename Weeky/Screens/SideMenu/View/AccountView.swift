//
//  AccountView.swift
//  Weeky
//
//  Created by Екатерина Кондратьева
//

import SwiftUI

struct AccountView:View {
    @EnvironmentObject var viewModel : HomeViewModel
    @State private var isShowingSuccessView = false
    
    @State private var name = ""
    @State private var password = ""
    
    @Binding var isAuthorized : Bool
    @State private var error = "Пустые поля"
    
    var body: some View {
        VStack {
            ChangeUserData()
        }
    }
    
    //MARK: - Views
    func ChangeUserData()->some View {
        VStack {
            HeaderView()
            ChangePasswordView()
            AcceptButton()
            
            Button(action: {
                viewModel.currentUser = nil
                withAnimation {
                    isAuthorized = false
                }
            }) {
                Text("Выйти из аккаунта")
                    .font(Font.custom("Didot", size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.red)

            }
            .padding()
            Spacer()
        }
        .background(Colors.background)
    }
    
    func HeaderView()->some View {
        VStack {
            Image(systemName: "person")
                .resizable()
                .frame(width: 50, height: 50)
            
            Text(viewModel.currentUser?.name ?? "")
                .font(Font.custom("Didot", size: 30))


        }
        .padding(.bottom)
        .frame(width: 400, height: 130)
        .background(Colors.header)
        .foregroundColor(Colors.textHeader)
    }
    
    func ChangePasswordView()->some View {
        VStack {
            
            HStack(spacing: 15) {
                    Image(systemName: "eye.slash.fill")
                    .foregroundColor(Colors.gray)
                    SecureField("Изменить пароль", text: $password)
                .font(Font.custom("Didot", size: 20))

              

                }

                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("Orange dark"))
                        .frame(height: 70)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: -5, y: 5)
                )
                .offset(y: 10)
                .padding()
        }
    }
    
    func AcceptButton()->some View {
        VStack {
            if !isShowingSuccessView {
                Button(action: {
                    if name != "" || password != "" {
                        //MARK: - update Data
                        viewModel.updatePassword( password)
                        error = ""
                        withAnimation {
                            isShowingSuccessView = true
                            name = ""
                            password = ""
                        }
                    }
                    isShowingSuccessView = true
                }, label: {
                    Text("Внести изменения")
                    .font(Font.custom("Didot", size: 20))
                        .foregroundColor(.gray)
                        .fontWeight(.medium)
                        .padding()
                        .clipShape(Capsule())
                        .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                        .offset(y: 25)
                })
            } else {
                SuccessView(text: "Данные изменены", error: error)
                .font(Font.custom("Didot", size: 20))

                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                isShowingSuccessView = false
                            }
                        }
                    }
            }
        }
    }
}

struct Previews_AccountView: PreviewProvider {
    
    static var previews: some View {
        @State var show = true
        
        AccountView(isAuthorized: $show)
    }
}
