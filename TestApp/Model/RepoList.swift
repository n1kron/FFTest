//
//  RepoList.swift
//  TestApp
//
//  Created by  Kostantin Zarubin on 26.05.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import Foundation

class RepoList {
    var repos: [Repo] = []
    private let language: String
    private let sort: String
    private let order: String
    
    init(language: String, sort: String, order: String) {
        self.language = language
        self.sort = sort
        self.order = order
    }
    
    func load() {
        let url = URL(string:"https://api.github.com/search/repositories?q=language:\(language)&sort=\(sort)&order=\(order)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) {(data, response, error) in
            if error == nil {
                do {
                    self.repos.removeAll()
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                    if let items = jsonResult["items"] as? [[String: Any]] {
                        
                        for info in items {
                            let fullName = info["full_name"]
                            let descriptionData = info["description"]
                            let starCount = info["stargazers_count"]
                            let watchersCount = info["watchers_count"]
                            let forksCount = info["forks"]
                            let url = info["html_url"]
                            self.repos.append(Repo(fullName: fullName as! String, descriptionStr: descriptionData as! String, starCount: starCount as! Int, watchersCount: watchersCount as! Int, forksCount: forksCount as! Int, url: url as! String))
                        }
                        NotificationCenter.default.post(name: Notification.Name("repoListLoaded"),object: nil)
                    }
                } catch {
                    print("error")
                }
            }
        }
        task.resume()
    }
}
