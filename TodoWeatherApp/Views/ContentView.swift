//
//  ContentView.swift
//  TodoWeatherApp
//
//  Created by Marco Mascorro on 12/11/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationmanager = LocationManager()
    @StateObject private var weathermanager = WeatherManager.shared
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    
    @Namespace var animation
    var body: some View {
        ZStack {
            Color("grey").ignoresSafeArea()
            VStack {
                if let model = weathermanager.model {
                    VStack(alignment:.leading) {
                        Text("Todays weather")
                            .font(.caption)
                            .fontWeight(.thin)
                        WeatherView(model: model)
                    }
                    .padding(.horizontal)
                    
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 28) {
                        ForEach(taskModel.currentWeek, id: \.self){ day in
                            
                            VStack {
                                Text(taskModel.extractDate(date: day, format: "MMM"))
                                    .font(.system(size: 18))
                                    .fontWeight(.regular)
                                
                                Text(taskModel.extractDate(date: day, format: "dd"))
                                    .font(.system(size: 18))
                                    .fontWeight(.regular)
                                
                                // EEE will return day as MON,TUE,....etc
                                Text(taskModel.extractDate(date: day, format: "EEE"))
                                    .font(.system(size: 18))
                                
                            }
                            .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)
                            .foregroundColor(taskModel.isToday(date: day) ? .white : .gray)
                            .onTapGesture {
                                // Updating Current Day
                                withAnimation{
                                    taskModel.currentDay = day
                                }
                            }
                            
                            
                        }
                    }
                    
                }
                .padding(.horizontal)
                
                
                ScrollView(.vertical, showsIndicators: false){
                    TaskView()
                        .padding()
                }
                
                
                
            }
            
        }
        .sheet(isPresented: $taskModel.addNewTask, content: {
            NewTaskView()
                .environmentObject(taskModel)
        })
        .onAppear{
            if locationmanager.requestLocation() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.linear) {
                        getWeatherData()
                    }
                    
                    print("Weather")
                }
            }
            
        }
        .navigationTitle("To Do")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    taskModel.addNewTask.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                
            }
        }
        
        
    }
    
    func getWeatherData(){
        if let location = locationmanager.location {
            withAnimation {
                weathermanager.fetchWeather(location)
            }
            
        }
    }
    
    @ViewBuilder
    func TaskView() -> some View {
        LazyVStack(spacing: 20){
            DynamicFilteredView(dateToFilter: taskModel.currentDay) { (object: Task) in
                TaskViewCell(task: object)
            }
            
        }
    }
    
    @ViewBuilder
    func TaskViewCell(task: Task) -> some View {
        if taskModel.isCurrentHour(date: task.taskDate ?? Date()){
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text(task.taskDate?.formatted(date: .omitted, time: .shortened) ?? "")
                            .fontWeight(.thin)
                        Text("HAPPENING NOW")
                            .font(.caption)
                            .fontWeight(.thin)
                    }
                    
                    
                    HStack(spacing: 1) {
                        Text("\(task.taskTitle?.capitalized ?? ""):" )
                            .fontWeight(.bold)
                        Text("\(task.taskDescription?.capitalized ?? "")." )
                            .fontWeight(.thin)
                    }
                    
                }
            }
        } else {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(task.taskDate?.formatted(date: .omitted, time: .shortened) ?? "")
                        .fontWeight(.thin)
                    
                    HStack(spacing: 3) {
                        Text("\(task.taskTitle?.capitalized ?? ""):" )
                            .fontWeight(.bold)
                        Text("\(task.taskDescription?.capitalized ?? "")." )
                            .fontWeight(.thin)
                    }
                    
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
