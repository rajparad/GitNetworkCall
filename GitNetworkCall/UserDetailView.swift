//
//  UserDetailView.swift
//  GitNetworkCall
//
//  Created by RAJPARA DHRUV on 2024-02-24.
//

import SwiftUI

struct UserDetailView: View {
    
    @StateObject var viewModel = UserDetailViewModel()
    @State var username: String = ""
    
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.circle)
            } placeholder: {
                Circle()
                    .foregroundColor(.gray)
            }
            .frame(width: 73, height: 73)
            Text(viewModel.user?.login ?? "")
                .bold()
                .font(.system(size: 30))
            Text(viewModel.user?.bio ?? "")
                .padding()
            
            
            TextField("Username", text: $username)
                .border(.black, width: 1)
                .frame(height: 23)
                .padding()
            
            Button(action: {
                viewModel.isLoading = true
                viewModel.viewDidAppear(username: username)
                
            }) {
                Text("Get Data")
                    .padding()
            }
            .background(Color.blue)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .cornerRadius(23)
        }
        .onAppear {
            viewModel.viewDidAppear(username: "twostraws")
        }
        .overlay(loaderView())
    }
    
    @ViewBuilder
    private func loaderView() -> some View {
        if viewModel.isLoading {
            ZStack {
                ProgressView(label: {
                    Text("Loading..")
                        .font(.system(size: 20))
                        .frame(width: 100)
                })
                .tint(.blue)
                .frame(width: 150, height: 100)
                .background(.thinMaterial)
            }
        }
    }
}

