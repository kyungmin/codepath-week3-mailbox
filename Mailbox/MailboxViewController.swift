//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Kyungmin Kim on 2/18/15.
//  Copyright (c) 2015 Kyungmin Kim. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var singleFeedView: UIImageView!
    var originalSingleFeedCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = imageView.frame.size
    }

    @IBAction func didPanMenu(sender: UIPanGestureRecognizer) {
            // UIPanGestureRecognizer
    }
    
    @IBAction func didPanFeedItem(sender: UIPanGestureRecognizer) {
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        var singleFeedOriginX = self.singleFeedView.frame.origin.x
        
        if (sender.state == UIGestureRecognizerState.Began) {
            originalSingleFeedCenter = singleFeedView.center

            // initial gray background
            self.backgroundView.backgroundColor = UIColor(red: CGFloat(246.0/255.0), green: CGFloat(246.0/255.0), blue: CGFloat(246.0/255.0), alpha: CGFloat(1.0))

        } else if (sender.state == UIGestureRecognizerState.Changed ) {
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: nil, animations: { () -> Void in
                if (velocity.x < 0) { // swipe left
                    if (singleFeedOriginX <= -60 && singleFeedOriginX > -260) {
                        // yellow background
                        self.backgroundView.backgroundColor = UIColor(red: CGFloat(240.0/255.0), green: CGFloat(210.0/255.0), blue: CGFloat(70.0/255.0), alpha: CGFloat(1.0))
                        
                    } else if (singleFeedOriginX <= -260) {
                        // brown background
                        self.backgroundView.backgroundColor = UIColor(red: CGFloat(215.0/255.0), green: CGFloat(166.0/255.0), blue: CGFloat(120.0/255.0), alpha: CGFloat(1.0))
                        
                    }
                } else if (velocity.x > 0) { // swipe right
                    if (singleFeedOriginX >= 60 && singleFeedOriginX < 260) {
                        // green background
                        self.backgroundView.backgroundColor = UIColor(red: CGFloat(116.0/255.0), green: CGFloat(215.0/255.0), blue: CGFloat(104.0/255.0), alpha: CGFloat(1.0))
                        
                    } else if (singleFeedOriginX >= 260) {
                        // red background
                        self.backgroundView.backgroundColor = UIColor(red: CGFloat(233.0/255.0), green: CGFloat(85.0/255.0), blue: CGFloat(59.0/255.0), alpha: CGFloat(1.0))
                        
                    }
                }
                // move horizontally
                self.singleFeedView.center = CGPoint(x: self.originalSingleFeedCenter.x + translation.x, y: self.originalSingleFeedCenter.y)
            }, completion: nil)
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: nil, animations: { () -> Void in
                
                self.singleFeedView.center = CGPoint(x: self.originalSingleFeedCenter.x, y: self.originalSingleFeedCenter.y)
                }, completion: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
