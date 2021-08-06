//
//  AlertView.swift
//  solomonsforest
//
//  Created by Jay Lee on 2021/02/18.
//

import UIKit
import Combine
import SwiftEntryKit

#if canImport(SwiftEntryKit)
class AlertView: NibView {
    private var subscriptions = Set<AnyCancellable>()
    var alertAction: AlertAction?
    {
        didSet {
            let text = NSAttributedString.attributes(alertAction?.title ?? "", color: .label)
            self.nextButton.setAttributedTitle(text, for: .normal)
            self.nextButton.publisher(for: .touchUpInside).sink { [unowned alertAction] button in
                guard let alertAction = alertAction else {
                    return
                }
                alertAction.handler?(alertAction)
                SwiftEntryKit.dismiss()
            }.store(in: &self.subscriptions)
        }
    }
    var title: String? {
        didSet {
            self.textLabel.attributedText = NSAttributedString.attributes(title ?? "", color: .systemBackground)
        }
    }
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    override func setup() {
        fromNib()
        super.setup()
        self.nextButton.layer.cornerRadius = 5.0
    }
    func show() {
        Alert.shared.show(alert: self, type: .bottom)
    }
}
#endif
