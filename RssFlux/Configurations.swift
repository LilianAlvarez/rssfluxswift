//
//  Configurations.swift
//  RssFlux
//
//  Created by Lilian ALVAREZ on 05/06/2017.
//  Copyright © 2017 Lilian ALVAREZ. All rights reserved.
//

import Foundation

class Configurations {
    static let apiKeyRssFlux : String = "ad587d01f28647a6a4c54b50367528d4"
    static let recodeUrl = URL(string:"https://newsapi.org/v1/articles?source=recode&sortBy=top&apiKey=\(apiKeyRssFlux)")
}
