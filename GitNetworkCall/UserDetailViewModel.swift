//
//  UserDetailViewModel.swift
//  GitNetworkCall
//
//  Created by RAJPARA DHRUV on 2024-02-24.
//

import Foundation

@MainActor class UserDetailViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var isLoading: Bool = true
    
    init(user: User? = nil) {
        self.user = user
    }
    
    func viewDidAppear(username: String) {
        Task {
            do {
                try await Task.sleep(nanoseconds: 4000000000)
                user = try await getUser(username: username)
                isLoading = false
            } catch GithubError.invalidData {
                isLoading = false
                print("Data is Invalid")
            } catch GithubError.invalidResponse {
                isLoading = false
                print("Response is Invalid")
            } catch GithubError.invalidURL {
                isLoading = false
                print("URL is Invalid")
            }
        }
    }
    private func getUser(username: String) async throws -> User {
        let endPoint = "https://api.github.com/users/\(username)"
        
        guard let url = URL(string: endPoint) else {
            throw GithubError.invalidURL
        }
        
        let(data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GithubError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(User.self, from: data)
        } catch {
            throw GithubError.invalidData
        }
    }
}

enum GithubError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct User: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
}

