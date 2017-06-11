//
//  Story.swift
//  RssFlux
//
//  Created by Lilian ALVAREZ on 05/06/2017.
//  Copyright © 2017 Lilian ALVAREZ. All rights reserved.
//

import Foundation

class Story: NSObject, NSCoding {
    
    var title: String?
    var content: String?
    var imageUrl: String?
    var publicationDate: String?
    var image: Data?
    
    
    init(title: String, content: String, imageUrl: String, publicationDate: String, image: Data){
        self.title = title
        self.content = content
        self.imageUrl = imageUrl
        self.publicationDate = publicationDate
        self.image = image
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let title = decoder.decodeObject(forKey: "title") as? String,
            let content = decoder.decodeObject(forKey: "content") as? String,
            let imageUrl = decoder.decodeObject(forKey: "imageUrl") as? String,
            let publicationDate = decoder.decodeObject(forKey: "publicationDate") as? String,
            let image = decoder.decodeObject(forKey: "image") as? Data
            else { return nil }
        
        self.init(
            title: title,
            content: content,
            imageUrl: imageUrl,
            publicationDate: publicationDate,
            image: image
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(imageUrl, forKey: "imageUrl")
        aCoder.encode(publicationDate, forKey: "publicationDate")
        aCoder.encode(image, forKey: "image")
    }

}
