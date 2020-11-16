//
//  NSImageExtension.swift
//  MyDrawingBoard
//
//  Created by apple on 2020/5/28.
//  Copyright © 2020 GML. All rights reserved.
//

import Cocoa

extension NSImage {
    var imagePixelSize : NSSize? {
        guard let imageData = self.tiffRepresentation else {
            return nil
        }
        guard let bitmapImage = NSBitmapImageRep(data: imageData) else {
            return nil
        }
        return NSSize(width: bitmapImage.pixelsWide, height: bitmapImage.pixelsHigh)
    }
    
}
