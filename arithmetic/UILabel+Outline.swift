//
//  UILabel+Outline.swift
//  solomonsforest
//
//  Created by Jay Lee on 2020/12/01.
//

import UIKit
import QuartzCore
extension String {
    func fullRange() -> NSRange {
        return NSRange(location: 0, length: self.count)
    }
}

extension NSAttributedString {
    func outline(_ isOutline: Bool = true,
                 strokeColor: UIColor = .black,
                 width: CGFloat = -5.0) -> NSAttributedString {
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
            .strokeColor : strokeColor,
            .strokeWidth : isOutline ? width : 0,
        ]
        let attributes = self.string.count > 0 ? self.attributes(at: 0, effectiveRange: nil) : [NSAttributedString.Key : Any]()
        let mutableAttributes = NSMutableDictionary()
        mutableAttributes.addEntries(from: attributes)
        mutableAttributes.addEntries(from: strokeTextAttributes)
        let attributedString = NSMutableAttributedString(attributedString: self)
        attributedString.addAttributes(mutableAttributes as! [NSAttributedString.Key : Any], range: attributedString.string.fullRange())
        return attributedString
    }
    static func attributes(_ string: String,
                 font: UIFont = MainFont.bold.with(size: 20.0),
                 color: UIColor = .white,
                 isOutline: Bool = false,
                 outlineColor: UIColor = .black,
                 alignment: NSTextAlignment = .left) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        return NSAttributedString(string: string, attributes: [
            .font: font,
            .foregroundColor: color,
            .kern: 0.0,
            .strokeColor : outlineColor,
            .strokeWidth : isOutline ? -5.0 : 0,
            .paragraphStyle: paragraphStyle,
          ])
    }
}

extension NSMutableAttributedString {
    func appendIcon(_ imageName: String, imageSize: CGSize = .zero, titleFont: UIFont = MainFont.bold.with(size: 12.0))  {
        guard let iconImage = UIImage(named:imageName) else {
            return
        }
        let icon = NSTextAttachment()
        icon.image = iconImage
        var size = imageSize
        if size.equalTo(.zero) {
            size = iconImage.size
        }
        let y = (titleFont.capHeight - size.height).rounded() / 2
        icon.bounds = CGRect(x: 0, y: y, width: size.width, height: size.height)
        self.append(NSAttributedString(attachment: icon))
    }
}
