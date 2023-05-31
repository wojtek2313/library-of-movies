//
//  UIView+Ext.swift
//  LibOfMoviesUI
//
//  Created by Wojciech Kulas on 29/05/2023.
//

import Foundation
import UIKit

extension UIView {
    public func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
