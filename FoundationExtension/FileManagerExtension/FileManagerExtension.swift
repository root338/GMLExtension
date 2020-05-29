//
//  FileManagerExtension.swift
//  MyDrawingBoard
//
//  Created by apple on 2020/5/28.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation

extension FileManager {
    
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
    
    func enumerator(at filePath: String, deepRecursion: Bool = false, handle: (String, Bool) -> Bool) -> Bool {
        guard let isDir = self.vertifyIsDirectory(filePath: filePath) else {
            return false
        }
        guard !isDir else {
            _ = handle(filePath, false)
            return true
        }
        guard let directoryEnumerator = self.enumerator(atPath: filePath) else {
            return false
        }
        while let path = directoryEnumerator.nextObject() as? String {
            guard let isDir = vertifyIsDirectory(filePath: path) else { return false }
            var stop = false
            stop = handle(path, isDir)
            if stop {
                break
            }
            let isHandle = enumerator(at: path, deepRecursion: deepRecursion) {
                stop = handle($0,$1)
                return stop
            }
            
        }
    }
}
