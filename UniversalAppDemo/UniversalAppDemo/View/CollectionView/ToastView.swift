//
//  ToastView.swift
//  UniversalAppDemo
//
//  Created by Harsha on 23/04/2023.
//

import Foundation
import UIKit

class ToastView: UIView {
    
    private let messageLabel = UILabel()
    
    init(message: String) {
        super.init(frame: .zero)
        
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.textAlignment = .center
        
        backgroundColor = UIColor.red.withAlphaComponent(0.6)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        guard let window = UIApplication.shared.windows.first else { return }
        window.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: window.centerXAnchor),
            bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -80)
        ])
        
        // Fade in and out animation
        alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 2, animations: {
                self.alpha = 0
            }, completion: { _ in
                self.removeFromSuperview()
            })
        }
    }
}
