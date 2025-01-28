//
//  Published.swift
//  CombineSample
//
//  Created by haram on 1/28/25.
//

import Foundation
import Combine

class Weather {
    @Published public var temperature: Double
    init(temperature: Double) {
        self.temperature = temperature
    }
}

class Example{
    @Print var name = ""
    
    @propertyWrapper
    struct Print {
        private var _value:String
        
        var wrappedValue:String {
            get { 
                print(_value)
                return _value
            }
            set {
                self._value = newValue
                print(_value)
                
            }
        }
        
        init(wrappedValue: String) {
            self._value = wrappedValue
        }
    }
}

