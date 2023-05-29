//
//  String+Ext.swift
//  LibOfMovies
//
//  Created by Wojciech Kulas on 29/05/2023.
//

import Foundation

extension String {
    var localized: String { NSLocalizedString(self, comment: "") }
}
