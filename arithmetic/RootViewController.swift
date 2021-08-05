//
//  RootViewController.swift
//  arithmetic
//
//  Created by Jay Lee on 2021/08/05.
//

import UIKit
import Combine

/**
 ## 클래스 설명
 * RootViewController
 * <# 요약 #>
 
 ## 기본정보
 * Note: APP
 * See: <# 제플린 없음 #>
 * Author:  Jay Lee
 * Since: 2021/08/05 
 */
class RootViewController: UIViewController {
    private let viewModel: RootViewModel
    private var subscriptions = Set<AnyCancellable>()
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var problem: UILabel!
    @IBOutlet weak var answer: UIStackView!
    @IBOutlet weak var place1Answer: UILabel!
    @IBOutlet weak var place10Answer: UILabel!
    @IBOutlet weak var place100Answer: UILabel!
    @IBOutlet weak var place1000Answer: UILabel!
    @IBOutlet weak var place1Button: UIButton!
    @IBOutlet weak var place10Button: UIButton!
    @IBOutlet weak var place100Button: UIButton!
    @IBOutlet weak var place1000Button: UIButton!
    @IBOutlet var places: [UIView]!
    @IBOutlet weak var place1: UIView!
    @IBOutlet weak var place10: UIView!
    @IBOutlet weak var place100: UIView!
    @IBOutlet weak var place1000: UIView!
    init(nibName: String?) {
        viewModel = RootViewModel()
        super.init(nibName: nibName, bundle: nil)
    }
    required init?(coder: NSCoder) {
        viewModel = RootViewModel()
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initialized()
        binded()
    }
    func initialized() {
        //Do initalize.
        line.layer.cornerRadius = line.bounds.size.height/2.0
//        for v in self.places {
//            v.isHidden = v.tag != 1
//        }
    }
    func binded() {
        //Do bind.
    }
}
//MARK: Class method
/**
extension RootViewController {
    static func instance() -> RootViewController {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RootViewController") as? RootViewController else {
            fatalError("Failed load RootViewController in storyboard.")
        }
        return vc
    }
}
*/
