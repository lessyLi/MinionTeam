//
//  CanvasViewController.swift
//  MinionTeam
//
//  Created by MacBook on 17.05.2022.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var drawingControl: DrawingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawingControl.addTarget(self, action: #selector(drawingChange), for: .valueChanged)

    }
    
    @objc private func drawingChange() {
        drawingControl.setNeedsDisplay()
        print(drawingControl.shouldDrawRect)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        drawingControl.setNeedsLayout()
        
        // поворот
        drawingControl.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
        // сразу несколько трансформаций
        drawingControl.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4).concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))
        // возврат к начальному состоянию
        drawingControl.transform = .identity
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
