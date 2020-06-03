//
//  WindowExtension.swift
//  MyDrawingBoard
//
//  Created by GML on 2020/6/3.
//  Copyright © 2020 GML. All rights reserved.
//

import AppKit

extension NSWindow {
    var contentLayerBackgroundColor: GMLColor? {
        set {
            self.contentView?.layer?.backgroundColor = newValue?.cgColor
            if self.contentView?.wantsLayer != true {
                self.contentView?.wantsLayer = true
            }
        }
        get {
            guard let c = self.contentView?.layer?.backgroundColor else {
                return nil
            }
            return GMLColor(cgColor: c)
        }
    }
}

