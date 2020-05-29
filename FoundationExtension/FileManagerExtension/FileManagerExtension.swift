//
//  FileManagerExtension.swift
//  MyDrawingBoard
//
//  Created by apple on 2020/5/28.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation

extension FileManager {
    
    enum EnumeratorOperate {
        case none
        case `continue`
        case `return`
    }
    
    /// 验证文件路径是否是文件夹
    /// - Parameter filePath: 文件路径
    /// - Returns: 返回是否是文件夹，nil表示不是有效路径
    func vertifyIsDirectory(filePath: String) -> Bool? {
        let boolPointer = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
        let result = self.fileExists(atPath: filePath, isDirectory: boolPointer)
        let isDirectory = boolPointer.pointee.boolValue
        boolPointer.deallocate()
        return result == false ? nil : isDirectory
    }
    
    /// 枚举指定目录
    /// - Parameters:
    ///   - filePath: 文件路径
    ///   - deepRecursion: 是否遍历子目录
    ///   - handle: 处理遍历文件路径
    func enumerator(at filePath: String, deepRecursion: Bool = false, handle: (String, Bool) -> EnumeratorOperate) {
        guard let isDir = self.vertifyIsDirectory(filePath: filePath) else {
            return
        }
        guard !isDir else {
            _ = handle(filePath, false)
            return
        }
        guard let directoryEnumerator = self.enumerator(atPath: filePath) else {
            return
        }
        while let path = directoryEnumerator.nextObject() as? String {
            guard let isDir = vertifyIsDirectory(filePath: path) else { return }
            var operate = EnumeratorOperate.none
            operate = handle(path, isDir)
            switch operate {
            case .none:
                enumerator(at: path, deepRecursion: deepRecursion) {
                    operate = handle($0,$1)
                    return operate
                }
            case .continue: continue
            case .return: return
            }
            if operate == .return {
                return
            }
        }
    }
}
