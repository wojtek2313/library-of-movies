//
//  DetailsNavigation.swift
//  LibOfMovies
//
//  Created by Wojciech Kulas on 30/05/2023.
//

import UIKit

// MARK: - Enum Definition

public enum DetailsNavigationType: String {
    case details
}

// MARK: - Class Definition

class DetailsNavigationRouter: NavigationRouter<Movie, DetailsNavigationType> {
    override func navigate(to routeID: RouteID, from context: UIViewController, withParameters parameters: Parameters?) {
        switch routeID {
        case .details:
            guard let parameters = parameters else { return }
            let viewModel = DetailsViewModel(movie: parameters)
            let viewController = DetailsViewController(viewModel: viewModel)
            context.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
