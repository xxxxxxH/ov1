//
//  ComplexView.swift
//  SmartVPN
//
//  Created by xxxxxxh on 2024/8/1.
//

import SwiftUI
import Combine

struct ComplexView: View {
    @State private var counter = 0
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var data: [String] = []
    @StateObject private var viewModel = ComplexViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text("")
                    .font(.title)
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(10)
                
                Button(action: incrementCounter) {
                    Text("")
                        .font(.headline)
                        .padding()
                        .background(Color.clear)
                        .foregroundColor(.clear)
                        .cornerRadius(10)
                }
                
                Button(action: toggleLoading) {
                    Text("")
                        .font(.headline)
                        .padding()
                        .background(Color.clear)
                        .foregroundColor(.clear)
                        .cornerRadius(10)
                }
                
            
                
                List(data, id: \.self) { item in
                    Text(item)
                        .padding()
                }
                
                Button(action: fetchData) {
                    Text("")
                        .font(.headline)
                        .padding()
                        .background(Color.clear)
                        .foregroundColor(.clear)
                        .cornerRadius(10)
                }
                
                
                Spacer()
            }
            .onAppear {
                print("ComplexView appeared")
            }
        }
    }
    
    private func incrementCounter() {
        counter += 1
        viewModel.updateValue(counter)
    }
    
    private func toggleLoading() {
        isLoading.toggle()
        if isLoading {
            viewModel.startLoading()
        } else {
            viewModel.stopLoading()
        }
    }
    
    private func fetchData() {
        viewModel.loadData { newData in
            self.data = newData
            showAlert = true
        }
    }
}

class ComplexViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    func updateValue(_ value: Int) {
        print("Value updated to \(value)")
    }
    
    func startLoading() {
        print("Loading started")
    }
    
    func stopLoading() {
        print("Loading stopped")
    }
    
    func loadData(completion: @escaping ([String]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let sampleData = ["Item 1", "Item 2", "Item 3"]
            DispatchQueue.main.async {
                completion(sampleData)
            }
        }
    }
}

