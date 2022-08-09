//
//  BaseStackView.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import UIKit

class BaseStackView: UIStackView {
    
    init(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill) {
        super.init(frame: .zero)
        
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

