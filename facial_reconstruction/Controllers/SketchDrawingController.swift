//
//  SketchDrawingController.swift
//  facial_reconstruction
//
//  Created by Pavel Yarovoi on 01.05.2022.
//

import UIKit

class SketchDrawingController: UIViewController {

    let sketchDrawingView = SketchDrawingView()
    
    var lastPoint = CGPoint.zero
    var swiped = false

    var doAfterDrawing: ((UIImage) -> Void)?
    
    override func loadView() {
        view = sketchDrawingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sketchDrawingView.setupButtonSelector(
            button: self.sketchDrawingView.goToBackButton,
            selector: #selector(goBack(_:))
        )
        self.sketchDrawingView.setupButtonSelector(
            button: self.sketchDrawingView.clearButton,
            selector: #selector(clear(_:))
        )
        self.sketchDrawingView.clearButton.addTarget(nil, action: #selector(clear(_:)), for: .touchUpOutside)
        self.sketchDrawingView.brushThicknessSlider.addTarget(nil, action: #selector(changeBrushThicknessValue(_:)), for: .valueChanged)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.sketchDrawingView.skethImageView.image = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: view)
            drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
       
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
        }
       
        UIGraphicsBeginImageContext(sketchDrawingView.skethImageView.frame.size)
        sketchDrawingView.skethImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: .normal, alpha: 1.0)
        UIGraphicsEndImageContext()
       
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        sketchDrawingView.skethImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
     
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setLineCap(.round)
        context?.setLineWidth(CGFloat(self.sketchDrawingView.brushThicknessSlider.value))
        context?.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        context?.setBlendMode(.normal)
     
        context?.strokePath()
     
        sketchDrawingView.skethImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        sketchDrawingView.skethImageView.alpha = 1.0
        UIGraphicsEndImageContext()
    }
    
    @objc func clear(_ sender: UIBarButtonItem) {
        sketchDrawingView.skethImageView.image = nil
    }
    
    @objc func goBack(_ sender: UIBarButtonItem) {
        doAfterDrawing?(sketchDrawingView.skethImageView.image ?? UIImage())
        navigationController?.popViewController(animated: true)
    }
    
    @objc func changeBrushThicknessValue(_ sender: UISlider) {
        sketchDrawingView.brushThicknessValue.text = "\(Int(sketchDrawingView.brushThicknessSlider.value))"
    }

}
