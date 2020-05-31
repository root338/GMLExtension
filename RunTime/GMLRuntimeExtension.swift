//
//  GMLRuntimeExtension.swift
//  MyDrawingBoard
//
//  Created by GML on 2020/5/31.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation

public extension NSObject {
//    /// 仅在同一个target下有效, Bundle.main 返回当前target下的Product的路径
//    static var isSystemClass: Bool {
//        let bundle = Bundle(for: self)
//        return bundle != Bundle.main
//    }
//    var isSystemClass : Bool {
//        return type(of: self).isSystemClass
//    }
}

public extension NSObject {
    
    /// 获取属性名列表
    /// swift class 在 4 以后必须前缀表明 @objcMembers 才可以解析出属性名, 因为不在默认 bridge 到 NSObject
    /// - Parameter shouldLoadSuper: 是否获取目标类型的父类
    static func ml_propertyNames(shouldLoadSuper: (AnyClass) -> Bool = { _ in false } ) -> [String]? {
        
        func propertyNames(targetClass: AnyClass) -> [String]? {
            let outCount = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
            defer {
                outCount.deallocate()
            }
            guard let propertyList = class_copyPropertyList(object_getClass(self), outCount) else {
                return nil
            }
            defer {
                propertyList.deallocate()
            }
            var propertyNames = [String]()
            for index in 0..<outCount.pointee {
                let cName = property_getName(propertyList[Int(index)])
                let name = String(cString: cName)
                propertyNames.append(name)
            }
            return propertyNames
        }
        
        var targetClass : AnyClass? = object_getClass(self)
        
        var allNames = [String]()
        while targetClass != nil {
            if let names = propertyNames(targetClass: targetClass!) {
                allNames.append(contentsOf: names)
            }
            targetClass = targetClass?.superclass()
        }
        return allNames
    }
    
    func ml_propertyNames(shouldLoadSuper: (AnyClass) -> Bool = { _ in false } ) -> [String]? {
        return type(of: self).ml_propertyNames(shouldLoadSuper: shouldLoadSuper)
    }
    
    func ml_toDictionary(shouldLoadSuper: (AnyClass) -> Bool = { _ in true }) -> [String : Any]? {
        guard let propertyNames = ml_propertyNames(shouldLoadSuper: shouldLoadSuper) else { return nil }
        var dic = [String : Any]()
        for name in propertyNames {
            guard let obj = self.value(forKey: name) else { continue }
            if obj is NSNull {
                continue
            }
//            else if let array = obj as? [Any] {
//                var list = [Any]()
//                for item in array {
//                    list =
//                }
//            }
            dic[name] = obj
        }
        return dic
    }
}
