//
//  CharacterDetailViewController.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 11/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

protocol CharacterDetailNavigationDelegate: class {
    func goToComicDetail()
}

class CharacterDetailViewController: UIViewController {

    // MARK: - Properties

    var viewModel: CharacterDetailViewModelProtocol?
    var character: Character
    var image: UIImage

    private var myView: CharacterDetailView {
       // swiftlint:disable force_cast
       return view as! CharacterDetailView
       // swiftlint:enable force_cast
    }

    // MARK: - Init

    init(forCharacter character: Character, withImage image: UIImage) {
        self.character = character
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func loadView() {
        let myView = CharacterDetailView()
        view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.character.name

        let viewModel = CharacterDetailViewModel(delegate: myView,
                                        navigation: self,
                                        character: character,
                                        image: image)

        self.viewModel = viewModel
        myView.viewModel = viewModel
    }
}

    // MARK: - Navigation

extension CharacterDetailViewController: CharacterDetailNavigationDelegate {

    func goToComicDetail() {
        let comicDetailController = ComicDetailViewController(name: "")
        self.navigationController?.pushViewController(comicDetailController, animated: false)
    }

}
