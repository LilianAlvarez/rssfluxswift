//
//  ViewController.swift
//  RssFlux
//
//  Created by Lilian ALVAREZ on 02/06/2017.
//  Copyright © 2017 Lilian ALVAREZ. All rights reserved.
//

import UIKit

class DetailedStoryViewController: UIViewController {
    
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var storyDescriptionLabel: UILabel!
    
    var storyTitle: String = ""
    var publicationDate: String = ""
    var image = UIImage()
    var content: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUserInterface()
    }
    
    func initializeUserInterface(){
        storyTitleLabel.text = storyTitle
        storyDescriptionLabel.text = content
        storyImageView.image = image
        navigationItem.title = "Publié le " + Date.sharedInstance.dateFormatter(date: publicationDate)
    }

}

