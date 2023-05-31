//
//  UIImageView+ext.swift
//  LibOfMovies
//
//  Created by Wojciech Kulas on 30/05/2023.
//

import Foundation
import LibOfMoviesNetwork
import UIKit

extension UIImageView {
    func downloadImage(withKey key: String) {
        Task { @MainActor in
            let image = try await NetworkManager.shared.fetchBackdropImage(fromKey: key)
            self.image = image
        }
    }
}
