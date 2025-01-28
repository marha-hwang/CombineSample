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

//let pub = CustomPublisher(value: "value1")
//let sub1 = CustomSubscriber()
//
//pub.subscribe(sub1)
//pub.send("value2")
//pub.send("value3")


let weather = Weather(temperature: 20)
let cancellable = weather.$temperature
    .sink() {_ in 
        print ("Temperature now: \(weather.temperature)")
}
weather.temperature = 25
