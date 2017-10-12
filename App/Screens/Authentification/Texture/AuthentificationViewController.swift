//
//  AuthentificationViewController.swift
//  App
//
//  Created by Remi Robert on 12/10/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit
import SnapKit

class AuthentificationViewControllerFactory: AuthentificationViewFactory {
    func make() -> AuthentificationView {
        let authProvider = LocalAuthentification()
        return LocalAuthViewController(authentificationProvider: authProvider)
    }
}

class LocalAuthViewController: UIViewController, AuthentificationView {
    private var authentificationProvider: AuthentificationProvider
    private let buttonAuth = UIButton(frame: CGRect.zero)
    private let labelAuth = UILabel(frame: CGRect.zero)

    weak var delegate: AuthentificationViewDelegate?

    init(authentificationProvider: AuthentificationProvider) {
        self.authentificationProvider = authentificationProvider
        super.init(nibName: nil, bundle: nil)
        self.authentificationProvider.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        buttonAuth.setImage(#imageLiteral(resourceName: "touch-id"), for: .normal)
        buttonAuth.setImage(#imageLiteral(resourceName: "touch-id"), for: .highlighted)
        view.addSubview(buttonAuth)
        buttonAuth.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 120, height: 120))
            make.center.equalToSuperview()
        }
        buttonAuth.addTarget(self, action: #selector(self.authentificate), for: .touchUpInside)

        labelAuth.text = "Login using Touch ID"
        labelAuth.textColor = UIColor.black
        labelAuth.textAlignment = .center
        labelAuth.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: UIFontWeightLight)
        view.addSubview(labelAuth)
        labelAuth.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonAuth.snp.bottom).offset(10)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        authentificate()
    }

    @objc private func authentificate() {
        authentificationProvider.authentificate()
    }
}

extension LocalAuthViewController: AuthentificationProviderDelegate {
    func authenticated(success: Bool) {
        if success {
            delegate?.authentificationSuccess()
        }
    }
}
