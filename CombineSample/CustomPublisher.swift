//
//  CustomPublisher.swift
//  CombineSample
//
//  Created by haram on 1/20/25.
//

import Foundation
import Combine

// 커스텀 Publisher 클래스
class CustomPublisher: Publisher {
    
    typealias Output = String
    typealias Failure = Never
    
    var value: Output {
        didSet{
            subscriptions.forEach{
                $0.value = value
                $0.request(.max(1))
            }
        }
    }
    private var subscriptions:[CustomSubscription] = []
    
    init(value: Output) {
        self.value = value
    }
    
    // 구독자가 이 Publisher를 구독할 때 호출되는 메서드
    func receive<S>(subscriber: S) where S : Subscriber, S.Input == Output, S.Failure == Failure {
        
        guard let customSubscriber = subscriber as? CustomSubscriber else {
            return
        }
        
        let subscription = CustomSubscription(subscriber: customSubscriber, value: self.value)
        subscriptions.append(subscription)
        subscriber.receive(subscription: subscription)
    }
}

// 구독자 구현
class CustomSubscriber: Subscriber, Cancellable {
    
    typealias Input = String
    typealias Failure = Never
    
    private var subscription: Subscription?
    
    func receive(subscription: Subscription) {
        self.subscription = subscription
        subscription.request(.max(1))  // 한 번만 값 요청
    }
    
    func receive(_ input: Input) -> Subscribers.Demand {
        print("Received value: \(input)")
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Failure>) {
        print("Completion received.")
    }
    
    func cancel() {
        subscription?.cancel()
    }
}

// 구독자에게 값을 발행하는 Subscription 클래스
class CustomSubscription:Subscription{
    
    typealias T = String
    
    private var subscriber:CustomSubscriber?
    var value:T
    
    init(subscriber: CustomSubscriber, value:T) {
        self.subscriber = subscriber
        self.value = value
    }
    
    func request(_ demand: Subscribers.Demand) {
        _ = subscriber?.receive(value)
    }
    
    func cancel() {
        subscriber?.receive(completion: .finished)
        subscriber = nil
        
    }
}
