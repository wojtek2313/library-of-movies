//
//  MainViewController.swift
//  LibOfMovies
//
//  Created by Wojciech Kulas on 29/05/2023.
//

import UIKit
import LibOfMoviesUI

// MARK: - Class Definition

class MainViewController: UIViewController {
    // MARK: - Constants
    
    private struct Constants {
        static let numberOfColumnsInCollectionView = 2
        
    }
    
    // MARK: - Private Properties
    
    private var viewModel: MainViewModelProtocol
    
    // MARK: - UI
    
    private var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["all_section".localized, "favourites_section".localized])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(bindSegmentedControl(sender:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private var collectionView: UICollectionView = {
        /// CollectionViewFlowLayout
        let collectionViewFlowLayout = LibOfMoviesCollectionViewFlowLayout(numberOfColumns: Constants.numberOfColumnsInCollectionView,
                                                                           minimumInteritemSpacing: 8,
                                                                           minimumLineSpacing: 5,
                                                                           customItemWidth: 120,
                                                                           customItemHeight: 70)
        collectionViewFlowLayout.scrollDirection = .vertical
        /// CollectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let cellReuseIdentifier = String(describing: MainCollectionViewCell.self)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        return collectionView
    }()
    
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
    
    // MARK: - Private Methods
    
    private func setupView() {
        view.backgroundColor = .white
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        view.addSubviews([segmentedControl, collectionView])
    }
    
    private func addConstraints() {
        /// Segmented Control Constraints
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LibOfMoviesSize.large).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LibOfMoviesSize.large).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LibOfMoviesSize.large).isActive = true
        
        /// Collection View Constraints
        collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: LibOfMoviesSize.mSize).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: LibOfMoviesSize.zero).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LibOfMoviesSize.xxsSize).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LibOfMoviesSize.xxsSize).isActive = true
    }
}

// MARK: - Events

extension MainViewController {
    private func setupEvents() {
        
    }
    
    @objc
    private func bindSegmentedControl(sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        viewModel.selectedIndex?(selectedIndex)
        collectionView.reloadData()
    }
}

