//
//  ViewCodable.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 12/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

protocol ViewCodable {
    /// Use to setup delegates and things like delegates and Images from imageViews
    func configure()
    /// Use to add any UI components inside the view
    func setupHierarchy()
    /// Setup constraints to the view and the subviews
    func setupConstraints()
    /// Customize the UIComponents(fonts, colors)
    func render()
    /// Setup any acessibility to the view
    func setupAcessibilityIdentifiers()
    /// This method builds the view using all the other methods fom the protocol
    func setupView()
}

extension ViewCodable {

    // Sometimes will not be implemented
    func setupAcessibilityIdentifiers() { }

    func setupView() {
        configure()
        setupHierarchy()
        setupConstraints()
        render()
        setupAcessibilityIdentifiers()
    }

}
