//
//  RootViewController.swift
//  arithmetic
//
//  Created by Jay Lee on 2021/08/05.
//

import UIKit
import Combine
import Haptica

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
    @IBOutlet weak var problemLabel: UILabel!
    @IBOutlet weak var answerStack: UIStackView!
    @IBOutlet weak var place1Answer: UILabel!
    @IBOutlet weak var place10Answer: UILabel!
    @IBOutlet weak var place100Answer: UILabel!
    @IBOutlet weak var place1000Answer: UILabel!
    @IBOutlet weak var setButton: UIButton!
    @IBOutlet weak var place1Button: UIButton!
    @IBOutlet weak var place10Button: UIButton!
    @IBOutlet weak var place100Button: UIButton!
    @IBOutlet weak var place1000Button: UIButton!
    @IBOutlet var places: [UIView]!
    @IBOutlet weak var place1: UIView!
    @IBOutlet weak var place10: UIView!
    @IBOutlet weak var place100: UIView!
    @IBOutlet weak var place1000: UIView!
    @IBOutlet weak var examplesStack: UIStackView!
    @IBOutlet weak var scoreBoardButton: UIButton!
    @IBOutlet weak var scoreBoard: UILabel!
    var scoreCount: Int = 0
    var totalCount: Int = 0
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
        for v in self.places {
            v.layer.cornerRadius = 5.0
            v.layer.masksToBounds = true
        }
        line.layer.cornerRadius = line.bounds.size.height/2.0
        test()
        setScoreBoard()
    }
    func binded() {
        //Do bind.
        self.setButton.publisher(for: .touchUpInside).sink { button in
            self.test()
        }.store(in: &self.subscriptions)
    }
    func test() {
        self.viewModel.next()
        self.examplesStack.removeAllArrangedSubviews()
        for v in self.places {
            v.isHidden = v.tag != 1
            v.backgroundColor = .clear
            (v.subviews.first { view in
                return type(of: view) == UILabel.self
            } as? UILabel)?.textColor = .label
        }
        self.problemLabel.text = self.viewModel.currentArithmetic?.problem()
        if let hiddenInteger = answer(numbers: self.viewModel.currentArithmetic?.answer()) {
            print("Hidden Integer = \(hiddenInteger)")
            let examples = self.viewModel.examples(collectedAnswer: hiddenInteger)
            print(examples)
            for e in examples {
                let button = UIButton(type: .custom)
                let normalText = NSAttributedString.attributes("\(e)", font: MainFont.bold.defaultSize(), color: .systemBackground)
                let highlightedText = NSAttributedString.attributes("\(e)", font: MainFont.bold.defaultSize(), color: .label)
                button.backgroundColor = .label
                button.tag = e
                button.setAttributedTitle(normalText, for: .normal)
                button.setAttributedTitle(highlightedText, for: .highlighted)
                button.setAttributedTitle(highlightedText, for: .selected)
                button.setBackgroundImage(UIImage(color: .label), for: .normal)
                button.setBackgroundImage(UIImage(color: .systemBackground), for: .highlighted)
                button.setBackgroundImage(UIImage(color: .systemBackground), for: .selected)
                button.layer.cornerRadius = 5.0
                button.layer.masksToBounds = true
                button.addTarget(self, action: #selector(selectedAnswer(_:)), for: .touchUpInside)
                self.examplesStack.addArrangedSubview(button)
            }
        } else {
            self.test()
        }
    }
    @objc func selectedAnswer(_ sender: UIButton?) {
        guard let button = sender else {
            return
        }
        self.totalCount += 1
        print("Answer: \(button.tag)")
        let hiddenPlace = self.places[self.viewModel.currentHiddenIndex]
        var alert = "정답입니다!"
        if self.viewModel.currentHiddenIntegers[self.viewModel.currentHiddenIndex] == button.tag {
            print("Right!")
            hiddenPlace.backgroundColor = .clear
            sender?.isSelected = true
            self.scoreCount += 1
            Haptic.play("..oO-oO-oO-oO-oO-Oo..", delay: 0.1)
        } else {
            alert = "틀렸습니다!"
            print("Wrong!")
            sender?.isSelected = true
            hiddenPlace.backgroundColor = .red
            let hiddenLabel = hiddenPlace.subviews.first { view in
                return type(of: view) == UILabel.self
            } as? UILabel
            Haptic.impact(.heavy).generate()
            UIView.animate(withDuration: 0.8) {
                hiddenLabel?.textColor = .systemBackground
            }
        }
        for button in self.examplesStack.arrangedSubviews {
            button.isUserInteractionEnabled = false
        }
        self.setScoreBoard()
        Alert.shared.alert(
            title: alert, alertAction: AlertAction(
                title: "다음", style: .default, handler: { [weak self] _ in
            self?.test()
        })).show()
    }
    func setScoreBoard() {
        let size: CGFloat = 20
        let firstText = "RIGHT:\(self.scoreCount)\n"
        let middleText = "WRONG:\(self.totalCount - self.scoreCount)\n"
        let lastText = "TOTAL:\(self.totalCount)"
        let text = NSMutableAttributedString(
            attributedString: NSAttributedString.attributes(
                "\(firstText)\(middleText)\(lastText)",
                font: MainFont.bold.with(size: size),  color: .label
            )
        )
        text.addAttributes([
            .font: MainFont.bold.with(size: size),
            .foregroundColor: UIColor.systemRed
        ], range: NSRange(location: firstText.count, length: middleText.count))
        self.scoreBoard.attributedText = text
    }
}
extension RootViewController {
    func answer(numbers: [String]?) -> Int? {
        guard let numbers = numbers else {
            return nil
        }
        var place: Int = 0
        let count = numbers.count
        switch count {
        case 1:
            place1Answer.text = numbers[0]
            place = 1
        case 2:
            place1Answer.text = numbers[0]
            place10Answer.text = numbers[1]
            place = 10
        case 3:
            place1Answer.text = numbers[0]
            place10Answer.text = numbers[1]
            place100Answer.text = numbers[2]
            place = 100
        case 4:
            place1Answer.text = numbers[0]
            place10Answer.text = numbers[1]
            place100Answer.text = numbers[2]
            place1000Answer.text = numbers[3]
            place = 1000
        default:
            break
        }
        for v in self.places {
            v.isHidden = v.tag > place
            v.backgroundColor = .clear
        }
        let hiddenIndex = Int(arc4random()) % count
        self.places[hiddenIndex].backgroundColor = .label
        let hiddenPlace = self.places[hiddenIndex]
        let hiddenLabel = hiddenPlace.subviews.first { view in
            return type(of: view) == UILabel.self
        } as? UILabel
        print("Hidden number = \(hiddenLabel?.text ?? "")")
        let hiddenInteger =  Int(hiddenLabel?.text ?? "")
        self.viewModel.currentHiddenIndexs.append(hiddenIndex)
        self.viewModel.currentHiddenIntegers[hiddenIndex] = hiddenInteger
        self.viewModel.currentHiddenIndex = hiddenIndex
        return hiddenInteger
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
private extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
            NSLayoutConstraint.deactivate($0.constraints)
            $0.removeFromSuperview()
        }
    }
}
