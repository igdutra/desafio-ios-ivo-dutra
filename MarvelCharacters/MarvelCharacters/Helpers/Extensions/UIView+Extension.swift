//
//  UIView+Extension.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 13/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

extension UIView {

    /// Set translatesAutoresizingMaskIntoConstraints to false
    func setConstraints(completion: (UIView) -> Void) {

        if self.translatesAutoresizingMaskIntoConstraints {
            self.translatesAutoresizingMaskIntoConstraints = false
        }

        // Completion should name its variable "view"
        completion(self)
    }

    /// Add multiple subviews at once
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }

}
