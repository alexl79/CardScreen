//
//  ViewController.swift
//  CardScreen
//
//  Created by Alexander Lobanov on 12.01.16.
//  Copyright © 2016 Omega-R. All rights reserved.
//

import UIKit
import SDWebImage

class CardViewController: UIViewController, UIScrollViewDelegate {
    private let descriptionViewMinHeight: CGFloat = 110
    private let scrollViewBottomInset: CGFloat = 20
    private var navigationBarHeight: CGFloat = 0
    
    var card: CardItem?
    
    private var isDescriptionViewSmall: Bool = true {
        didSet {
            if (isDescriptionViewSmall) {
                self.moreButton.setTitle("More...", forState: UIControlState.Normal)
            } else {
                self.moreButton.setTitle("Less...", forState: UIControlState.Normal)
            }
        }
    }
    private var topImageHeight: CGFloat = 0
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var descriptionTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageTopSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {

        super.viewDidLoad()

        let url = NSURL(string: card!.image)
        self.topImage.image = UIImage(named: "placeholder")
        SDWebImageManager.sharedManager().downloadImageWithURL(
            url,
            options: SDWebImageOptions(),
            progress: nil) { (image, ErrorType, cacheType, isDownloaded, url) -> Void in
            
                self.topImage.alpha = 0.0
                self.topImage.image = image
                
                UIView.transitionWithView(self.topImage, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                        self.topImage.alpha = 1.0
                    }, completion: nil)
            
        }
        
        
        self.titleLabel.text = card!.title
        self.dateLabel.text = card!.date
        self.authorLabel.text = card!.author
        self.descriptionTextView.text = card!.description
        self.likesLabel.text = card!.likes
        
        self.topImageHeight = self.topImage.height
        
        self.scrollView.delegate = self
        self.scrollView.contentInset.bottom = scrollViewBottomInset
        
        self.descriptionTextViewHeightConstraint.constant = self.descriptionViewMinHeight
        let tapGesture = UITapGestureRecognizer(target: self, action: "onDescriptionTap:")
        self.descriptionTextView.addGestureRecognizer(tapGesture)
        
        updateNavigationBarHeight();
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.layoutIfNeeded()
        
        self.updateDescriprionHeightToState(false, test: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        updateNavigationBarHeight()       
        self.updateDescriprionHeightToState(self.isDescriptionViewSmall)
    }
    
    func updateNavigationBarHeight()
    {
        self.navigationBarHeight = (self.navigationController?.navigationBar.height)! + UIApplication.sharedApplication().statusBarFrame.height
    }
    
    //MARK: ScrollView delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let newHeight = topImageHeight - (scrollView.contentOffset.y + navigationBarHeight)
        let newTop = topImageHeight - newHeight
        
        if (newHeight >= 0) {
            self.topImageHeightConstraint.constant = newHeight
            self.topImageTopSpaceConstraint.constant = newTop
        }
    }
    
    //MARK: Gestures
    func onDescriptionTap(gesture: UITapGestureRecognizer) {
        self.toggleDescriprionHeight()
    }
    
    //MARK: Actions
    
    private func updateDescriprionHeightToState(needSmall: Bool, test: Bool = false) {
        var frame: CGRect = self.descriptionTextView.frame;

        let s = self.descriptionTextView.text
        let newSize: CGSize = self.descriptionTextView.font!.sizeOfString(s, constrainedToWidth: frame.width)
        
        if !needSmall {
            frame.size = CGSizeMake(frame.width, newSize.height)
        } else {
            frame.size = CGSizeMake(frame.width, self.descriptionViewMinHeight)
        }
        
        if (newSize.height < self.descriptionViewMinHeight) {
            self.descriptionTextViewHeightConstraint.constant = newSize.height
            self.moreButton.hidden = true
            //self.view.layoutIfNeeded()
            
        } else {
            self.moreButton.hidden = false
            
            if (!test) {
                UIView.transitionWithView(self.descriptionTextView,
                    duration: 0.3,
                    options: UIViewAnimationOptions.CurveLinear,
                    animations: { () -> Void in
                        let delta = frame.height - self.descriptionTextViewHeightConstraint.constant
                        self.contentViewHeightConstraint.constant += delta
                        
                        self.descriptionTextViewHeightConstraint.constant = frame.height
                        self.view.layoutIfNeeded()
                    }, completion: { (Bool) -> Void in
                        /*
                        let maxFrame = self.contentView.maxFrame()
                        
                        UIView.transitionWithView(self.contentView,
                            duration: 0.2,
                            options: UIViewAnimationOptions.CurveLinear,
                            animations: { () -> Void in
                                self.contentViewHeightConstraint.constant = maxFrame.size.height
                                self.view.layoutIfNeeded()
                            }, completion: { (Bool) -> Void in
                                self.scrollView.scrollRectToVisible(self.descriptionTextView.frame, animated: true)
                        })*/
                    })
            }
        }
        
    }
    
    private func toggleDescriprionHeight() {
        self.isDescriptionViewSmall = !self.isDescriptionViewSmall
        self.updateDescriprionHeightToState(self.isDescriptionViewSmall)
    }
    
    @IBAction func moreButtonTap(sender: UIButton) {
        self.toggleDescriprionHeight()
    }
    
}

