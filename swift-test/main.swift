//
//  main.swift
//  sw-test
//
//  Created by yfn on 2018/11/9.
//  Copyright © 2018 yfn. All rights reserved.
//

import Foundation

func test1() {
    let name = "ljs"
    let age = 23
    let say = "i am \(name), age is \(age)"
    print(say)

    let say1 = """
hh


I said "I have  pieces of fruit."
"""
    print(say1)
    let users = ["a", "b"]
    print(users.count)
    let map = ["name": "ljs"]
    print(map)
}

func test2() {
    let users = ["a", "b", "c", "d"]
    for user in users {
        print(user)
    }
    let map = ["name": "user", "age": 22, "address": "china"] as [String: Any]
    for (key, body) in map {
        print("for in:\(key)===\(body)")
    }
    map.forEach { (key, body) in
        print("foreach:\(key)===\(body)")
    }
    for a in 0..<100 {
        print(a)
    }
    for a in -100...0 {
        print(a)
    }
}

func test3() {
    let name: String? = "ljs"
    if let n = name {
        print("no null\(n)")
    }
}

func test4() {
    let name = "ljs"
    switch name {
    case let x where x.hasSuffix("js"):
        print("suffix matched")
        break
    case "l", "ljs":
        print("matched")
        break
    default:
        print("no match")
        break
    }
    var i = 0
    repeat {
        i += 1
        print(i)
    } while i < 100
}

func getUserInfo() -> (name: String, age: Int, address: String) {
    return ("user", 23, "earch")
}

func test5() {
    let user = getUserInfo()
    print(user.name, user.age, user.0, user.1)
}

func setUserInfo(name:String, address:String, _ age: Int) {
    print("set Ok")
}

func test6() {
    setUserInfo(name: "user", address: "earth", 1)
}

func doThing() -> Int {
    var i = 1
    func doThing1() {
        i *= 100
    }
    doThing1()
    return i
}

func test7() {
    let i = doThing()
    print(i)
}

func getMethod() -> (() -> String) {
    func test() -> String {
        return "hello"
    }
    return test
}

func test8() {
    print(getMethod()())
}

func setMethod(doThing: ()->()) {
    doThing()
}

func test9() {
    setMethod {
        print("hello")
    }
}

func map(number: Int) -> Int {
    return number * 2
}

func test10() {
    let re = [1, 2 , 3]
        .map(map)
        .map({(number: Int) -> Int in return number * 2})
        .map({number in number * 2})
    print(re)
    let re2 = [4, 3, 1 , 2].sorted{ $0 > $1 }
    print(re2)
    let re3 = re2.sorted{ $0 < $1 }
    print(re3)
}

enum Sex {
    case Male, Female, UnKnow
}

class People {
    var sex = Sex.Male
    var name = ""
    var ageVal = 0
    var age:Int {
        set {
            if(newValue < 0 || newValue > 150) {
                print("年龄格式错误")
            }
            self.ageVal = newValue
        }
        get {
            return self.ageVal
        }
    }
    var likes:[String] = []
    init(sex: Sex, name: String, age: Int, likes: [String]) {
        self.sex = sex
        self.name = name
        self.age = age
        self.likes = likes
    }
}
class User: People {
    var address = ""
    init(sex: Sex, name: String, age: Int, likes: [String], address: String) {
        self.address = address
        super.init(sex: sex, name: name, age: age, likes: likes)
    }
}

func test11() {
    let user = User(sex: Sex.Male, name: "User", age: 22, likes: ["play", "read"], address: "earth")
    print(user.sex,user.name, user.age, user.address)
}

enum EnumTest: Int, CaseIterable {
    case One = 100
    case Two = 1
    case Three, Four, Five, Seven, Eight, Nine
}

func test12() {
    print(EnumTest.allCases.forEach{ item in print(item, item.rawValue) })
    if let re = EnumTest(rawValue: 1) {
        print(re, re.rawValue)
    }
}

protocol UsbDevice {
    var id: Int { get }
    func work()
}

class Mouse: UsbDevice {
    let id = 0x201811101133
    func work() {
        print("鼠标工作中")
    }
}

class KeyBoarda: UsbDevice {
    let id = 0x201811101323
    func work() {
        print("键盘工作中")
    }
}

func test13() {
    let mouse = Mouse()
    mouse.work()
    print(mouse.id)
    let keyBoarda = KeyBoarda()
    keyBoarda.work()
    print(keyBoarda.id)
}

enum MyError: Error {
    case KnowError(msg: String), UnKnowError(msg: String)
}

func throwError() throws {
    throw MyError.KnowError(msg: "已知错误的错误")
}

func test14() {
    do {
        try throwError()
    } catch {
        print("发生了异常:\(error)")
    }
}
//test1()
//test2()
//test3()
//test4()
//test5()
//test6()
//test7()
//test8()
//test9()
//test10()
//test11()
//test12()
//test13()
test14()
