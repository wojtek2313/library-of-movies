//
//  MainViewController.swift
//  LibOfMovies
//
//  Created by Wojciech Kulas on 29/05/2023.
//

import UIKit

// MARK: - Class Definition

class MainViewController: UIViewController {
    // MARK: - Private Properties
    
    private var viewModel: MainViewModelProtocol
    
    // MARK: - Initializers
    
    init(viewModel: MainViewModelProtocol) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {}
}

