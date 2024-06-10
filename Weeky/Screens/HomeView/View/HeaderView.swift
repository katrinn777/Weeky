//
//  HeaderView.swift
//  Weeky
//
//  Created by Екатерина Кондратьева
//

import SwiftUI

struct HeaderView: View {
    @Binding var isShowingSideMenu: Bool
    @Binding var isCalendarViewShowed: Bool
    @Binding var isAuthorized: Bool
    
    var body: some View {
        HStack(spacing: 10){
            ShowSideMenuButton(isShowingSideMenu: $isShowingSideMenu, isAuthorized: $isAuthorized)
                .onTapGesture {
                    withAnimation {
                        isShowingSideMenu = true
                    }
                }
            Spacer()
            DateTitleView()
            Spacer()
            ShowCalendarButton(isCalendarViewShowed: $isCalendarViewShowed)
        }
        .padding()
        .background(Color("Header").edgesIgnoringSafeArea(.all))
        .foregroundColor(Colors.textHeader)
    }
}


struct DateTitleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(Date().formatted(date: .abbreviated, time: .omitted)).font(.title3)
        }
    }
}

struct ShowCalendarButton: View {
    @State var date = Date()
    @Binding var isCalendarViewShowed: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                isCalendarViewShowed.toggle()
            }
        }, label: {
            Image(systemName: "calendar")
          
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
        })
        .sheet(isPresented: $isCalendarViewShowed, content: {
            CalendarView(isCalendarViewShowed: $isCalendarViewShowed)
        })
    }
}


struct ShowSideMenuButton: View {
    @Binding var isShowingSideMenu : Bool
    @Binding var isAuthorized : Bool
    
    var body: some View {
        NavigationLink(destination: SettingsView(isAuthorized: $isAuthorized).transition(.scale), label: {
            Image(systemName: "list.bullet")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
        })
    }
}


