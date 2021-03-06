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
    第一行
    第二行\
    第二行
    第三行
    """
    print(say1)
    let users = ["a", "b"]
    print(users.count)
    let map = ["name": "ljs"]
    print(map)
    let blackHeart = "\u{2665}"
    print(blackHeart)
    for c in say1 {
        print(c)
    }
}

func test2() {
    let users = ["a", "b", "c", "d"]
    for user in users {
        print(user)
    }
    for user in users[...1] {
        print("...1:\(user)")
    }
    for user in users[1...] {
        print("1...:\(user)")
    }
    for user in users[..<1] {
        print("..<1:\(user)")
    }
    let map = ["name": "user", "age": 22, "address": "china"] as [String: Any]
    for (key, body) in map {
        print("for in:\(key)===\(body)")
    }
    map.forEach { (key, body) in
        print("foreach:\(key)===\(body)")
    }
    for a in 0..<3 {
        print(a)
    }
    for a in -3...0 {
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

func setUserInfo(name: String, address: String, _ age: Int) {
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

func setMethod(doThing: () -> ()) {
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
    let re = [1, 2, 3]
            .map(map)
            .map({ (number: Int) -> Int in return number * 2 })
            .map({ number in number * 2 })
    print(re)
    let re2 = [4, 3, 1, 2].sorted {
        $0 > $1
    }
    print(re2)
    let re3 = re2.sorted {
        $0 < $1
    }
    print(re3)
}

enum Sex {
    case Male, Female, UnKnow
}

class People {
    var sex = Sex.Male
    var name = ""
    var ageVal = 0
    var age: Int {
        set {
            if (newValue < 0 || newValue > 150) {
                print("年龄格式错误")
            }
            self.ageVal = newValue
        }
        get {
            return self.ageVal
        }
    }
    var likes: [String] = []

    init(sex: Sex, name: String, age: Int, likes: [String]) {
        self.sex = sex
        self.name = name
        self.age = age
        self.likes = likes
    }

    deinit {
        print("destory", self)
    }

    func eat() {
    }

    func work() {
    }

}

class User: People, Equatable {
    var address = ""

    init(sex: Sex, name: String, age: Int, likes: [String], address: String) {
        self.address = address
        super.init(sex: sex, name: name, age: age, likes: likes)
    }

    public var pointer: UnsafePointer<User>? {
        get {
            var this = self
            var pointer: UnsafePointer<User>? = nil
            withUnsafePointer(to: &this) {
                pointer = $0
            }
            return pointer
        }
    }

    public static func ==(lhs: User, rhs: User) -> Bool {
        return lhs === rhs
    }

}

func test11() {
    let user = User(sex: Sex.Male, name: "User", age: 22, likes: ["play", "read"], address: "earth")
    print(user.sex, user.name, user.age, user.address)
}

enum EnumTest: Int, CaseIterable {
    case One = 100
    case Two = 1
    case Three, Four, Five, Seven, Eight, Nine
}

func test12() {
    print(EnumTest.allCases.forEach { item in
        print(item, item.rawValue)
    })
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
    case KnowError(msg: String)
    case UnKnowError(msg: String)
}

func throwError() throws {
    throw MyError.KnowError(msg: "hahahaha")
}

func test14() {
    do {
        try throwError()
    } catch MyError.KnowError("hahahaha") {
        print("KnowError")
    } catch MyError.UnKnowError("") {
        print("UnKnowError")
    } catch let e as MyError {
        print(e)
    } catch {
    }
}

class MyList<T: Equatable> {
    var items: [T] = []

    func put(t: T) {
        items.append(t)
    }

    func get(index: Int) -> T {
        return items[index]
    }

    func remove(index: Int) -> Bool {
        return items.remove(at: index) != nil
    }

    func remove(t: T) -> Bool {
        var index = 0
        for body in items {
            if t == body {
                return items.remove(at: index) != nil
            }
        }
        return false
    }
}

func test15() {
    let user1 = User(sex: Sex.Female, name: "ljs1", age: 24, likes: ["play"], address: "earth")
    let user2 = User(sex: Sex.Female, name: "ljs2", age: 24, likes: ["play"], address: "earth")
    let users = MyList<User>()
    print(user1 == user1)
}

func test16() {
    let stringNumber = "1234"
    if let number = Int(stringNumber) {
        print("转换成功:\(number)")
    } else {
        print("转换失败")
    }
}

func test17() {
    assert(true, "断言false")
}

func test18() {
    print((1, 2) < (2, 1))
    print(true ? 1 : 2)
    print(nil ?? "null")
}

func test19() {
    for i in stride(from: 0, through: 60, by: 5) {
        print(i)
    }
}

func test20() {
    let i = 10
    switch i {
    case 1, 2, 3, 10:
        print(i)
        fallthrough
    default:
        print(i)
    }
}

func test21() {
    c1: while true {
        c2: while true {
            break c2
        }
        break c1
    }
    print("hello")
}

func test22() {
    let user = ["name": "ljs"]
    guard let nameBak = user["name"] else {
        print("else")
        return
    }
    print(nameBak)
    guard false else {
        print("else")
        return
    }
}

func test23() {
    if #available(macOS 10.13.6, *) {
        print("macOs 10.13.6 可用")
    } else {
        print("macOS 10.13.6 不可用")
    }

    guard #available(macOS 10.14, *) else {
        print("macOS 10.14 不可用")
        return
    }
}

func testMethod(age: inout Int, names: String...) {
    for name in names {
        print(name)
    }
    age = 24
}

func test24() {
    var age = 12
    testMethod(age: &age, names: "user1", "user2")
    print(age)
}

func test25() {
    var names = ["name1", "name2", "name3"]
    for name in names.sorted(by: { name1, name2 in name1 > name2 }).sorted(by: { $0 != $1 }).sorted(by: <).sorted(by: !=).sorted(by: >) {
        print(name)
    }
}

func testMethod1(m: () -> Void) {
    m()
}

func test26() {
    testMethod1(m: {
        print("hello")
    })
}

func test27() {
    let error: MyError = .UnKnowError(msg: "")
    print(error)
    switch error {
    case .UnKnowError(let msg) where msg == "a":print("a")
    case .UnKnowError(let msg) where msg.isEmpty:print("matched")
    default: print("default")
    }
}

struct AdminPassWord {
    let loginPassWord: String

    init() {
        loginPassWord = "1234"
    }
}

class Admin: People {
    let permission: String
    let passWord: AdminPassWord

    init() {
        permission = ""
        passWord = AdminPassWord()
        super.init(sex: Sex.Female, name: "admin", age: 24, likes: ["play"])
    }
}

class SupperMan: People {
    override func eat() {
        super.eat()
        print("eat spinach")
    }

    override func work() {
        super.work()
        print("fly")
    }
}

func test28() {
    defer {
        let superMan = SupperMan(sex: Sex.Female, name: "s1", age: 24, likes: ["fly"])
    }
}

struct MyArray {
    var arry: [[Int]]

    init(xSize: Int, ySize: Int) {
        arry = Array(repeating: Array(repeating: 0, count: ySize), count: xSize)
    }

    subscript(x: Int, y: Int) -> Int {
        get {
            return arry[x][y]
        }
        set(newValue) {
            arry[x][y] = newValue
        }
    }
}

func test29() {
    let xSize = 10
    let ySize = 20
    var mArry = MyArray(xSize: xSize, ySize: ySize)
    for x in 0..<xSize {
        for y in 0..<ySize {
            mArry[x, y] = Int.random(in: 0...9999)
        }
    }
    for x in 0..<xSize {
        for y in 0..<ySize {
            print("[\(x),\(y)]:\(mArry[x, y])")
        }
    }
}

func throwMethod() throws {
    let nameOk = true
    let sexOk = true
    let workOk = false
    guard nameOk, sexOk, workOk else {
        throw MyError.KnowError(msg: "something no ok")
    }
}

func test30() {
    do {
        try throwMethod()
    } catch MyError.KnowError(let msg) {
        print(msg)
    } catch {
    }
}

struct Rect {
    var w = 0;
    var h = 0;
}

extension Rect {
    init(width: Int, height: Int) {
        self.init(w: width * 10, h: height * 10)
    }

    func isSquare() -> Bool {
        return w == h
    }
}

extension Rect {
    init(w1: Int, h1: Int) {
        self.init(width: w1 * 5, height: h1 * 5)
    }
}

func test31() {
    let rect = Rect(w1: 9, h1: 9)
    print(rect.isSquare())
    print(rect.w, rect.h)
}

func swapValue<T: Any>(v1: inout T, v2: inout T) {
    let temp = v1
    v1 = v2
    v2 = temp
}

func test32() {
    var str1 = "str1"
    var str2 = "str2"
    print(str1, str2)
    swapValue(v1: &str1, v2: &str2)
    print(str1, str2)
}


protocol SomeBuffer {
    associatedtype Item: Equatable, Hashable
    associatedtype Suffix: SomeBuffer where Suffix.Item == Item
    func append(_ item: Item) -> Self
    func remove(_ at: Int) -> Bool
    func suffix(_ index: Int) -> Suffix
    var count: Int { get }
    subscript(_ index: Int) -> Item { get }
}

class MyStringBuffer: SomeBuffer {
    var items = [String]()

    typealias Item = String
    typealias Suffix = MyStringBuffer

    func append(_ item: String) -> Self {
        items.append(item)
        return self
    }

    func remove(_ at: Int) -> Bool {
        return items.remove(at: at) != nil
    }

    func suffix(_ index: Int) -> MyStringBuffer {
        var suffix = MyStringBuffer()
        for i in index..<items.count {
            suffix.append(items[i])
        }
        return suffix
    }

    var count: Int {
        return items.count
    }
    subscript(_ index: Int) -> String {
        return items[index]
    }
}

func whereT<X: SomeBuffer, Y: SomeBuffer>(x: X, y: Y) where X.Item == Y.Item, X.Suffix == Y.Suffix {
}

func test33() {
    var mStrBuffer = MyStringBuffer()
    mStrBuffer.append("ljs").append("earth").append("23")
    for index in 0..<mStrBuffer.count {
        print(mStrBuffer[index])
    }
    print("count:\(mStrBuffer.count)")
}

func test34() {
    var mStrBuf = MyStringBuffer()
    mStrBuf.append("ljs").append("earth").append("24")
    var suffix = mStrBuf.suffix(1)
    for index in 0..<suffix.count {
        print(suffix[index])
    }
}

class Obj1 {
    weak var obj2: Obj2?

    init() {
        print("init obj1")
    }

    deinit {
        print("deinit obj1")
    }
}

class Obj2 {
    var obj1: Obj1?

    init() {
        print("init obj2")
    }

    deinit {
        print("deinit obj2")
    }
}

func test35() {
    let obj1 = Obj1()
    let obj2 = Obj2()

    obj1.obj2 = obj2
    obj2.obj1 = obj1

//    obj1.obj2 = nil
//    obj2.obj1 = nil
    print("method end")
}

class Obj3 {
    lazy var name: () -> String = {
        [unowned self] in
        return "\(self)"
    }

    init() {
        print("init obj3")
    }

    deinit {
        print("deinit obj3")
    }
}

func test36() {
    var obj3 = Obj3()
    var name = obj3.name
}

func test37() throws {
    let a: UInt8 = 0b00000001
    let b: UInt8 = 0b11111110
    print(a == ~b)
    print(~a == b)
    let c: UInt8 = 0b00000001
    let d: UInt8 = 0b00000101
    print((c & d) == 0b00000001)
    print((c | d) == 0b00000101)
    print((c ^ d) == 0b00000100)
    for i in 0...100 {
        if ((UInt8.random(in: UInt8.min...UInt8.max)) << 8) != 0 {
            throw MyError.KnowError(msg: "error")
        }
    }
    print(UInt8.max &+ 1)
    print(UInt8.min &- 1)
}

extension People {
    static prefix func +(people: People) -> Int {
        return +1
    }

    static prefix func -(people: People) -> Int {
        return -1
    }

    static func +=(left: inout People, right: People) {
        left.age += 1
    }

    static func -=(left: inout People, right: People) {
        left.age -= 1
    }

    static func ==(left: People, right: People) -> Bool {
        return left === right
    }
}

func test38() {
    var people = People(sex: Sex.Male, name: "ljs", age: 23, likes: ["play"])
    print(-people, +people)
    people += people
    print(people.age)
    people -= people
    print(people.age)
    print(people == people)
}

extension Int {
    static prefix func ++(int: inout Int) {
        int += 1
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
//test14()
//test15()
//test16()
//test17()
//test18()
//test19()
//test20()
//test21()
//test22()
//test23()
//test24()
//test25()
//test26()
//test27()
//test28()
//test29()
//test30()
//test31()
//test32()
//test33()
//test34()
//test35()
//test36()
//try test37()
//test38()