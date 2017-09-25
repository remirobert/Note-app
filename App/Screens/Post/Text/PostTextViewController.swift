
//
//  PostViewController.swift
//  App
//
//  Created by Remi Robert on 18/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import SnapKit
import Domain
import RealmPlatform

class PostTextViewController: PostViewController {
    private let viewModel: PostViewModel
    private let cellText = TextViewCell()

    init(viewModel: PostViewModel) {
        self.viewModel = viewModel
        super.init()
        cells = [cellText]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Post"
        postKeyboardView.buttonPost.addTarget(self, action: #selector(addPost), for: .touchUpInside)
        cellText.keyboardAccessoryView.buttonPost.addTarget(self, action: #selector(addPost), for: .touchUpInside)
    }

    @objc private func addPost() {
        guard let content = cellText.textView.text else { return }
        viewModel.createNewPost(content: content)
        delegate?.didPost()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let cell = cells.first as? TextViewCell else { return }
        cell.textView.becomeFirstResponder()
        cell.delegate = self
    }
}
