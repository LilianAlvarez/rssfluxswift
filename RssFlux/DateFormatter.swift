//
//  DateFormatter.swift
//  RssFlux
//
//  Created by Lilian ALVAREZ on 10/06/2017.
//  Copyright © 2017 Lilian ALVAREZ admin. All rights reserved.
//

import Foundation

class Date {
    
    static var sharedInstance = Date()

    func dateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let formattedDate = dateFormatter.date(from: date)!
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: formattedDate)
    }

}
