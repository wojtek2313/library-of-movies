//
//  DetailsViewController.swift
//  LibOfMovies
//
//  Created by Wojciech Kulas on 30/05/2023.
//

import UIKit

class DetailsViewController: UIViewController {
    // MARK: - Private Properties
    
    private var viewModel: DetailsViewModelProtocol
    
    // MARK: - Initializers
    
    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifetime Methods
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        view.backgroundColor = .white
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        
    }
    
    private func addConstraints() {
        
    }
}
