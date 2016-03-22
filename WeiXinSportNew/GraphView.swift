//
//  GraphView.swift
//  WeiXinSportNew
//
//  Created by randy on 16/3/14.
//  Copyright © 2016年 randy. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {
    
    //1 - the properties for the gradient
    @IBInspectable var startColor: UIColor = UIColor.redColor()
    @IBInspectable var endColor: UIColor = UIColor.greenColor()
    @IBInspectable var graphStartColor: UIColor = UIColor.redColor()
    @IBInspectable var graphEndColor: UIColor = UIColor.greenColor()
    let tenThousandMarkLabel = UILabel()
    var datas = [14123,232,5986,8689,21356,13598]
    var initialDisplay = true
    override func drawRect(rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        //set up background clipping area
        let path = UIBezierPath(roundedRect: rect,
            byRoundingCorners: UIRectCorner.AllCorners,
            cornerRadii: CGSize(width: 8.0, height: 8.0))
        path.addClip()
        
        //2 - get the current context
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        let colors = [startColor.CGColor, endColor.CGColor]
        
        //3 - set up the color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        //4 - set up the color stops
        let colorLocations:[CGFloat] = [0.0, 1.0]
        
        //5 - create the gradient
        let gradient = CGGradientCreateWithColors(colorSpace,
            colors,
            colorLocations)
        
        //6 - draw the gradient
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x:self.bounds.width, y:rect.height)
        CGContextDrawLinearGradient(context,
            gradient,
            startPoint,
            endPoint,
            CGGradientDrawingOptions.DrawsBeforeStartLocation)
        
        var xPoints:[CGFloat] = []
        //cal xPoints
        let leftMargin:CGFloat = 5
        let rightMargin:CGFloat = 10
        let chartWidth = width - leftMargin - rightMargin
        let lineWidth = chartWidth / CGFloat((datas.count - 1))
        for var i = 0;i<datas.count;i++
        {
            let x = leftMargin + CGFloat(CGFloat(i) * lineWidth)
            xPoints.append(x)
        }
        //cal yPoints
        let topMargin:CGFloat = 80
        let bottomMargin:CGFloat = 25
        let chartHeight = height - topMargin - bottomMargin
        let maxValue = datas.maxElement()
        let levels = maxValue! / 10000
        let levelHeight = chartHeight / CGFloat(levels)
        var yPoints:[CGFloat] = []
        for var i = 0;i<datas.count;i++
        {
            let value = datas[i]
            let yHeight = chartHeight * CGFloat(value) / CGFloat(maxValue!)
            let y = chartHeight + topMargin - yHeight
            yPoints.append(y)
        }
        let linePath = UIBezierPath()
        linePath.moveToPoint(CGPoint(x: xPoints[0], y: yPoints[0]))
        for var i = 1;i<datas.count;i++
        {
            let point = CGPoint(x: xPoints[i], y: yPoints[i])
            linePath.addLineToPoint(point)
        }
        linePath.lineWidth = 2
        UIColor.whiteColor().setStroke()
        linePath.stroke()
        let fillPath = linePath.copy()
        let lastPoint = xPoints.last
        fillPath.addLineToPoint(CGPoint(x: lastPoint!, y: height-bottomMargin))
        fillPath.addLineToPoint(CGPoint(x: xPoints.first!, y: height-bottomMargin))
        fillPath.closePath()
        fillPath.addClip()

        let topY = yPoints.minElement()
        let graphGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [graphStartColor.CGColor,graphEndColor.CGColor], [0.0,1.0])
        CGContextDrawLinearGradient(context, graphGradient, CGPoint(x: leftMargin, y: topY!), CGPoint(x: leftMargin, y: height-bottomMargin), .DrawsBeforeStartLocation)
        //在调用了addClip后,绘图区域被定在了fillPath的路径内(即渐变的那部分)，所以画圆的时候可能就会只画出一半
        //需要调用CGContextRestoreGState(context)
        CGContextRestoreGState(context)
        UIColor.whiteColor().setFill()
        for var i = 0;i<datas.count;i++
        {
            var rectSize = CGSizeZero
            if i == datas.count-1
            {
                rectSize = CGSize(width: 7, height: 7)
            }
            else
            {
                rectSize = CGSize(width: 5, height: 5)
            }
            var point = CGPoint(x: xPoints[i], y: yPoints[i])
            point.x -= rectSize.width/2
            point.y -= rectSize.width/2
            let circle = UIBezierPath(ovalInRect: CGRect(x: point.x, y: point.y, width: rectSize.width, height: rectSize.height))
            circle.fill()
        }
        let tenThousandYPoint = height - bottomMargin - levelHeight
        UIColor.whiteColor().colorWithAlphaComponent(0.3).setStroke()
        linePath.lineWidth = 1
        linePath.moveToPoint(CGPoint(x: leftMargin, y: topMargin/2))
        linePath.addLineToPoint(CGPoint(x: width-leftMargin, y: topMargin/2))
        linePath.stroke()
        linePath.moveToPoint(CGPoint(x: xPoints[0], y: tenThousandYPoint))
        linePath.addLineToPoint(CGPoint(x: width-leftMargin*3, y: tenThousandYPoint))
        linePath.stroke()
        tenThousandMarkLabel.frame.origin = CGPoint(x: width-leftMargin*3, y: tenThousandYPoint-10)
        tenThousandMarkLabel.frame.size = CGSize(width: 20, height: 20)
        tenThousandMarkLabel.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        tenThousandMarkLabel.text = "1W"
        tenThousandMarkLabel.font = UIFont.systemFontOfSize(12)
        self.addSubview(tenThousandMarkLabel)
        let datesString = DateGenerator.genDates()
        if initialDisplay
        {
            for var i = 0;i<datas.count;i++
            {
                var point = CGPoint(x: xPoints[i], y: height-bottomMargin)
                let dateLabel = UILabel()
                if i == 0
                {
                    dateLabel.frame.origin = point
                    dateLabel.frame.size = CGSize(width: 40, height: 20)
                    dateLabel.text = datesString[i]
                }
                else
                {
                    point.x -= 10
                    dateLabel.center = point
                    dateLabel.frame.size = CGSize(width: 20, height: 20)
                    dateLabel.text = datesString[i]
                    //dateLabel.backgroundColor = UIColor.purpleColor()
                    dateLabel.textAlignment = .Center
                }
                
                dateLabel.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
                dateLabel.font = UIFont.systemFontOfSize(13)
                self.addSubview(dateLabel)
            }
        }
    }
}