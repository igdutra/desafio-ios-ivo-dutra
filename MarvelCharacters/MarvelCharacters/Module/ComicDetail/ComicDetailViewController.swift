//
//  ComicDetailViewController.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 11/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class ComicDetailViewController: UIViewController {

    // MARK: - Properties

    var viewModel: ComicDetailViewModelProtocol?
    var character: Character

    private var myView: ComicDetailView {
       // swiftlint:disable force_cast
       return view as! ComicDetailView
       // swiftlint:enable force_cast
    }

    // MARK: - Init

    init(forCharacter character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func loadView() {
        let myView = ComicDetailView()
        view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = ""

        let viewModel = ComicDetailViewModel(services: MarvelComicsService(),
                                             delegate: myView,
                                             character: character)

        self.viewModel = viewModel
        myView.viewModel = viewModel
    }
}
