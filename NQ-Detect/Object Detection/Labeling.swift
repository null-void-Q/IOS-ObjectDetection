//
//  Labeling.swift
//  NQ Detect
//
//  Created by NULL on 10/9/22.
//

import Foundation
import SwiftUI

class Labeling{
    
    private var labelColors: [String: CGColor] = [:]
    
    
    init(){
        self.labelColors = self.generateLabelColors()
    }
    
    func labelImage(image:UIImage,observations:[ProcessedObservation]) -> UIImage?{
        // setting up context
        UIGraphicsBeginImageContext(image.size)
        // image is drawn as background in current context
        image.draw(at: CGPoint.zero)
        // Get the current context
        let context = UIGraphicsGetCurrentContext()!
        
        
        for observation in observations{
            let labelColor = labelColors[observation.label]!
            let label = observation.label + " " + String(format:"%.1f",observation.confidence*100)+"%"
            let boundingBox = observation.boundingBox
            
            self.drawBox(context: context, bounds: boundingBox, color: labelColor)
            
            let textBounds = getTextRect(bigBox: boundingBox)
            
            self.drawTextBox(context: context, drawText: label, bounds: textBounds, color: labelColor)
            
        }
        
        // Save the context as a new UIImage
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Return modified image
        return myImage
    }
    
    
    func drawBox(context:CGContext, bounds:CGRect, color:CGColor){
        context.setStrokeColor(color)
        context.setLineWidth(bounds.height*0.02)
        context.addRect(bounds)
        context.drawPath(using: .stroke)
    }
    func getTextRect(bigBox:CGRect) -> CGRect{
        let width = bigBox.width*0.45
        let height = bigBox.height*0.09
        return CGRect(x: bigBox.minX, y: bigBox.minY - height, width: width, height: height)
    }
    func drawTextBox(context:CGContext ,drawText text: String, bounds:CGRect ,color:CGColor) {
        
        //text box
        context.setFillColor(color)
        context.addRect(bounds)
        context.drawPath(using: .fill)
        
        //text
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: bounds.height*0.45)!
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor
        ] as [NSAttributedString.Key : Any]
        
        text.draw(in: bounds.offsetBy(dx: bounds.width*0.05, dy: bounds.height*0.05), withAttributes: textFontAttributes)
        
    }
    
    let labels = ["person", "bicycle", "car", "motorcycle", "airplane", "bus", "train", "truck", "boat", "traffic light", "fire hydrant", "stop sign", "parking meter", "bench", "bird", "cat", "dog", "horse", "sheep", "cow", "elephant", "bear", "zebra", "giraffe", "backpack", "umbrella", "handbag", "tie", "suitcase", "frisbee", "skis", "snowboard", "sports ball", "kite", "baseball bat", "baseball glove", "skateboard", "surfboard", "tennis racket", "bottle", "wine glass", "cup", "fork", "knife", "spoon", "bowl", "banana", "apple", "sandwich", "orange", "broccoli", "carrot", "hot dog", "pizza", "donut", "cake", "chair", "couch", "potted plant", "bed", "dining table", "toilet", "tv", "laptop", "mouse", "remote", "keyboard", "cell phone", "microwave", "oven", "toaster", "sink", "refrigerator", "book", "clock", "vase", "scissors", "teddy bear", "hair drier", "toothbrush"]
    
    func generateLabelColors() -> [String: CGColor] {
        var labelColor: [String: CGColor] = [:]
        
        for i in 0...79 {
            let color = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
            labelColor[self.labels[i]] = color.cgColor
        }
        
        return labelColor
    }
    
}

