//
//  ViewController.swift
//  TestApp
//
//  Created by  Kostantin Zarubin on 23.05.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet var repositoriesTableView: UITableView!
    let repoList = RepoList(language: "swift", sort: "stars", order: "desc")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repoList.load()
        repositoriesTableView.rowHeight = UITableViewAutomaticDimension
        repositoriesTableView.estimatedRowHeight = 44
        repositoriesTableView.isHidden = true
        repositoriesTableView.addSubview(self.refreshControl)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: Notification.Name("repoListLoaded"), object: nil)
    }
    
    @objc func updateTableView() {
        repositoriesTableView.isHidden = false
        repositoriesTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        repoList.load()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath else { return }
        guard let vc = segue.destination as? DetailViewController else { return }
        vc.repo = repoList.repos[indexPath.row]
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell
        cell.fullNameLabel.text = repoList.repos[indexPath.row].fullName
        cell.descriptionLabel.text = repoList.repos[indexPath.row].descriptionStr
        cell.starCountLabel.text = "\(repoList.repos[indexPath.row].starsCount)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: indexPath)
    }
}
