//
//  StringPathExtension.swift
//  MyDrawingBoard
//
//  Created by apple on 2020/5/28.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation

extension String {
    var ml_pathExtension: String {
        return (self as NSString).pathExtension
    }
    func ml_append(pathExtension: String) -> String? {
        return (self as NSString).appendingPathExtension(pathExtension)
    }
    
    /// 是否是文件夹，nil不是有效路径，true是文件夹/false是文件
    var ml_isFileDirectory: Bool? {
        return FileManager.default.vertifyIsDirectory(filePath: self)
    }
}
