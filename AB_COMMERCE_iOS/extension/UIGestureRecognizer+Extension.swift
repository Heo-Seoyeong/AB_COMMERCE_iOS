//
//  UIGestureRecognizer+Extension.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/08.
//

import UIKit

extension UIGestureRecognizer {
    
    enum type {
        case tap
        case pinch
        case ratation
        case swipe
        case pan
        case screenEdgePan
        case longPress
        
        var value: UIGestureRecognizer {
            switch self {
            case .tap: return UITapGestureRecognizer()
            case .pinch: return UIPinchGestureRecognizer()
            case .ratation: return UIRotationGestureRecognizer()
            case .swipe: return UISwipeGestureRecognizer()
            case .pan: return UIPanGestureRecognizer()
            case .screenEdgePan: return UIScreenEdgePanGestureRecognizer()
            case .longPress: return UILongPressGestureRecognizer()
            }
        }
    }
        
}
