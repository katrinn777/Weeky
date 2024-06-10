//
//  AuthorizationView.swift
//  Weeky
//
//  Created by Екатерина Кондратьева
//

import SwiftUI

struct AuthorizationView: View {
    @EnvironmentObject var authViewModel : AuthorizationViewModel
    
    @State private var isShowingDetailsView = false
    
    @State var index = 0
    @Binding var isAuthorized: Bool
    
    var body: some View {
        GeometryReader { _ in
          VStack {
              Text("Weeky")
                  .foregroundColor(Colors.blueDarkReverse)
                  .font(Font.custom("Didot", size: 60))
                  .fontWeight(.bold)
              ZStack {
                  SignUpView(index: self.$index)
                      .zIndex(Double(self.index))
                  Login(index: $index, isAuthorized: $isAuthorized)
              }
                .environmentObject(authViewModel)
            }
            .offset(y: 50)
        }
        .background(Color("Background").edgesIgnoringSafeArea(.all))
        
    }
}

