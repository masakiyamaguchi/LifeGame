//
//  ViewController.swift
//  LifeGame
//
//  Created by 山口将槻 on 2015/12/04.
//  Copyright © 2015年 山口将槻. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    var gridView:map = map()
    var step:Int = 0
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var clear: UIButton!
    @IBOutlet weak var stepLabel: UILabel!
    
    var timer:NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let wid = UIScreen.mainScreen().bounds.width
        self.gridView = map(frame: CGRectMake(2, 20, wid-4, wid-4))
        gridView.opaque = false
        gridView.backgroundColor = UIColor.clearColor()
        gridView.userInteractionEnabled = true
        gridView.tag = 1
        self.view.addSubview(gridView)
        
        self.stepLabel.text = String(self.step) + "step"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearMap(sender: AnyObject) {
        self.step = 0
        app.stage.life = 0
        self.stepLabel.text = String(self.step) + "step"
        app.stage.clearAll()
        drawCell()
    }
    
    @IBAction func playGame(sender: AnyObject) {
        if self.timer.valid {
            self.timer.invalidate()
            self.playButton.setTitle("play", forState: UIControlState.Normal)
        }else{
            timer = NSTimer(timeInterval: 0.2, target: self, selector: "timer:", userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
            self.playButton.setTitle("stop", forState: UIControlState.Normal)
        }
    }
    
    @objc func timer(timer:NSTimer){
        self.step++
        self.stepLabel.text = String(self.step) + "step"
        app.stage.setNextStep()
        drawCell()
    }
    
    func drawCell(){
        for var v in self.gridView.subviews {
            v.removeFromSuperview()
        }
        let cellView = cell(frame: CGRectMake(0.0, 0.0, gridView.frame.width, gridView.frame.height))
        cellView.opaque = false
        cellView.backgroundColor = UIColor.clearColor()
        cellView.tag = 1
        cellView.userInteractionEnabled = true
        self.gridView.addSubview(cellView)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for var v in touches {
            if v.view!.tag == 1 {
                let location = v.locationInView(self.view)
                let k = self.gridView.frame.width/CGFloat(app.stage.size)
                let x = Int(location.x/k)
                let y = Int(location.y/k)
                app.stage.setCell(x, y: y)
                drawCell()
            }
        }
    }

}

class map: UIView {
    
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        let cellsize = (rect.width/CGFloat(app.stage.size))
        
        for var i in 0...app.stage.size-1 {
            let margin = cellsize*CGFloat(i)
            path.moveToPoint(CGPointMake(margin, 0.0))
            path.addLineToPoint(CGPointMake(margin, rect.height))
            UIColor(red: 5.0/255.0, green: 1.0, blue: 5.0/255.0, alpha: 1.0).setStroke()
            path.lineWidth = 1.0
            path.stroke()
            
            path.moveToPoint(CGPointMake(0.0, margin))
            path.addLineToPoint(CGPointMake(rect.width, margin))
            UIColor(red: 5.0/255.0, green: 1.0, blue: 5.0/255.0, alpha: 1.0).setStroke()
            path.lineWidth = 1.0
            path.stroke()
        }
    }
    
}

class cell: UIView {
    
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func drawRect(rect: CGRect) {
        let rect = (UIScreen.mainScreen().bounds.width-4)/CGFloat(app.stage.size)
        
        app.stage.life = 0
        for var i in 0...app.stage.size-1 {
            for var j in 0...app.stage.size-1 {
                if app.stage.getStatus(j, y: i) {
                    app.stage.life++
                    let path = UIBezierPath(rect: CGRectMake(rect*CGFloat(j), rect*CGFloat(i), rect, rect))
                    UIColor(red: 5.0/255.0, green: 255.0, blue: 5.0/255.0, alpha: 1.0).setFill()
                    UIColor(red: 5.0/255.0, green: 255.0, blue: 5.0/255.0, alpha: 1.0).setStroke()
                    path.fill()
                    path.lineWidth = 1
                    path.stroke()
                }
            }
        }
    }
}
