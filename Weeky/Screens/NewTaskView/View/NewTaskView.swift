//
//  NewTaskView.swift
//  Weeky
//
//  Created by Екатерина Кондратьева
//

import SwiftUI

struct NewTaskView: View {
    @Binding var dateFromCalendar: Date
    @State private var task = Task()
    @State private var taskColor: Color = Color("Blue xlight")
    @EnvironmentObject var viewModel : HomeViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: - set my Colors
    let availableColors: [Color] = [Color("Blue dark"), Color("Blue light"), Color("Orange dark"), Color("Orange light"), Color("Yellow dark"), Color("Yellow light")]
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            backToHomeView()
                        }, label: {
                            Image(systemName: "x.circle")
                                .font(.system(size: 24))
                        })
                    }
                }
                //            Spacer()
                
                Text("Создать задачу")
                .fontWeight(.bold)
                .padding(.bottom, 30)
                .font(Font.custom("Didot", size: 32))

              //MARK: - color picker
              CustomColorPicker(selectedColor: $taskColor, colors: availableColors)
                  .padding(.bottom, 20)
                
                DatePickerView()
                
              TextField("Описание задачи", text: $task.title)
                  .font(Font.custom("Didot", size: 22))
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                  .padding(.bottom, 20)

                
                Button(action: {
                    task.dateString = dateFromCalendar.toString()
                    task.colorName = taskColor.description.extractedName
                    print(taskColor.description.extractedName)
                    if viewModel.taskAdded(task) {
                        backToHomeView()
                    }
                }, label: {
                    Text("Сохранить")
                    .padding()
                    .font(Font.custom("Didot", size: 24))
                    .frame(maxWidth: .infinity)
                    .background(Colors.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: -5, y: 5)
                })
            }
            .padding()
        }
        .frame(maxHeight: .infinity)
        .background(Color("Background").ignoresSafeArea(.all))
        .foregroundColor(Colors.textHeader)
        
    }
    
    func backToHomeView() {
        withAnimation(.smooth) {
            viewModel.backTodayIfNeeded()
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func DatePickerView()->some View {
        DatePicker("Выбор даты", selection: $dateFromCalendar, displayedComponents: [.date, .hourAndMinute])
            .font(Font.custom("Didot", size: 20))
            .padding(.bottom, 20)
            .accentColor(Colors.textList)
    }
}

struct CustomColorPicker: View {
    @Binding var selectedColor: Color
        let colors: [Color]
        
        var body: some View {
            HStack {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Circle()
                                .stroke(Colors.textHeader, lineWidth: selectedColor == color ? 3 : 0)
                        )
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }

        }
}
