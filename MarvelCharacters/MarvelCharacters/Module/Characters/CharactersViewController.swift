//
//  CharactersViewController.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 11/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

protocol CharactersNavigationDelegate: class {
    func goToDetail(forCharacter: Character, withImage: UIImage)
}

class CharactersViewController: UIViewController {

    // MARK: - Properties

    var viewModel: CharactersViewModelProtocol?

    private var myView: CharactersView {
       // swiftlint:disable force_cast
        return view as! CharactersView
       // swiftlint:enable force_cast
    }

    // MARK: - Init

    init() {
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

        self.title = "Marvel's Characters"

        let viewModel = CharactersViewModel(services: MarvelCharactersService(),
                                            delegate: myView,
                                            navigation: self)

        self.viewModel = viewModel
        myView.viewModel = viewModel
    }
}

    // MARK: - Navigation

extension CharactersViewController: CharactersNavigationDelegate {

    func goToDetail(forCharacter character: Character, withImage image: UIImage) {
        let detailController = DetailViewController(forCharacter: character, withImage: image)
        self.navigationController?.pushViewController(detailController, animated: false)
    }
    
}
