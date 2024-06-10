//
//  SettingsView.swift
//  Weeky
//
//  Created by Екатерина Кондратьева
//

import SwiftUI


struct SettingsView: View {
    @EnvironmentObject var viewModel : HomeViewModel
    
    @State private var notificationsOn = false
    @State private var language = false
    @State private var selectedDayIndex = 0
    @State private var isShowingAccountView = false

    
    @Binding var isAuthorized : Bool
    
    let daysOfWeek = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
  
    
    var body: some View {
        VStack {
            HeaderView()
            MainListView()
            LogoutButton()
        }
        .background(Colors.background)
    }
    
    //MARK: - Views
    func MainListView()->some View {
        ScrollView {
            VStack {
                AccountNavLink()
                
              CustomToggle(text: "Темная тема",binding: $viewModel.isDarkMode)
              .font(Font.custom("Didot", size: 20))

              
              CustomToggle(text: "Уведомления",binding: $notificationsOn)
              .font(Font.custom("Didot", size: 20))

              
              CustomToggle(text: "Изменить язык ru/en",binding: $isShowingAccountView)
              .font(Font.custom("Didot", size: 20))
              
                DatePickerView()
            }

            .background(Colors.backgroundList)
            .foregroundColor(Colors.textList)
            .cornerRadius(30)
            .padding()
        }
        .onChange(of: notificationsOn) { newValue in
            NotificationManager.shared.requestAuthorization()
        }
    }
    
    //MARK: - Views
    private func AccountNavLink()->some View {
        VStack {
            NavigationLink(destination: AccountView(isAuthorized: $isAuthorized)) {
                HStack {
                    Text("Аккаунт")
                    .font(Font.custom("Didot", size: 20))
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
            }
            .padding(20)
            Divider()
        }
    }
    
    private func HeaderView()->some View {
        HStack {
            Text("Настройки")
            .font(Font.custom("Didot", size: 36))
                .fontWeight(.bold)
                .foregroundColor(Colors.textHeader)
            Spacer()
            Image(systemName: "gearshape")
                .font(.title)
                .foregroundColor(Colors.textList)
        }
        .padding()
        .frame(width: 400, height: 60)
        .background(Colors.header)
    }
    
    private func LogoutButton()->some View {
        Button(action: {
            viewModel.currentUser = nil
            viewModel.storedTasks.removeAll()
            withAnimation {
                isAuthorized = false
            }
        }) {
            Text("Выйти из аккаунта")
            .font(Font.custom("Didot", size: 20))
                .foregroundColor(.red)
        }
    }
    
  private func CustomToggle(text: String, binding: Binding<Bool> )->some View {
      VStack {
          Toggle(isOn: binding) {
              Text(text)
          }
//            .listRowBackground(Colors.backgroundList)
          .toggleStyle(SwitchToggleStyle(tint: Color("Blue light")))
          .padding()
          Divider()
//                .background(Colors.dividerGray)
      }
  }
    
    private func DatePickerView()->some View {
        HStack {
            Text("День начала недели")
                .font(Font.custom("Didot", size: 20))
                .padding()
            Spacer()
            Picker(selection: $selectedDayIndex, label: Text("")) {
                ForEach(0..<daysOfWeek.count) { index in
                    Text(daysOfWeek[index])
                    .font(Font.custom("Didot", size: 16))

                }
            }
        }
        .padding(.vertical, 10)
    }
}


struct Previews: PreviewProvider {
    
    static var previews: some View {
        @State var show = true
        
        SettingsView(isAuthorized: $show)
    }
}
