//
//  CharactersViewController.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 11/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//
// TODO: renomear cabeçalho

import UIKit

protocol NavigationDelegate: class {
    func goTo()
}

class CharactersViewController: UIViewController {

    // MARK: - Properties

    var viewModel: ViewModelProtocol?
    var name: String

    private var myView: CharactersView {
       // swiftlint:disable force_cast
        return view as! CharactersView
       // swiftlint:enable force_cast
    }

    // MARK: - Init

    init(name: String) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func loadView() {
        let myView = CharactersView()
        view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.name

        let viewModel = ViewModel(services: Services(),
                                  delegate: myView,
                                  navigation: self)

        self.viewModel = viewModel
        myView.viewModel = viewModel
    }
}

    // MARK: - Navigation

extension CharactersViewController: NavigationDelegate {

    func goTo() {

    }
    
}