//
//  UserDetailView.swift
//  GitNetworkCall
//
//  Created by RAJPARA DHRUV on 2024-02-24.
//

import SwiftUI

struct UserDetailView: View {

    @StateObject var viewModel = UserDetailViewModel()

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.user?.avatarUrl ?? "")) { image in
                image
                    .image?.resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.circle)
            }
            .frame(width: 73, height: 73)
            Text(viewModel.user?.login ?? "")
                .bold()
                .font(.system(size: 30))
            Text(viewModel.user?.bio ?? "")
                .padding()
        }
        .padding()
        .onAppear {
            viewModel.viewDidAppear()
        }
    }
}

