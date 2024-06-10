//
//  TaskCardView.swift
//  Weeky
//
//  Created by Екатерина Кондратьева
//

import SwiftUI

struct TaskCardView: View {
    @EnvironmentObject var viewModel : HomeViewModel
    @State var task: Task
    @State var isEditing: Bool = false
    
    var body: some View {
        HStack {
            TaskCell()
            Spacer()
            ButtonsHStack()
        }
        .foregroundColor(Colors.textHeader)
        .padding()
    }
    
    //MARK: - Views
    func TaskCell()->some View {
        HStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color(task.colorName))
                .frame(width: 10, height: 30)
                .padding(.top, 5)
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.title2)
                
                if let date = task.dateString.toDate() {
                    Text("\(date.showOnlyTimeString())")
                        .font(.subheadline)
                        .foregroundColor(Colors.blueDarkReverse)
                }
            }
        }
    }
    
    func ButtonsHStack()->some View {
        VStack {
            HStack(spacing: 15) {
                Button(action: {
                    withAnimation {
                        task.isCompleted.toggle()
                        viewModel.firebaseManager.markTaskAsCompleted(task, completion: {_ in })
                        viewModel.fetchAllData()
                    }
                }) {
                    Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                        .font(.title)
                }
                Button(action: {
                    withAnimation {
                        isEditing.toggle()
                    }
                }) {
                    Image(systemName: "pencil")
                        .font(.title)
                        .foregroundColor(Colors.blueDarkReverse)
                }
                if isEditing {
                    Button(action: {
                        withAnimation {
                            viewModel.deleteTask(task)
                        }
                    }) {
                        Image(systemName: "trash")
                            .font(.title3)
                            .foregroundColor(.red)
                    }
                }
            }
            Spacer()
        }
    }
}
