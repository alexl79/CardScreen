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
    private let descriptionViewMinHeight: CGFloat = 100
    
    var card: CardItem?
    var isDescriptionViewSmall: Bool = true
    
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    
    override func viewDidLoad() {

        super.viewDidLoad()

        let url = NSURL(string: card!.image)
        self.topImage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "placeholder"))
        
        self.titleLabel.text = card!.title
        self.dateLabel.text = card!.date
        self.authorLabel.text = card!.author
        self.descriptionTextView.text = card!.description
        self.likesLabel.text = card!.likes
    }
    
    override func viewWillAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        self.updateDescriprionHeightToState(self.isDescriptionViewSmall)
    }
    
    //MARK: Actions
    private func updateDescriprionHeightToState(needSmall: Bool) {
        var frame: CGRect = self.descriptionTextView.frame;
        
        if !needSmall {
            let s = self.descriptionTextView.text
            let newSize: CGSize = self.descriptionTextView.font!.sizeOfString(s, constrainedToWidth: frame.width)
            
            frame.size = CGSizeMake(frame.width, newSize.height)
        } else {
            frame.size = CGSizeMake(frame.width, self.descriptionViewMinHeight)
        }
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.descriptionTextView.frame = frame;
            self.view.setNeedsUpdateConstraints()
            self.view.setNeedsLayout()
            self.view.superview!.layoutIfNeeded()
            
            self.likesLabel.layoutIfNeeded()
        }
    }
    
    private func toggleDescriprionHeight() {
        self.isDescriptionViewSmall = !self.isDescriptionViewSmall
        self.updateDescriprionHeightToState(self.isDescriptionViewSmall)
    }
    
    @IBAction func moreButton(sender: UIButton) {
        self.toggleDescriprionHeight()
    }

}

