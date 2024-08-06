//
//  AdvancedViewModel.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/1.
//

import SwiftUI
import Combine

// MARK: - ViewModel

class AdvancedViewModel: ObservableObject {
    @Published var user: User1 = User1(name: "John Doe", age: 30, description: "A software engineer with a passion for technology.")
    @Published var isLoading: Bool = false
    @Published var chartData: [Double] = [20, 30, 40, 50, 60]
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadInitialData()
    }
    
    func loadInitialData() {
        isLoading = true
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let updatedUser = User1(name: "Jane Smith", age: 28, description: "An experienced designer who loves creating intuitive user experiences.")
            DispatchQueue.main.async {
                self.user = updatedUser
                self.isLoading = false
            }
        }
    }
    
    func fetchChartData() {
        isLoading = true
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let newData = [Double.random(in: 10...70), Double.random(in: 10...70), Double.random(in: 10...70), Double.random(in: 10...70), Double.random(in: 10...70)]
            DispatchQueue.main.async {
                self.chartData = newData
                self.isLoading = false
            }
        }
    }
}

// MARK: - Model

struct User1 {
    let name: String
    let age: Int
    let description: String
}

// MARK: - Main View

struct AdvancedUserPanelView: View {
    @StateObject private var viewModel = AdvancedViewModel()
    @State private var showAlert = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundView
                
                VStack {
                    headerView
                    userDetailsView
                    chartView
                    actionButtonsView
                    Spacer()
                }
                .padding()
                .frame(width: 0, height: 0)
                .overlay(loadingView)
                .animation(.easeInOut, value: viewModel.isLoading)
            }.background(.clear)
        }
    }
    
    private var backgroundView: some View {
        Color(colorScheme == .dark ? .black : .clear)
            .edgesIgnoringSafeArea(.all)
            
    }
    
    private var headerView: some View {
        HStack {
            Text(viewModel.user.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.clear)
            
            Spacer()
            
            Button(action: {
                showAlert.toggle()
            }) {
                Text("")
            }

        }
    }
    
    private var userDetailsView: some View {
        VStack(alignment: .leading) {
            Text("Age: \(viewModel.user.age)")
                .font(.title2)
                .foregroundColor(.clear)
            
            Text(viewModel.user.description)
                .font(.body)
                .foregroundColor(.clear)
                .lineLimit(3)
                .padding(.bottom, 10)
            
            Button(action: {
                viewModel.fetchChartData()
            }) {
                Text("")
                    .font(.headline)
                    .padding()
                    .background(Color.clear)
                    .foregroundColor(.clear)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(.clear)
        .cornerRadius(15)
    }
    
    private var chartView: some View {
        VStack {
            Text("")
                .font(.headline)
                .foregroundColor(.clear)
            
            LineChartView(data: viewModel.chartData)
                .frame(height: 200)
                .padding()
        }
        .background(.clear)
        .cornerRadius(15)
    }
    
    private var actionButtonsView: some View {
        HStack {
            Button(action: {
                // Action for button 1
            }) {
                Text("Action 1")
                    .padding()
                    .background(Color.clear)
                    .foregroundColor(.clear)
                    .cornerRadius(10)
            }
            
            Button(action: {
                // Action for button 2
            }) {
                Text("Action 2")
                    .padding()
                    .background(Color.clear)
                    .foregroundColor(.clear)
                    .cornerRadius(10)
            }
        }
        .padding(.top, 10)
    }
    
    private var loadingView: some View {
        Group {
            if viewModel.isLoading {
                VStack {
                    
                    
                    Text("")
                        .foregroundColor(.clear)
                }
                .frame(maxWidth: 1, maxHeight: 1)
                .background(.clear)
                .transition(.opacity)
            }
        }
    }
}

// MARK: - LineChartView (Custom View)

struct LineChartView: View {
    var data: [Double]
    
    private let lineWidth: CGFloat = 2.0
    private let chartPadding: CGFloat = 20.0
    
    var body: some View {
        GeometryReader { geometry in
            let path = Path { path in
                guard let firstPoint = data.first else { return }
                let maxY = data.max() ?? firstPoint
                let minY = data.min() ?? firstPoint
                let height = geometry.size.height
                let width = geometry.size.width
                let scale = height / CGFloat(maxY - minY)
                
                path.move(to: CGPoint(x: 0, y: height - CGFloat((firstPoint - minY) * scale)))
                
                for index in data.indices {
                    let x = width * CGFloat(index) / CGFloat(data.count - 1)
                    let y = height - CGFloat((data[index] - minY) * scale)
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            
            path.stroke(Color.clear, lineWidth: lineWidth)
                .padding(chartPadding)
        }
    }
}


// MARK: - Environment Object

class AppSettings1: ObservableObject {
    @Published var isDarkMode: Bool = false
}
