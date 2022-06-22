//
//  ViewController.swift
//  Reminder
//
//  Created by Maksym Potapov on 19.06.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    // MARK: - Properties -
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addButton"), for: .normal)
        button.addTarget(self, action: #selector(addTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private let titleText: UILabel = {
        let label = UILabel()
        label.font = UIFont.tekoRegular18
        label.textColor = UIColor.clickablesColor
        label.text = "Tap to get started"
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        
        setupLayout()
    }
    
    
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(addButton)
        view.addSubview(titleText)
        addButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(52)
        }
        
        titleText.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(19)
            make.centerX.equalToSuperview()
        }
    }

    
    @objc func addTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2,
                       animations: {
            self.addButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.addButton.transform = CGAffineTransform.identity
            }
        })
        
//        let viewModel = MyRemindersViewModel()
        let viewController = MyRemindersViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
        
        print("done")
    }
}

extension UIButton {

        func pulsate() {

            let pulse = CASpringAnimation(keyPath: "transform.scale")
            pulse.duration = 0.2
            pulse.fromValue = 0.95
            pulse.toValue = 1.0
            pulse.autoreverses = true
            pulse.repeatCount = 2
            pulse.initialVelocity = 0.5
            pulse.damping = 1.0

            layer.add(pulse, forKey: "pulse")
        }

        func flash() {

            let flash = CABasicAnimation(keyPath: "opacity")
            flash.duration = 0.2
            flash.fromValue = 1
            flash.toValue = 0.1
            flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            flash.autoreverses = true
            flash.repeatCount = 3

            layer.add(flash, forKey: nil)
        }


        func shake() {

            let shake = CABasicAnimation(keyPath: "position")
            shake.duration = 0.05
            shake.repeatCount = 2
            shake.autoreverses = true

            let fromPoint = CGPoint(x: center.x - 5, y: center.y)
            let fromValue = NSValue(cgPoint: fromPoint)

            let toPoint = CGPoint(x: center.x + 5, y: center.y)
            let toValue = NSValue(cgPoint: toPoint)

            shake.fromValue = fromValue
            shake.toValue = toValue

            layer.add(shake, forKey: "position")
        }
    }
