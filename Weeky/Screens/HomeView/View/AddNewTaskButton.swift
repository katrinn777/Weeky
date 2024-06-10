//
//  AddNewTaskButton.swift
//  Weeky
//
//  Created by Екатерина Кондратьева
//

import SwiftUI

struct AddNewTaskButton: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Binding var isShowingNewTaskView: Bool
    
    var body: some View {
        Button {
            isShowingNewTaskView.toggle()
        } label: {
            Label { Text("") } icon: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .frame(width: 90, height: 90)
                    .background(Color("Yellow light"))
                    .clipShape(Circle())
            }
            .sheet(isPresented: $isShowingNewTaskView, content: {
                NewTaskView(dateFromCalendar: $viewModel.currentDay)
            })
        }
    }
}

//#Preview {
//    AddNewTaskButton(isShowingNewTaskView: isShowingNewTaskView)
//}
