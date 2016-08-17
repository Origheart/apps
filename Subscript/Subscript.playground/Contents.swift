//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*:
 - 下标脚本的定义：
  > 下标脚本允许你通过在实例后面的方括号中传入一个或者多个的索引值来对实例进行访问和赋值。
 */

/*:
 - Array和Dictionary的下标：
 */
//: 在绝大多数语言中使用下标来读写类似数组或者是字典这样的数据结构的做法,似乎已经是业界标准。在 Swift 中,Array 和 Dictionary 当然也实现了下标读写:
var arr = [1, 2, 3]
arr[2]
arr[2] = 4
arr

var dic = ["cat": "meow", "goat": "mie"]
dic["cat"]  //{Some "meow"}
dic["cat"] = "miao" // dic = ["cat": "miao", "goat": "mie"]
dic

//: 1. 对于数组没什么好多说的如果越界了只好直接给你脸色让你崩掉
//: 2. 对于字典，查询不到是很正常的一件事情，通过下标访问得到的结果是一个 Optional 的值。对此,在 Swift 中我们有更好的处理方式,那就是返回 nil 告诉你没有要找的东西

/*:
 - 为Array自定义下标脚本
 通过 Cmd + 单击Array，查看已经支持的下标访问类型：
 */

//subscript (index: Int) -> T  // 接受单个 Int 类型的序号，返回单个元素
//subscript (subRange: Range<Int>) -> ArraySlice<T> // 接收一个表明范围的 Range，返回对应的一组元素
//: 假设有一个需求：在一个数组内,我想取出 index 为 0, 2, 3 的元素的时候,现有的体系就会比较吃力。 我们很可能会要去枚举数组,然后在循环里判断是否是我们想要的位置。其实这里有更好的做法：实现一个接受数组作为下标输入的读取方法:
extension Array {
    subscript(input: [Int]) -> ArraySlice<Element> {
        get {
            var result = ArraySlice<Element>()
            for i in input {
                assert(i < self.count, "Index out of range")
                result.append(self[i])
            }
            return result
        }
        set {
            for (index, i) in input.enumerate() {
                assert(i < self.count, "Index out of range")
                self[i] = newValue[index]
            }
        }
    }
}

var array = [1, 2, 3, 4, 5]
array[[0, 2, 3]]    //[1, 3, 4]
array[[0, 2, 3]] = [-1, -3, -4]
array  // [-1, 2, -3, -4, 5]

/*:
 - 下标脚本的重载
 > 可以根据自身需要提供多个下标脚本实现，在定义下标脚本时通过入参个类型进行区分，使用下标脚本时会自动匹配合适的下标脚本实现运行，这就是下标脚本的重载。
 */

/*:
 - 为Struct自定义下标
 */
// :如下例，定义了一个Matrix结构体，将呈现一个Double类型的二维矩阵。Matrix结构体的下标脚本需要两个整型参数：
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
// :Matrix下标脚本的getter和setter中同时调用了下标脚本入参的row和column是否有效的判断。为了方便进行断言，Matrix包含了一个名为indexIsValid的成员方法，用来确认入参的row或column值是否会造成数组越界


var matrix = Matrix(rows: 2, columns: 2)

//将值赋给带有row和column下标脚本的matrix实例表达式可以完成赋值操作，下标脚本入参使用逗号分割

matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

// 取值操作（查看坐标为（0, 1）的grid的值）：
var value = matrix[0, 1]
value = matrix[0, 0]

//断言在下标脚本越界时触发：

let someValue = matrix[2, 2]

// 断言将会触发，因为 [2, 2] 已经超过了matrix的最大长度






