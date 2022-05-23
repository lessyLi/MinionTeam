//
//  DrawingControl.swift
//  MinionTeam
//
//  Created by MacBook on 17.05.2022.
//

import UIKit

//@IBDesignable

class DrawingControl: UIControl {

    @IBInspectable var shouldDrawRect: Bool = true
    
    // MARK: - Жесты
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGesture()
    }
    
    private func setupGesture() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        swipe.direction = .left
        addGestureRecognizer(swipe)
    }
    
    @objc private func swiped(_ swipeGesture: UISwipeGestureRecognizer) {
        shouldDrawRect.toggle()
        
        sendActions(for: .valueChanged)
    }
    
    // MARK: - Рисование
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // создаем холст
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        // рисуем с помощью стандартного объекта
        
        if shouldDrawRect {
            let color: UIColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            context.setFillColor(color.cgColor)
        }
        
        /// сохраняет настройки цвета, которые выше
        context.saveGState()
        
        if shouldDrawRect {
            let rectangleRed = CGRect(x: rect.width/2, y: rect.height/2, width: rect.width/4, height: rect.height/4)
            
            context.fill(rectangleRed)
        }
        
        
        // Рисуем с помощью вручную заданных координат
        context.move(to: CGPoint(x: rect.width/2, y: 0))
        context.addLine(to: CGPoint(x: rect.width/2, y: rect.height/2))
        context.addLine(to: CGPoint(x: 0, y: rect.height/2))
        
        context.closePath()
        
        context.setFillColor(UIColor.yellow.cgColor)
        context.setStrokeColor(UIColor.yellow.cgColor)
        
        context.strokePath()
        
        // Рисуем с помощью кривой Безье
        
        /// сбрасывает настройки цвета до сохраненных выше
        context.restoreGState()
        
        let triangle = UIBezierPath()
        triangle.move(to: CGPoint(x: 0, y: rect.height/2))
        triangle.addLine(to: CGPoint(x: 0, y: rect.height))
        triangle.addLine(to: CGPoint(x: rect.width/2, y: rect.height))
        
        triangle.close()
        
        context.addPath(triangle.cgPath)
        context.fillPath()
        
        // Работа со слоем
        
        /// тень
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.shadowOpacity = 1
    }
    

}
