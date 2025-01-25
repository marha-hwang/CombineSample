//
//  Subject.swift
//  CombineSample
//
//  Created by haram on 1/25/25.
//

import Foundation
import Combine

class SubjectExample{
    func callPassthrough(){
        let passthroughSubject = PassthroughSubject<String, Never>()

        let sub1 = passthroughSubject
            .sink(receiveCompletion: { print("1 번째 sink completion: \($0)") },
                  receiveValue: { print("1 번째 sink value: \($0)") })

        passthroughSubject.send(completion: .finished)

        let sub2 = passthroughSubject
            .sink(receiveCompletion: { print("2 번째 sink completion: \($0)") },
                  receiveValue: { print("2 번째 sink value: \($0)") })


        // 현재 Subscriber들에게 모두 보냄
        passthroughSubject.send("두번째 값")

    }
    
    func callCurrentValue(){
        let currentValueSubject = CurrentValueSubject<String, Never>("첫번째 값")

        let sub1 = currentValueSubject
            .sink(receiveCompletion: { print("1 번째 sink completion: \($0)") },
                  receiveValue: { print("1 번째 sink value: \($0)") })

        currentValueSubject.send(completion: .finished)

        let sub2 = currentValueSubject
            .sink(receiveCompletion: { print("2 번째 sink completion: \($0)") },
                  receiveValue: { print("2 번째 sink value: \($0)") })


        // 현재 Subscriber들에게 모두 보냄
        currentValueSubject.send("두번째 값")

        print(currentValueSubject.value)
    }
}
