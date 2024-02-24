//
//  UserDetailView.swift
//  GitNetworkCall
//
//  Created by RAJPARA DHRUV on 2024-02-24.
//

import SwiftUI

struct UserDetailView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .frame(width: 53, height: 53)
            Text("Hello, world!")
                .bold()
                .font(.system(size: 30))
            Text("App will Show data here.The data will be fetched from Github")
                .padding()
        }
        .padding()
    }
}

#Preview {
    UserDetailView()
}
