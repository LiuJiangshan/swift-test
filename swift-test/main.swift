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
}

//test1()
//test2()
//test3()
test4()