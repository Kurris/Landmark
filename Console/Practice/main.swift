//
//  main.swift
//  Practice
//
//  Created by 李国扬 on 2022/8/18.
//

//import Foundation

//print("Hello, World!")

//可以修改的变量
var variable = 1
variable=2

//不可修改的变量
let contant = 1;
//contant=2


//隐式和显式定义
let implicitInteger = 70;
let implicitDouble = 70.0;
let explicitDouble:Double = 7.1

//字符串 字符串拼接 字符串插值
let numOfApple  = 8
let str1 = "I have  apples" + String(numOfApple)
let str2  = "I have \(numOfApple) apples"

//输出引号 需要用 “”“ ”“” ,并且内容在里面
let printQuotes = """
"引用一段文字"
"""
print(printQuotes)


//定义数组
var shoppingList = ["water" , "flower" , "apple"]
//索引访问
shoppingList[0] = "peach"
print(shoppingList)

//定义字典
var dict = [
    "key1" :"value1",
    "key2" :"value2",
]

dict["key1"] = "value3"
print(dict)

//定义空的数组和字典
let emptyArray : [String] = []
let emptyDictionary : [String:Double] = [:]


//循环和if-else
let scores = [8,1,25,3,4]
for score in scores{
    if score > 4{
        print(score)
    }else{
        print("<=4")
    }
}

//可空值是optional类型
let optionalValue1 : String? = "xiao"
let optionalValue2 : String = "ligy"
let info1 = "Hi \(optionalValue1 ?? optionalValue2) "
print(info1)

//if let xxx = optionalValue {
//
//}
//判断该optional值如果不为空的操作
var optionalStr1 : String? = "ligy"
var greeting1 = "Hello"
if let text1 = optionalStr1{
    greeting1 += " \(text1)"
}
print(greeting1)

var optionalStr2 :String? = nil
var greeting2 = "Hello"
if let text2 = optionalStr2{
    greeting2 += " \(text2)"
}else{
    greeting2 += " fuck this syntax"
}
print(greeting2)


//switch

let name1 = "hi ligy"
switch name1{
case "hi":
    print("hi")
case "li","xiao":
    print("is li or xiao")
case let x where x.hasSuffix("ligy"):
    print("oh is ligy!!!")
default:
    print("unknow")
}

//遍历字典
let dict1  = [
    "key1" : [2,31,2],
    "key2" : [1,2,3]
]

for (key,value) in dict1{
    print(key)
    for num in value{
        print(num)
    }
}

//while
var n1 = 100
while n1 > 95{
    print(n1)
    n1 -= 1
}

//do .. while
repeat {
    n1 += 1
    print(n1)
}while n1 < 100



// 0..<100 定义0到100的索引
for _ in 0..<100{
    
}


//定义方法 , 参数前面添加 下划线“_”那么调用的时候可以不指定参数名称
func greet(arg1:String , arg2 : Int) -> String{
    var tmp = "xiao"
    if arg2 == 10{
        tmp = "ligy"
    }
    return arg1 + " " + tmp
}

print(greet(arg1: "hi", arg2: 0))
print(greet(arg1: "hi", arg2: 10))

//返回值为元祖 tuple
func calc(scores:[Int])-> (max:Int,min:Int,sum:Int){
    
    var sum = 0
    for s in scores{
        sum += s
    }
    
    let max = scores.max()!
    let min = scores.min()!
    
    return (max,min,sum)
}

print(calc(scores: [1,2,3]))

//nested func 内联方法  js闭包
func nested() -> Int{
    var y:Int = 0
    func add(){
        y += 5
    }
    add()
    return y
}
print(nested())

//方法返回方法
func returnMethod() -> ((Int) -> Int){
    func addOne(number:Int) -> Int{
        return number + 1;
    }
    
    return addOne
}
print(returnMethod()(1))

//方法表达式
func check(list: [Int] , condition: (Int)->Bool) -> [Int]{
    var result:[Int] = []
    for val in list{
        if condition(val){
            result.append(val)
        }
    }
    return result
}

func conditionMethod(arg:Int)-> Bool{
    return arg > 3
}
print(check(list: [1,2,3,4,5], condition:conditionMethod ))



//({}) map
var numbers = [20, 19, 7, 12]
let nmap = numbers.map({(arg:Int)-> Int in
    let result  = 3 * arg
    return result
})
print(nmap)

let nmap1 = numbers.map({ x in x * 10})
print(nmap1)

//排序
numbers.sort()
print(numbers)
print(numbers.sorted { $0 > $1 })



//class
class animal{
    
    var animalName:String?
    var animalAge :Int = 0
    
    //    init(){
    //
    //    }
    
    //init固定写法 所有类都是init
    //    init(name: String){
    //        //可以不用self
    //        self.animalName = name
    //    }
    
    init(name: String,age: Int){
        //可以不用self
        self.animalName = name
        self.animalAge = age
    }
    
    func say() -> String{
        
        if let say = animalName{
            switch say{
            case "ligy" :
                return "你好"
            case "ni":
                return "yo man"
            default :
                return "unknow"
            }
        }else{
            return "unknow"
        }
    }
}

print(animal(name: "ni",age: 18).say())

class Human : animal{
    
    init() {
        a = "-a";
        super.init(name: "human", age:100)
    }
    
    //C# 属性
    var Property:String?{
        get{
            return super.animalName
        }set{
            super.animalName = newValue
        }
    }
    
    
    var a:String{
        didSet{
            print("didSet \(oldValue)")
        }
        willSet{
            print("willSet \(newValue)")
        }
    }
}

var human = Human()
human.a = "a"


//枚举
enum status : Int{
    case one = 1
    case two,three
    
    func description()->String{
        switch self {
        case .one:
            return "一"
        case .two:
            return "二"
        case .three:
            return "三"
        default :
            return String(self.rawValue)
        }
    }
}
enum Tab : Int{
    case house = 1
    case explore,account
    
    func description() ->String{
        switch self {
        case .house:
            return "主页"
        case .explore:
            return "搜索"
        case .account:
            return "我的"
        }
    }
}



let one =  status.two
print(one.rawValue)
print(one.description())


//异步
func fetchUserID(server: String) async -> Int {
    if server == "primary" {
        return 97
    }
    return 501
}


func fetchUsername(server: String) async -> String {
    let userID = await fetchUserID(server: server)
    if userID == 501 {
        return "John Appleseed"
    }
    return "Guest"
}

func a() async {
    let v =  await fetchUsername(server: "ligy")
    print(v)
}
//Task{
//   await a()
//}


//协议  就是接口
protocol ITodo{
    mutating func todo()
}

class SomeClass : ITodo{
    func todo() {
        
    }
}

//extension 扩展
extension Int{
    var ago : Int{
        return -self
    }
}
print(5.ago)

//异常
enum myError : Error{
    case nihao
    case null
}

func thisRaiseError() throws{
    throw myError.null
}

do{
    try thisRaiseError()
}catch {
    print(error)
}catch myError.nihao{
    //    not a error
}

//defer 不等同于 finally
//最后执行,但是不影响方法的返回值,延迟执行
var name:String = ""
func testDefer(){
    name = "xiao"
    defer {
        name = "ligy"
    }
}
testDefer()
print(name)


print("🐶")























