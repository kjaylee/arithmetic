//
//  RootModel.swift
//  arithmetic
//
//  Created by Jay Lee on 2021/08/05.
//

import Foundation
import Combine
/**
 ## 클래스 설명
 * RootModel
 * <# 요약 #>
 
 ## 기본정보
 * Note: APP
 * See: <# 제플린 없음 #>
 * Author: Jay Lee
 * Since: 2021/08/05
 */
class RootModel {
    @Published var list = [Arithmetic]()
    @Published var wrongList = [Problem]()
}

struct Problem {
    let arithmetic: Arithmetic
    let hiddenIndex: Int
}

struct Arithmetic {
    let first: UInt32
    let second: UInt32
    let operation: String
    let collectAnswer: UInt32
    var isCollected: Bool = false
    func problem() -> String {
        return "\(first)\n\(operation) \(second)"
    }
    func answer() -> [String] {
        var result = [String]()
        var v = collectAnswer
        if v == 0 {
            result = ["0"]
        } 
        while v != 0 {
            let r = v % 10
            result.append("\(r)")
            v = v / 10
        }
        return result
    }
}
