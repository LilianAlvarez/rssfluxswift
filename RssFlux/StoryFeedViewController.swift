//
//  StoryFeedViewController.swift
//  RssFlux
//
//  Created by Lilian ALVAREZ on 06/06/2017.
//  Copyright © 2017 Lilian ALVAREZ. All rights reserved.
//

import UIKit

class StoryFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let pullToRefresh = UIRefreshControl()
    var storyList: [Story]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pullToRefresh.addTarget(self, action:#selector(getStoryList), for: UIControlEvents.valueChanged)
        tableView.addSubview(pullToRefresh)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !isInternetAvailable(){
            self.tableView.reloadData()
        } else {
            self.getStoryList()
        }
    }
    
    func getStoryList(){
        FeedManager.sharedInstance.getStoryList(url: Configurations.recodeUrl!) {(storyList, error) in
            if error != nil {
                self.pullToRefresh.endRefreshing()
                return
            }
            self.storyList = storyList
            self.tableView.reloadData()
            self.pullToRefresh.endRefreshing()
        }
    }
    
}

extension StoryFeedViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isInternetAvailable() {
            if let data = UserDefaults.standard.data(forKey: "storyList") {
                let storyList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Story]
                return storyList?.count ?? 0
            } else {
                return 0
            }
        } else {
            return self.storyList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StoryTableViewCell
        if !isInternetAvailable() {
            if let data = UserDefaults.standard.data(forKey: "storyList") {
                let storyList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Story]
                cell.storyTitleLabel.text = storyList?[indexPath.item].title
                cell.storyImageView.image = UIImage(data: (storyList?[indexPath.item].image!)!)
            }
        } else {
            if let title = self.storyList?[indexPath.item].title,
                let image = self.storyList?[indexPath.item].image {
                cell.storyTitleLabel.text = title
                cell.storyImageView.image = UIImage(data: image)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailedStoryViewController") as! DetailedStoryViewController
        if !isInternetAvailable() {
            if let data = UserDefaults.standard.data(forKey: "storyList"),
               let storyList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Story],
               let image = UIImage(data: storyList[indexPath.item].image!),
               let publicationDate = storyList[indexPath.item].publicationDate,
               let content = storyList[indexPath.item].content,
               let title = storyList[indexPath.item].title {
                vc.publicationDate = publicationDate
                vc.content = content
                vc.image = image
                vc.storyTitle = title
            }
        } else {
            if let date = self.storyList?[indexPath.row].publicationDate,
               let title = self.storyList?[indexPath.row].title,
               let content = self.storyList?[indexPath.row].content,
               let image = self.storyList?[indexPath.row].image {
                vc.publicationDate = date
                vc.content = content
                vc.image = UIImage(data:image)!
                vc.storyTitle = title
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
}
