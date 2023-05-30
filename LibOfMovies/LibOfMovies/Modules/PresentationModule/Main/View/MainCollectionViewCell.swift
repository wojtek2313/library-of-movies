//
//  MainCollectionViewCell.swift
//  LibOfMovies
//
//  Created by Wojciech Kulas on 29/05/2023.
//

import UIKit
import LibOfMoviesUI

class MainCollectionViewCell: UICollectionViewCell {
    // MARK: - UI
    
    private let backdropImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .smallAvenirHeavyOpaque
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Public Methods
    
    public func configure(with model: Movie) {
        backdropImage.downloadImage(withKey: model.backdropPath)
        titleLabel.text = model.title
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubviews([backdropImage, titleLabel])
    }
    
    private func addConstraints() {
        /// Backdrop Image Constraints
        backdropImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backdropImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LibOfMoviesSize.xsSize).isActive = true
        backdropImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backdropImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        /// Title Label Constraints
        titleLabel.bottomAnchor.constraint(equalTo: backdropImage.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: backdropImage.leadingAnchor, constant: LibOfMoviesSize.xsSize).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: backdropImage.trailingAnchor, constant: -LibOfMoviesSize.xsSize).isActive = true
    }
}
