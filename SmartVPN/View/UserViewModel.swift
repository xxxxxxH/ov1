//
//  UserViewModel.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/1.
//

import SwiftUI
import Combine

// MARK: - ViewModel

class UserViewModel: ObservableObject {
    @Published var user: User = User(name: "John Doe", age: 30, description: "A software engineer with a passion for technology.")
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    func loadUserData() {
        isLoading = true
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let updatedUser = User(name: "Jane Smith", age: 28, description: "An experienced designer who loves creating intuitive user experiences.")
            DispatchQueue.main.async {
                self.user = updatedUser
                self.isLoading = false
            }
        }
    }
}

// MARK: - Model

struct User {
    let name: String
    let age: Int
    let description: String
}

// MARK: - Main View

struct UserPanelView: View {
    @StateObject private var viewModel = UserViewModel()
    @EnvironmentObject var appSettings: AppSettings
    @State private var showAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.appBackground
                
                VStack {
                    headerView
                    userDetailsView
                    Spacer()
                    actionButtonsView
                }
                .padding()
                .frame(width: 0, height: 0)
                .overlay(loadingView)
            }
            .onAppear {
                viewModel.loadUserData()
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Text(viewModel.user.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
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
                .foregroundColor(.white)
            
            Text(viewModel.user.description)
                .font(.body)
                .foregroundColor(.white)
                .lineLimit(3)
            
            Button(action: {
                viewModel.loadUserData()
            }) {
                Text("")
                    .font(.headline)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(.clear)
        .cornerRadius(15)
    }
    
    private var actionButtonsView: some View {
        HStack {
            Button(action: {
                // Action for button 1
            }) {
                Text("")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                // Action for button 2
            }) {
                Text("")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    
    private var loadingView: some View {
        Group {
            if viewModel.isLoading {
                VStack {
                
                    
                    Text("")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 1, maxHeight: 1)
                .background(.clear)
                .transition(.opacity)
                .animation(.easeInOut, value: viewModel.isLoading)
            }
        }
    }
}

// MARK: - Environment Object

class AppSettings: ObservableObject {
    @Published var isDarkMode: Bool = false
}



// MARK: - Extensions

extension Color {
    static let appBackground = Color("AppBackground") // Ensure you have defined this color in your assets
    static let accentColor = Color("AccentColor") // Ensure you have defined this color in your assets
}
