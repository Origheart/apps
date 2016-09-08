//
//  Helper.swift
//  PrintLog
//
//  Created by 刘康 on 16/8/31.
//  Copyright © 2016年 刘康. All rights reserved.
//

import Foundation

func printLog<T>(message:T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method):\(message)")
    #endif
}