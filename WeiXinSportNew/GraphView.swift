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
    override func drawRect(rect: CGRect) {
        let datas = [4123,10345,888,5689,2356,3598,1246]
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
        let topMargin:CGFloat = 30
        let bottomMargin:CGFloat = 30
        let chartHeight = height - topMargin - bottomMargin
        let maxValue = datas.maxElement()
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
        //UIColor.whiteColor().setFill()
//        let rectPath = UIBezierPath(rect: self.bounds)
//        rectPath.fill()
        //fillPath.fill()
        let topY = yPoints.minElement()
        print(CGPoint(x: leftMargin, y: topY!),CGPoint(x: leftMargin, y: height-bottomMargin))
        let graphGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [graphStartColor.CGColor,graphEndColor.CGColor], [0.0,1.0])
        CGContextDrawLinearGradient(context, graphGradient, CGPoint(x: leftMargin, y: topY!), CGPoint(x: leftMargin, y: height-bottomMargin/1.5), .DrawsBeforeStartLocation)
        CGContextRestoreGState(context)
        UIColor.whiteColor().setFill()
        for var i = 0;i<datas.count;i++
        {
            var point = CGPoint(x: xPoints[i], y: yPoints[i])
            point.x -= 5/2
            point.y -= 5/2
            let circle = UIBezierPath(ovalInRect: CGRect(x: point.x, y: point.y, width: 5, height: 5))
            circle.fill()
        }
    }
}