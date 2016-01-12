//
//  UIFontExtension.swift
//  CardScreen
//
//  Created by Alexander Lobanov on 12.01.16.
//  Copyright © 2016 Omega-R. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    func sizeOfString (string: NSString, constrainedToWidth width: CGFloat) -> CGSize {
        return string.boundingRectWithSize(CGSizeMake(width, CGFloat(FLT_MAX)),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: self],
            context: nil).size
    }
    
}