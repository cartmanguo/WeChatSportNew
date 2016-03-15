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

    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var beatLabel: UILabel!
    @IBOutlet weak var contentView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        avatarView.frame = CGRect(x: screenWidth/2-65/2, y: contentView.frame.size.height/2-32 - 65/2, width: 65, height: 65)
        contentView.addSubview(avatarView)
        avatarView.image = UIImage(named: "avatar")
        // Do any additional setup after loading the view.
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
