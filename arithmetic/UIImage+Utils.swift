//
//  UIImage+Utils.swift
//  solomonsforest
//
//  Created by Jay Lee on 2021/04/21.
//

import UIKit
import CoreGraphics

extension UIImage {
    convenience init?(_ named: String) {
        self.init(named: named)
    }
    var dark: UIImage {
        let filter: CIFilter = CIFilter(name: "CIColorControls")!
        filter.setDefaults()
        filter.setValue(CoreImage.CIImage(image: self)!, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(-0.1), forKey: "inputBrightness")
        guard let outputImage = filter.outputImage,
              let cgImage = CIContext(options:nil).createCGImage(outputImage, from: outputImage.extent) else {
            return self
        }
        return UIImage(cgImage: cgImage)
    }
    func convertToGrayScale() -> UIImage {
        let filter: CIFilter = CIFilter(name: "CIPhotoEffectMono")!
        filter.setDefaults()
        filter.setValue(CoreImage.CIImage(image: self)!, forKey: kCIInputImageKey)
        guard let outputImage = filter.outputImage,
              let cgImage = CIContext(options:nil).createCGImage(outputImage, from: outputImage.extent) else {
            return self
        }
        return UIImage(cgImage: cgImage)
    }
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
