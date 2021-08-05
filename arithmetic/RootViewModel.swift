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
    init(withModel model: RootModel = RootModel()) {
        self.model = model
    }
}
