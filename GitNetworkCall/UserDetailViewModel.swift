//
//  UserDetailViewModel.swift
//  GitNetworkCall
//
//  Created by RAJPARA DHRUV on 2024-02-24.
//

import Foundation

class UserDetailViewModel {
    
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

    private func getUser() async throws -> User {
        let endPoint = "https://api.github.com/users/rajparad/"
        
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
