//
//  ViewController.swift
//  CardScreen
//
//  Created by Alexander Lobanov on 12.01.16.
//  Copyright © 2016 Omega-R. All rights reserved.
//

import UIKit
import SDWebImage

class CardViewController: UIViewController {
    var card: CardItem?
    
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    
    override func viewDidLoad() {

        super.viewDidLoad()

        let url = NSURL(string: card!.image)
        self.topImage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "placeholder"))
        
        self.titleLabel.text = card!.title
        self.dateLabel.text = card!.date
        self.authorLabel.text = card!.author
        self.descriptionLabel.text = card!.description
        self.likesLabel.text = card!.likes
        
    }
    
    override func viewWillAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

