//
//  HomeView.swift
//  Weeky
//
//  Created by Екатерина Кондратьева
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var taskModel: HomeViewModel
    @Namespace var animation
    
    //MARK: - Navigation
    @Binding var isAuthorized: Bool
    @State private var isShowingSideMenu = false
    @State private var isCalendarViewShowed = false
    @State private var isShowingNewTaskView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                MainVStack()
                AddNewTaskButtonView()
            }
        }
    }
  
    
    //MARK: - Views
    private func MainVStack()->some View {
        VStack {
            HeaderView(isShowingSideMenu: $isShowingSideMenu, isCalendarViewShowed: $isCalendarViewShowed, isAuthorized: $isAuthorized)
                
            MainScrollView()
                .onAppear {
                    taskModel.currentDay = Date()
                }
        }
        .background(Color("Background").edgesIgnoringSafeArea(.all))
    }
    
    private func AddNewTaskButtonView()-> some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                AddNewTaskButton(isShowingNewTaskView: $isShowingNewTaskView)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: -5, y: 5)
                    .padding(20)
            }
        }
    }
    

    func MainScrollView()->some View {
        ScrollView(.vertical, showsIndicators: false) {
            WeekView()
            
            VStack(spacing: 5) {
                if let tasks = taskModel.filteredTasks {

                    if tasks.isEmpty{
                        Text("Задач не найдено")
                      .font(Font.custom("Didot", size: 20))
                      .fontWeight(.bold)

                    } else {
                        ForEach(tasks){ task in
                            TaskCardView(task: task)
                        }
                    }
                } else {
                    //Mark: Progress View
                    ProgressView()
                        .offset(y: 100)
                }
            }
            .onChange(of: taskModel.currentDay){ newValue in
                taskModel.filteringTodayTask()
//                taskModel.currentDay = Date()
            }
        }
    }
  
    
    
    func WeekView()->some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10){
//                guard let taskModel
                ForEach(taskModel.currentWeek,id: \.self){ day in
                    VStack(spacing: 5){
                        Text(taskModel.extractDate(date: day, format: "dd"))
                        .font(Font.custom("Didot", size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Colors.day)

                        
                        Text(taskModel.extractDate(date: day, format: "EEE"))
                        .font(Font.custom("Didot", size: 14))
                            .foregroundColor(Colors.day)

                        
                        Circle()
                            .fill(.white)
                            .frame(width: 8, height: 8)
                            .opacity(taskModel.isToday(date: day) ? 1 : 0)
                    }
                    .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)
                    .foregroundColor(taskModel.isToday(date: day) ? Colors.textHeader : Colors.textList)
                    .frame(width: 45, height: 90)
                    .background(
                        ZStack{
                            if taskModel.isToday(date: day){
                                Capsule()
                                    .fill(Colors.header)
                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)

                            }
                        })
                    .onTapGesture {
                        withAnimation{
                            taskModel.currentDay = day
                        }
                    }
                }
            }

            .padding()
        }
    }
    
    
}



