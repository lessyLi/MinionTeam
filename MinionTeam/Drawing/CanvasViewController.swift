//
//  CanvasViewController.swift
//  MinionTeam
//
//  Created by MacBook on 17.05.2022.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var drawingControl: DrawingControl!
    @IBOutlet var yellowView: UIView!
    @IBOutlet var blueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blueView.frame = CGRect(x: 50, y: 200, width: 100, height: 200)
        yellowView.frame = blueView.frame
        
        let rotation = CGAffineTransform(rotationAngle: -.pi/2)
        let translation = CGAffineTransform(translationX: 1.5 * blueView.frame.width, y: -0.5 * blueView.frame.width)
        
        yellowView.transform = rotation.concatenating(translation)
        
    
        
//        drawingControl.addTarget(self, action: #selector(drawingChange), for: .valueChanged)
        
        

    }
    
    @objc private func drawingChange() {
        drawingControl.setNeedsDisplay()
        print(drawingControl.shouldDrawRect)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        drawingControl.setNeedsLayout()
    
//        // поворот
//        drawingControl.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
//        // сразу несколько трансформаций
//        drawingControl.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4).concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))
//        // возврат к начальному состоянию
//        drawingControl.transform = .identity
        
    }
    
    @IBAction func animate() {
        
        UIView.animateKeyframes(withDuration: 6, delay: 0, options: .calculationModePaced, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                let rotation = CGAffineTransform(rotationAngle: .pi/4)
                let translation = CGAffineTransform(translationX: -0.5 * self.blueView.frame.width, y: -0.5 * self.blueView.frame.width)
                self.blueView.transform = rotation.concatenating(translation)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4) {
                let rotation = CGAffineTransform(rotationAngle: -.pi/8)
                let translation = CGAffineTransform(translationX: 0.5 * self.blueView.frame.width, y: -0.2 * self.blueView.frame.width)
                self.yellowView.transform = rotation.concatenating(translation)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3) {
                // обратно
                self.yellowView.transform = .identity
            }
        })

        
//        // поворот
//        yellowView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
//        // сразу несколько трансформаций
//        yellowView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4).concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))
//        // возврат к начальному состоянию
//        yellowView.transform = .identity
    }

}
