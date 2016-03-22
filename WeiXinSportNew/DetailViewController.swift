//
//  DetailViewController.swift
//  WeiXinSportNew
//
//  Created by randy on 16/3/15.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UIScrollViewDelegate {

    let screenHeight = UIScreen.mainScreen().bounds.size.height
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    var tableView:UITableView!
    var user:User?

    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var beatLabel: UILabel!
    @IBOutlet weak var contentView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var infoViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var stepsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        stepsLabel.text = String(user!.steps!)
        graphView.datas.append(user!.steps!)
        self.title = "我的主页"
        let effect = UIBlurEffect(style: .Light)
        let blurBg = UIVisualEffectView(effect: effect)
        blurBg.frame = CGRect(x: 0, y: screenHeight/2-64, width: screenWidth, height:screenHeight * 1.5)
        contentView.showsVerticalScrollIndicator = false
        contentView.delegate = self
        contentView.contentSize = CGSize(width: screenWidth, height: screenHeight+70)
        self.automaticallyAdjustsScrollViewInsets = false
        contentView.addSubview(blurBg)
        contentView.sendSubviewToBack(blurBg)
        self.view.backgroundColor = UIColor.whiteColor()
        let avatarView = UIImageView()
        
        avatarView.image = UIImage(named: "avatar")
        infoViewTopConstraint.constant = screenHeight/2 - 64
        // Do any additional setup after loading the view.
        containerView.layoutIfNeeded()
        avatarView.frame.origin = CGPoint(x:containerView.center.x-64/2, y: screenHeight/2 - 64-64/2)
        avatarView.frame.size = CGSize(width: 65, height: 65)
        contentView.addSubview(avatarView)
        let moreBarButton = UIBarButtonItem(image: UIImage(named: "more"), style: .Plain, target: self, action: "enterData")
        navigationItem.rightBarButtonItem = moreBarButton
    }
    
    func enterData()
    {
        let alert = UIAlertController(title: "输入步数", message: "输入今日步数", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler({(textField) in
            textField.keyboardType = .NumberPad
            //textField.borderStyle = .RoundedRect
        })
        let confirmAction = UIAlertAction(title: "确定", style: .Default, handler: {(action) in
            let textfield = alert.textFields![0]
            if let stepString = textfield.text
            {
                let step = Int(stepString)
                self.graphView.datas[6] = step!
                self.graphView.tenThousandMarkLabel.removeFromSuperview()
                self.graphView.initialDisplay = false
                self.graphView.setNeedsDisplay()
                self.stepsLabel.text = String(step!)

            }
        })
        let cancelAction = UIAlertAction(title: "取消", style: .Destructive, handler: {(action) in
        })
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
//        graphView.tenThousandMarkLabel.removeFromSuperview()
//        graphView.datas[6] = 35654
//        graphView.initialDisplay = false
//        graphView.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yOffset  = scrollView.contentOffset.y
        var alpha = min(0.99,yOffset/screenHeight*4)
        navigationController?.navigationBar.setBackgroundImage(imageWithColor(UIColor(red: 45/255, green: 46/255, blue: 52/255, alpha: 1.0).colorWithAlphaComponent(alpha)), forBarMetrics: UIBarMetrics.Default)
        alpha=fabs(alpha);
        alpha=fabs(1-alpha);
        if yOffset < 0
        {
            beatLabel.alpha = 1.0
        }
        else
        {
            beatLabel.alpha = alpha
            
        }
        
        alpha=alpha<0.2 ?0:alpha-0.2;
    }

    func imageWithColor(color:UIColor)->UIImage
    {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
        
        UIGraphicsBeginImageContext(rect.size);
        
        let context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        
        CGContextFillRect(context, rect);
        
        let theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return theImage;
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
