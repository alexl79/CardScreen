//
//  CheckListProvider.swift
//  CardScreen
//
//  Created by Alexander Lobanov on 12.01.16.
//  Copyright © 2016 Omega-R. All rights reserved.
//

import Foundation

class CheckListProvider {

    class func data() -> [CardItem] {
        let path = NSBundle.mainBundle().pathForResource("card-data", ofType: "plist")
        let data = NSArray(contentsOfFile: path!)
        
        var listData = [CardItem]()
        for item in data! {
            let dict = item as! CardItemRowType
            let cardItem  = CardItem(dict)
            listData.append(cardItem)
        }
        
        return listData
    }
    
}