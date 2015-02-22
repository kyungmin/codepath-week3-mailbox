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
    @IBOutlet weak var laterRescheduleView: UIView!
    @IBOutlet weak var laterListView: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var feedGroupView: UIView!
    @IBOutlet weak var menuView: UIImageView!
    @IBOutlet var containerView: UIView!
    
    var originalSingleFeedCenter: CGPoint!
    var originalFeedGroupCenter: CGPoint!
    var laterIconValue: CGFloat!
    var archiveIconValue: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = imageView.frame.size

        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "didPanMenu:")
        edgeGesture.edges = UIRectEdge.Left
        feedGroupView.addGestureRecognizer(edgeGesture)
    }

    @IBAction func didPanMenu(sender: UIPanGestureRecognizer) {
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)

        if (sender.state == UIGestureRecognizerState.Began) {
            originalFeedGroupCenter = feedGroupView.center
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            self.feedGroupView.center.x = self.originalFeedGroupCenter.x + translation.x
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            if (velocity.x < 0) { // swiped left
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.feedGroupView.center.x = self.feedGroupView.frame.width / 2
                })
            } else if (velocity.x > 0) { // swiped right
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.feedGroupView.center.x = self.feedGroupView.frame.width + self.feedGroupView.frame.width / 2 - 90
                })
            }

        }
    }
    
    @IBAction func didPanFeedItem(sender: UIPanGestureRecognizer) {
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        var singleFeedOriginX = self.singleFeedView.frame.origin.x
        
        if (sender.state == UIGestureRecognizerState.Began) {
            originalSingleFeedCenter = singleFeedView.center
            self.laterIcon.center.x = 270 + self.laterIcon.frame.width / 2
            self.listIcon.center.x = 46 + self.listIcon.frame.width / 2
            self.archiveIcon.center.x = 25 + self.archiveIcon.frame.width / 2
            self.deleteIcon.center.x = 272 + self.deleteIcon.frame.width / 2
            
            // initial gray background
            self.backgroundView.backgroundColor = UIColor(red: CGFloat(246.0/255.0), green: CGFloat(246.0/255.0), blue: CGFloat(246.0/255.0), alpha: CGFloat(1.0))

        } else if (sender.state == UIGestureRecognizerState.Changed ) {
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: nil, animations: { () -> Void in

                // move horizontally
                self.singleFeedView.center = CGPoint(x: self.originalSingleFeedCenter.x + translation.x, y: self.originalSingleFeedCenter.y)
                
                if (singleFeedOriginX > -60 && singleFeedOriginX <= 60) {
                    // gray background
                    self.backgroundView.backgroundColor = UIColor(red: CGFloat(246.0/255.0), green: CGFloat(246.0/255.0), blue: CGFloat(246.0/255.0), alpha: CGFloat(1.0))

                    // gradually show icons
                    self.laterIconValue = CGFloat(convertValue(Float(singleFeedOriginX), 0, -60, 0, 1))
                    self.archiveIconValue = CGFloat(convertValue(Float(singleFeedOriginX), 0, 60, 0, 1))

                    self.laterIcon.alpha = self.laterIconValue
                    self.archiveIcon.alpha = self.archiveIconValue

                    self.laterIcon.transform = CGAffineTransformMakeScale(self.laterIconValue, self.laterIconValue)
                    self.archiveIcon.transform = CGAffineTransformMakeScale(self.archiveIconValue, self.archiveIconValue)
                } else {
                    // move icons
                    self.laterIcon.center.x = self.originalSingleFeedCenter.x + translation.x + self.singleFeedView.frame.width / 2 + 20
                    
                    self.listIcon.center.x = self.originalSingleFeedCenter.x + translation.x + self.singleFeedView.frame.width / 2 + 20
                    
                    self.archiveIcon.center.x = self.originalSingleFeedCenter.x + translation.x - self.singleFeedView.frame.width / 2 - 20
                    
                    self.deleteIcon.center.x = self.originalSingleFeedCenter.x + translation.x - self.singleFeedView.frame.width / 2 - 20
                }
                
                if (singleFeedOriginX <= -60 && singleFeedOriginX > -260) {
                    // yellow background
                    self.backgroundView.backgroundColor = UIColor(red: CGFloat(240.0/255.0), green: CGFloat(210.0/255.0), blue: CGFloat(70.0/255.0), alpha: CGFloat(1.0))

                    // show laterIcon
                    self.laterIcon.alpha = 1
                    self.listIcon.alpha = 0
                } else if (singleFeedOriginX <= -260) {
                    // brown background
                    self.backgroundView.backgroundColor = UIColor(red: CGFloat(215.0/255.0), green: CGFloat(166.0/255.0), blue: CGFloat(120.0/255.0), alpha: CGFloat(1.0))
                    
                    // show listIcon
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 1
                } else if (singleFeedOriginX >= 60 && singleFeedOriginX < 260) {
                    // green background
                    self.backgroundView.backgroundColor = UIColor(red: CGFloat(116.0/255.0), green: CGFloat(215.0/255.0), blue: CGFloat(104.0/255.0), alpha: CGFloat(1.0))

                    // show archiveIcon
                    self.archiveIcon.alpha = 1
                    self.deleteIcon.alpha = 0
                    
                } else if (singleFeedOriginX >= 260) {
                    // red background
                    self.backgroundView.backgroundColor = UIColor(red: CGFloat(233.0/255.0), green: CGFloat(85.0/255.0), blue: CGFloat(59.0/255.0), alpha: CGFloat(1.0))

                    // show deleteIcon
                    self.archiveIcon.alpha = 0
                    self.deleteIcon.alpha = 1
                    
                }
                
            }, completion: nil)
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            var isSwipeBackEarly = singleFeedOriginX > -60 && singleFeedOriginX < 60
            var isSwipeBackRight = singleFeedOriginX <= -60 && velocity.x > 0
            var isSwipeBackLeft = singleFeedOriginX >= 60 && velocity.x < 0
            var isResetPosition = isSwipeBackEarly || isSwipeBackRight || isSwipeBackLeft
            
            if (isResetPosition) {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: nil, animations: { () -> Void in

                    // spring back to the initial position
                    self.singleFeedView.center = CGPoint(x: self.originalSingleFeedCenter.x, y: self.originalSingleFeedCenter.y)
                }, completion: nil)
            } else if (singleFeedOriginX >= 60 && velocity.x > 0) { // swiped right
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: nil, animations: { () -> Void in

                    // swipe right all the way
                    self.singleFeedView.center = CGPoint(x: self.originalSingleFeedCenter.x + self.singleFeedView.frame.width, y: self.originalSingleFeedCenter.y)
                    
                    // hide icons
                    self.archiveIcon.alpha = 0
                    self.deleteIcon.alpha = 0
                    
                    }) { (completion: Bool) -> Void in
                        self.hideFeedItem()
                    }
            } else if (singleFeedOriginX <= -60 && velocity.x < 0) { // swiped left
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: nil, animations: { () -> Void in
                    
                    // swipe left all the way
                    self.singleFeedView.center = CGPoint(x: -(self.originalSingleFeedCenter.x + self.singleFeedView.frame.width), y: self.originalSingleFeedCenter.y)

                    // hide icons
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 0
                    
                }) { (completion: Bool) -> Void in
                    // display the reschedule view
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        if (singleFeedOriginX <= -260) {
                            self.laterListView.alpha = 1
                        } else {
                            self.laterRescheduleView.alpha = 1
                        }
                    })
                }
            }
        }
        
    }

    @IBAction func didTapLaterView(sender: UITapGestureRecognizer) {
        laterListView.hidden = true
        laterRescheduleView.hidden = true
        hideFeedItem()
    }
    
    func hideFeedItem() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.singleFeedView.hidden = true
            self.backgroundView.center.y -= self.singleFeedView.frame.height
            self.imageView.center.y -= self.singleFeedView.frame.height
            }) { (completion: Bool) -> Void in
                self.backgroundView.hidden = true
        }
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if(event.subtype == UIEventSubtype.MotionShake) {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.laterIcon.alpha = 0
                self.listIcon.alpha = 0
                self.archiveIcon.alpha = 0
                self.deleteIcon.alpha = 0
                
                self.backgroundView.hidden = false
                self.backgroundView.center.y += self.singleFeedView.frame.height

                self.singleFeedView.hidden = false
                self.singleFeedView.center.x = self.singleFeedView.frame.width / 2
                
                self.imageView.center.y += self.singleFeedView.frame.height
            })
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
