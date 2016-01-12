//
//  File.swift
//  CardScreen
//
//  Created by Alexander Lobanov on 12.01.16.
//  Copyright © 2016 Omega-R. All rights reserved.
//

import Foundation

typealias CardItemRowType = Dictionary<String, String>

class CardItem {
    private let imageName: String = "image"
    private let titleName: String = "title"
    private let dateName: String = "date"
    private let authorName: String = "author"
    private let desriptionName: String = "description"
    private let likesName: String = "likes"
    
    var image: String
    var title: String
    var date: String
    var author: String
    var description: String
    var likes: String
    
    init (_ data: CardItemRowType) {
        
        self.image = data[imageName]!
        self.title = data[titleName]!
        self.date = data[dateName]!
        self.author = data[authorName]!
        self.description = data[desriptionName]!
        self.likes = data[likesName]!
        
    }
    
}