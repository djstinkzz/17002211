//
//  DragViewImage.swift
//  Petegameproper
//
//  Created by Pete Smith on 08/06/2020.
//  Copyright © 2020 Pete Smith. All rights reserved.
//

import UIKit
class DragImageView: UIImageView {
    var startLocation: CGPoint? //global variable for starting point
    var myDelegate: subviewDelegate?
    
    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //tells object that one or more new touches has occured in a view or window
        startLocation = touches.first?.location(in:self) //When touch begins, retrieves starting point
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { //tells the responder when one or more touches associated with an event has changed
        
        let currentLocation = touches.first?.location(in:self)
        
        let dx = currentLocation!.x - startLocation!.x
        let dy = currentLocation!.y - startLocation!.y
        var newCenter = CGPoint(x: self.center.x+dx, y: self.center.y+dy)
        
        //Constrains the movement to the phone screen bounds
        
        let halfx = self.bounds.midX    //constraining shooter object x axis
        newCenter.x = max(halfx, newCenter.x)
        newCenter.x = min(self.W*0.2 - halfx, newCenter.x)
        
        let halfy = self.bounds.midY    //constraining shooter object y axis
        newCenter.y = max(self.H*0.5 - self.W*0.1 + halfy, newCenter.y)
        newCenter.y = min(self.H*0.5 + self.W*0.1 - halfy, newCenter.y)
        
        self.center = newCenter
        
        self.myDelegate?.updateDirection(dx: dx*10, dy:dy*10, center: self.center)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { //tells the responder when one or more fingers are raised from a view or window
        self.center = CGPoint(x: W*0.12, y: H*0.5)
        
        self.myDelegate?.releaseBall() //links the release ball function to the cocoaTouch class
}

}
