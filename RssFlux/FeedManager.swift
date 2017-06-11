//
//  FeedManager.swift
//  RssFlux
//
//  Created by Lilian ALVAREZ on 11/06/2017.
//  Copyright © 2017 Lilian ALVAREZ. All rights reserved.
//

import Foundation

class FeedManager {
    
    static var sharedInstance = FeedManager()
    var storyList = [Story]()
    
    func getStoryList(url: URL, resultBlock:@escaping ([Story], Error?)->()){
        let url = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            self.storyList = [Story]()
            if error != nil {
                resultBlock(self.storyList, error)
                return
            }
            do {
                if let stories = data {
                    let json = try JSONSerialization.jsonObject(with: stories, options: .mutableContainers) as! [String: AnyObject]
                    if let storyListFromJson = json["articles"] as? [[String: AnyObject]] {
                        for storyFromJson in storyListFromJson {
                            let story = Story(title: "", content: "", imageUrl: "", publicationDate: "", image: Data())
                            if let title = storyFromJson["title"] as? String,
                                let content = storyFromJson["description"] as? String,
                                let publicationDate = storyFromJson["publishedAt"] as? String,
                                let imageUrl = storyFromJson["urlToImage"] as? String {
                                story.title = title
                                story.content = content
                                story.publicationDate = publicationDate
                                story.imageUrl = imageUrl
                                DispatchQueue.main.async {
                                    let numberOfStory: Int = storyListFromJson.count
                                    self.getImage(story: story, int: numberOfStory) {(storyList, error) in
                                        resultBlock(storyList, error)
                                    }
                                }
                            }
                        }
                    }
                }
            } catch let error {
                print("error == \(error)")
                resultBlock(self.storyList, error)
            }
        }
        task.resume()
    }
    
    func getImage(story: Story, int: Int, resultBlock:@escaping ([Story], Error?)->()){
        if let imageUrl = story.imageUrl {
            let url = URLRequest(url: URL(string:imageUrl)!)
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("error == \(error)")
                    resultBlock(self.storyList, error)
                    return
                }
                DispatchQueue.main.async {
                    if data != nil {
                        story.image = data
                        self.storyList.append(story)
                        if self.storyList.count == int {
                            let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.storyList)
                            UserDefaults.standard.set(encodedData, forKey: "storyList")
                            resultBlock(self.storyList, nil)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
}
