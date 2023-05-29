//
//  URLSession+Ext.swift
//  LibOfMoviesNetwork
//
//  Created by Wojciech Kulas on 29/05/2023.
//

import Foundation

public extension URLSession {
    public func data(from url: URL) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation{ continuation in
            let task = self.dataTask(with: url) { data, response, error in
                guard let data = data,
                      let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }
                continuation.resume(returning: (data, response))
            }
            
            task.resume()
        }
    }
}
