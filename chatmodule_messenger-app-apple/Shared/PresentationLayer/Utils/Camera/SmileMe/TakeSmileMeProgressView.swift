//
//  TakeSmileMeProgressView.swift
//  ChatModuleMessengerAppApple
//

import UIKit
import ChatModuleMessengerUI

class TakeSmileMeProgressView: UIView {
    let tm = ThemeManager()
    var gradientFrame = CGRect()
    lazy var viewCenter = CGPoint(x: self.gradientFrame.size.width/2, y: self.gradientFrame.size.height/2)
    lazy var radius = CGFloat(gradientFrame.width/2)

    var line = CAShapeLayer()
    var lastline = CAShapeLayer()
    var outline = CAShapeLayer()
    var outlinegradiant = CAGradientLayer()
    var gradient = CAGradientLayer()
    var stopIcon = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.gradientFrame = self.bounds

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        // 그라데이션 라인 설정
        let circlePath = UIBezierPath(arcCenter: center, radius: radius-3, startAngle: CGFloat(Double.pi*(-0.5)),
                                      endAngle: CGFloat(Double.pi*(-0.5)), clockwise: true)
        line.path = circlePath.cgPath
        line.fillColor = UIColor.clear.cgColor
        line.strokeColor = UIColor.red.cgColor
        line.lineWidth = 6
        line.lineCap = .round

        // 바깥쪽 라인 설정
        let outSidePath = UIBezierPath(arcCenter: self.center, radius: radius-3, startAngle: CGFloat(Double.pi*(-0.5)),
                                       endAngle: CGFloat(Double.pi*(1.5)), clockwise: true)
        outline.path = outSidePath.cgPath
        outline.fillColor = UIColor.clear.cgColor
//        outline.strokeColor = UIColor.ChatModuleVeryLightPinkTwo.cgColor
        outline.strokeColor = UIColor(tm.theme.labelColorSecondary).cgColor
        outline.lineWidth = 6
        outline.lineCap = .round
        self.layer.addSublayer(outline)

        // 그라데이션 마스크
        gradient.frame = gradientFrame
//        gradient.colors = [UIColor.ChatModuleVioletPink.cgColor, UIColor.ChatModulePrimaryMain.cgColor]
        gradient.colors = [UIColor(tm.theme.linear00Start).cgColor, UIColor(tm.theme.linear00End).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.mask = line
        self.layer.addSublayer(gradient)

        updatePercent(progress: 0)
        self.isUserInteractionEnabled = false
    }

    func updatePercent(progress: Double) {

        let endAngle = CGFloat(Double.pi*(-0.5)+2*Double.pi*progress*0.01)
        let circlePath = UIBezierPath(arcCenter: self.center, radius: self.radius-3, startAngle: CGFloat(Double.pi*(-0.5)),
                                      endAngle: endAngle, clockwise: true)
        self.line.path = circlePath.cgPath
    }
}
