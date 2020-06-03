//
//  GMLPath.swift
//  MyDrawingBoard
//
//  Created by apple on 2020/6/3.
//  Copyright © 2020 GML. All rights reserved.
//

import Cocoa

public class GMLPath: NSObject {
    
    private(set) var path: String
    private(set) var isDir: Bool
    
    private(set) lazy var subpaths: [GMLPath]? = {
        if !isDir { return nil }
        var subpaths = [GMLPath]()
        FileManager.default.enumerator(at: path) { (path, isDir) -> FileManager.EnumeratorOperate in
            subpaths.append(GMLPath(path: path, isDir: isDir))
            return .none
        }
        return subpaths
    }()
    
    convenience init?(path: String) {
        guard let isDir = FileManager.default.isDirectory(filePath: path) else {
            return nil
        }
        self.init(path: path, isDir: isDir)
    }
    
    private init(path: String, isDir: Bool) {
        self.path = path
        self.isDir = isDir
        super.init()
    }
}

public extension GMLPath {
    
}
