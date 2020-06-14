//
//  OpenPanelExtension.swift
//  MyDrawingBoard
//
//  Created by apple on 2020/6/3.
//  Copyright © 2020 GML. All rights reserved.
//

import Cocoa

public extension NSOpenPanel {
    
    enum OperateError: Error {
        case cancel
        case isEmpty
    }
    
    typealias ResultCompletion = (Result<URL, OperateError>) -> Void
    
    static func showSelectedFolder(sheetWindow: NSWindow? = nil, completion:  @escaping ResultCompletion) -> NSOpenPanel {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false
        
        func result(_ result: NSApplication.ModalResponse) -> Result<URL, OperateError> {
            if result != .OK {
                return Result.failure(.cancel)
            }
            guard let url = panel.url else {
                return Result.failure(.isEmpty)
            }
            return Result.success(url)
        }
        if sheetWindow == nil {
            panel.begin {
                completion(result($0))
            }
        }else {
            panel.beginSheetModal(for: sheetWindow!) {
                completion(result($0))
            }
        }
        return panel
    }
    
    static func showToCurrentWindow(_ completion: @escaping ResultCompletion) -> NSOpenPanel {
        return showSelectedFolder(sheetWindow: NSApplication.shared.keyWindow, completion: completion)
    }
}

