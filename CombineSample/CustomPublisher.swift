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
                $0.request(.none)
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
    
    func send(_ input:String){
        self.value = input
    }
    
    // 구독자에게 값을 발행하는 Subscription 클래스
    class CustomSubscription:Subscription{
        
        typealias T = String
        
        var subscriber:CustomSubscriber?
        private var total_demand:Subscribers.Demand = .none
        private var now_demand:Subscribers.Demand = .none
        
        var value:T
        
        init(subscriber: CustomSubscriber, value:T) {
            self.subscriber = subscriber
            self.value = value
        }
        
        func request(_ demand: Subscribers.Demand) {
            
            total_demand += demand
            
            if total_demand <= now_demand{
                subscriber?.receive(completion: .finished)
                return
            }
            
            _ = subscriber?.receive(value)
            now_demand += 1
        }
        
        func cancel() {
            subscriber = nil
        }
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
        cancel()
    }
    
    func cancel() {
        subscription?.cancel()
    }
}
