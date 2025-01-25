//
//  main.swift
//  CombineSample
//
//  Created by haram on 1/20/25.
//

import Foundation
import Combine

//// 커스텀 Publisher 사용 예시
//let publisher = CustomPublisher(value: "구독을 시작했어요~~")
//let subscriber = CustomSubscriber()
//
//publisher.receive(subscriber: subscriber)
//publisher.value = "구독 메시지를 발행했어요~"
//
//
//publisher.sink(receiveValue: {_ in }).cancel()
//
//publisher.value = "구독을 취소했어요~"

//SubjectExample().callPassthrough()
SubjectExample().callCurrentValue()

