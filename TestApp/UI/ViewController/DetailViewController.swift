//
//  DetailViewController.swift
//  TestApp
//
//  Created by  Kostantin Zarubin on 24.05.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit
import SafariServices


class DetailViewController: UIViewController {
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var gitHubButton: UIButton!
    
    var repo: Repo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureControls()
        gitHubButton.layer.cornerRadius = 10.0
    }
    
    func configureControls() {
        guard let r = repo else { return }
        self.title = r.fullName
        watchersLabel.text = "\(r.watchersCount)"
        starsLabel.text = "\(r.starsCount)"
        forksLabel.text = "\(r.forksCount)"
        gitHubButton.setTitleColor(.gray, for: .highlighted)
    }
    
    @IBAction func gitHubAction(_ sender: Any) {
        guard let r = repo else { return }
        if let url = URL(string: r.url) {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
    

}
