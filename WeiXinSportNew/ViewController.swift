//
//  ViewController.swift
//  WeiXinSportNew
//
//  Created by randy on 16/3/10.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit
extension UINavigationController
{
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var bgImageView:UIImageView!
    @IBOutlet weak var contentView:UIScrollView!
    @IBOutlet weak var winnerView: UIView!
    var headerImageView:UIImageView?
    var tableView:UITableView!
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let headerHeight = UIScreen.mainScreen().bounds.size.height/2
    var users:[User] = [User]()
    let cellHeight = 65
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "排行榜"
        let userData1 = User(name: "Alan", steps: 7894,likes: 5)
        let userData2 = User(name: "Jimmy", steps: 12343,likes: 5)
        let userData3 = User(name: "Steve", steps: 2546,likes: 5)
        let userData4 = User(name: "Guo", steps: 1345,likes: 5)
        let userData5 = User(name: "Kobe", steps: 3451,likes: 5)
        let userData6 = User(name: "Jeremy", steps: 5678,likes: 5)
        let userData7 = User(name: "James", steps: 6543,likes: 5)
        let userData8 = User(name: "Dean", steps: 8888,likes: 5)
        let userData9 = User(name: "Cartman", steps: 999999,likes: 5)
        users.append(userData1)
        users.append(userData2)
        users.append(userData3)
        users.append(userData4)
        users.append(userData5)
        users.append(userData6)
        users.append(userData7)
        users.append(userData8)
        users.append(userData9)
        users.sortInPlace({(user1,user2) in
            return user1.steps > user2.steps
        })

        let effect = UIBlurEffect(style: .Light)
        let blurBg = UIVisualEffectView(effect: effect)
        blurBg.frame = CGRect(x: 0, y: screenHeight/2-64, width: screenWidth, height:CGFloat((users.count+1)*cellHeight+10))
        tableView = UITableView(frame: CGRect(x: 0, y: screenHeight/2-64, width: screenWidth, height:CGFloat((users.count+1)*cellHeight+10)), style: .Plain)
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.backgroundColor = UIColor.redColor()
        contentView.showsVerticalScrollIndicator = false
        contentView.delegate = self
        tableView.scrollEnabled = false
        contentView.contentSize = CGSize(width: screenWidth, height: screenHeight-64+10+fabs(screenHeight/2 - CGFloat((users.count+1)*cellHeight)))
//        self.edgesForExtendedLayout = .None
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.delegate = self
        tableView.dataSource = self
        contentView.addSubview(blurBg)
        contentView.addSubview(tableView)
        tableView.alpha = 0.7
        //tableView.registerClass(UserCell.self, forCellReuseIdentifier: "cell")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(imageWithColor(UIColor(red: 45/255, green: 46/255, blue: 52/255, alpha: 1.0).colorWithAlphaComponent(0)), forBarMetrics: UIBarMetrics.Default)
        //self.tableView.contentInset = UIEdgeInsets(top: screenHeight/2.2, left: 0, bottom: 0, right: 0)
        // Do any additional setup after loading the view, typically from a nib.
        tableView.performSelector("reloadData", withObject: nil, afterDelay: 2.0)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yOffset  = scrollView.contentOffset.y
        var alpha = min(0.99,yOffset/screenHeight*4)
        navigationController?.navigationBar.setBackgroundImage(imageWithColor(UIColor(red: 45/255, green: 46/255, blue: 52/255, alpha: 1.0).colorWithAlphaComponent(alpha)), forBarMetrics: UIBarMetrics.Default)
        alpha=fabs(alpha);
        alpha=fabs(1-alpha);
        if yOffset < 0
        {
            winnerView.alpha = 1.0
        }
        else
        {
            winnerView.alpha = alpha

        }

        alpha=alpha<0.2 ?0:alpha-0.2;
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else
        {
            return users.count
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1
        {
            let footer = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
            footer.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
            return footer
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1
        {
            return 10
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UserCell
        if cell == nil
        {
            cell = NSBundle.mainBundle().loadNibNamed("UserCell", owner: self, options: nil).first as? UserCell
        }
        cell?.selectionStyle = .None
        cell?.contentView.alpha = 0.8
        if indexPath.section == 0
        {
            if users[indexPath.row].steps > 10000
            {
                cell?.userStepsLabel.textColor = UIColor.orangeColor()
            }
            cell?.rankLabel.hidden = true
            cell?.userNameLabel.text = users[0].name!
            cell?.userStepsLabel.text = String(users[0].steps!)
            cell?.likesLabel.text = String(users[0].likes!)
            return cell!
        }
        else
        {
            if users[indexPath.row].steps > 10000
            {
                cell?.userStepsLabel.textColor = UIColor.orangeColor()
            }
            cell?.rankLabel.text = String(indexPath.row + 1)
            cell?.topConstraint.priority = 750
            cell?.centerYConstraint.priority = 1000
            cell?.userNameLabel.text = users[indexPath.row].name!
            cell?.userStepsLabel.text = String(users[indexPath.row].steps!)
            cell?.likesLabel.text = String(users[indexPath.row].likes!)
            cell?.userRankLabel.hidden = true
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("DetailSegue", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let userData = users[tableView.indexPathsForSelectedRows!.first!.row]
        let detailVC = segue.destinationViewController as! DetailViewController
        detailVC.user = userData
    }

}

