//
//  RootViewModel.swift
//  arithmetic
//
//  Created by Jay Lee on 2021/08/05.
//

import Foundation
import Combine

/**
 ## 클래스 설명
 * RootViewModel
 * <# 요약 #>
 
 ## 기본정보
 * Note: APP
 * See: <# 제플린 없음 #>
 * Author: Jay Lee
 * Since: 2021/08/05
 */
class RootViewModel {
    private let model: RootModel
    private var subscriptions = Set<AnyCancellable>()
    var currentArithmetic: Arithmetic? {
        didSet {
            guard let arithmetic = currentArithmetic else {
                return
            }
            self.model.list.append(arithmetic)
        }
    }
    var currentHiddenIndexs = [Int]()
    var currentHiddenIndex: Int = -1
    var currentHiddenIntegers = [Int: Int]()
    init(withModel model: RootModel = RootModel()) {
        self.model = model
        self.next()
    }
}
extension RootViewModel {
    func makePlusMinus() -> Arithmetic {
        let random1 = arc4random()%100
        let random2 = arc4random()%100
        let operation = Bool.random() ? "+":"-"
        var result: UInt32 = 0
        if operation == "+" {
            result = random1 + random2
            return Arithmetic(first: random1, second: random2, operation: operation, collectAnswer: result)
        } else {
            let max = max(random1, random2)
            let min = min(random1, random2)
            result = max - min
            return Arithmetic(first: max, second: min, operation: operation, collectAnswer: result)
        }
    }
    func next() {
        self.currentArithmetic = self.makePlusMinus()
    }
    func examples(collectedAnswer: Int, length: Int = 5) -> [Int] {
        var set = Set<Int>()
        set.insert(collectedAnswer)
        while set.count < length {
            set.insert(Int(arc4random()%10))
        }
        return Array(set)
    }
}
