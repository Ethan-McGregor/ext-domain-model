//
//  main.swift
//  ExtDomainModel
//
//  Created by studentuser on 4/12/17.
//  Copyright © 2017 Ethan.McGregor. All rights reserved.
//


import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

////////////////////////////////////
// Money
//


///add protocol////
protocol CustomStringConvertible {
    func description() -> String
}

protocol Mathematics {
    func add(_ to: Money) -> Money
    func subtract(_ from: Money) -> Money
}

public func + (left: Money, right: Money) -> Money {
    return left.add(right)
}
public func - (left: Money, right: Money) -> Money {
    return left.subtract(right)
}


public struct Money : CustomStringConvertible, Mathematics {
    public var amount : Int
    public var currency : String
    
    public func convert(_ newCur: String) -> Money {
        var newAmount : Double = 0
        let error : String = "Sorry, only converting to USD, GBP, EUR, and CAN is available at this time."
        if(currency == newCur){
            newAmount = Double(amount)
        }else{
            
            switch currency {
            case "USD":
                switch newCur {
                case "GBP":
                    newAmount = Double(amount) * 0.5
                case "EUR":
                    newAmount = Double(amount) * 1.5
                case "CAN":
                    newAmount = Double(amount) * 1.25
                default:
                    print(error)
                }
            case "GBP":
                switch newCur {
                case "EUR":
                    newAmount = Double(amount) * 1.5
                case "CAN":
                    newAmount = Double(amount) * 2.5
                case "USD":
                    newAmount = Double(amount) * 2
                default:
                    print(error)
                }
            case "EUR":
                switch newCur {
                case "GBP":
                    newAmount = Double(amount) / 3
                case "CAN":
                    newAmount = Double(amount) / 6 * 5
                case "USD":
                    newAmount = Double(amount) / 1.5
                default:
                    print(error)
                }
            case "CAN":
                switch newCur {
                case "GBP":
                    newAmount = Double(amount) * 0.8
                case "EUR":
                    newAmount = Double(amount) / 5 * 6
                case "USD":
                    newAmount = Double(amount) / 1.25
                default:
                    print(error)
                }
                
            default:
                print(error)
            }
        }
        let newMoney = Money(amount: Int(newAmount), currency: newCur)
        return newMoney
    }
    
    public func add(_ oldMoney: Money) -> Money {
        if (self.currency == oldMoney.currency) {
            return Money(amount: self.amount + oldMoney.amount, currency: self.currency)
        } else {
            return oldMoney.add(self.convert(oldMoney.currency))
        }
    }
    
    
    public func subtract(_ oldMoney: Money) -> Money {
        if (self.currency == oldMoney.currency) {
            return Money(amount: self.amount - oldMoney.amount, currency: self.currency)
        } else {
            return oldMoney.subtract(self.convert(oldMoney.currency))
        }
    }
    public func description() -> String { 
        return "\(currency)\(amount)"
    }
    
    public init(amount:Int, currency:String){
        self.currency = currency
        self.amount = amount
    }
}
public extension Double {
    public var USD: Money {
        return Money(amount: Int(self), currency: "USD")
    }
    public var EUR: Money {
        return Money(amount: Int(self), currency: "EUR")
    }
    public var GBP: Money {
        return Money(amount: Int(self), currency: "GBP")
    }
    public var CAN: Money {
        return Money(amount: Int(self), currency: "CAN")
    }
}

////////////////////////////////////
// Job
//
open class Job {
    fileprivate var title : String
    fileprivate var type : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        switch type {
        case .Hourly(let income) : return Int(income * Double(hours))
        case .Salary(let income) : return income
        }
    }
    
    open func raise(_ amount : Double) {
        switch type {
        case .Hourly(let income) : type = JobType.Hourly(income + amount)
        case .Salary(let income) : type = JobType.Salary(Int(Double(income) + amount))
        }
    }
    public var description : String {
        return "\(title)\(type)"
    }
}


////////////////////////////////////
// Person
//
open class Person {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    fileprivate var _job : Job? = nil
    
    
    open var job : Job? {
        get { return _job}
        set(value) {
            if (self.age >= 16) {
                _job = value
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get { return _spouse }
        set(value) {
            if (self.age >= 18) {
                _spouse =  value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(String(describing: _job)) spouse:\(String(describing: _spouse))]"
        
    }
    public var description : String {
        return "\(firstName) \(lastName)"
    }
}


////////////////////////////////////
// Family
//
open class Family {
    fileprivate var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        members.append(spouse1)
        members.append(spouse2)
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
    }
    
    open func haveChild(_ child: Person) -> Bool {
        
        for i in members {
            
            if (i.age > 21) {
                members.append(child)
                return true
            }
        }
        return false
    }
    
    open func householdIncome() -> Int {
        
        var totalIncome : Int = 0
        
        for i in members {
            
            if (i.age >= 16 && i._job != nil) {
                totalIncome += (i._job?.calculateIncome(2000))!
            }
        }
        
        return totalIncome
    }
    public var description : String {
        return "\(members)"
    }
}


