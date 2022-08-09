//
//  UIImage+Extension.swift
//  AB_COMMERCE_iOS
//
//  Created by rio on 2022/08/10.
//

import UIKit

extension UIImage {
  
  func mask(with color: UIColor) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
    let context = UIGraphicsGetCurrentContext()!
    
    let rect = CGRect(origin: CGPoint.zero, size: size)
    
    color.setFill()
    self.draw(in: rect)
    
    context.setBlendMode(.sourceIn)
    context.fill(rect)
    
    let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return resultImage
  }
  
}
