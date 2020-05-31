//
//  GMLAttributesBuilder.swift
//  MyDrawingBoard
//
//  Created by GML on 2020/5/30.
//  Copyright © 2020 GML. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
/**
 * 富文本属性构建器
 * 为了不必再写多余的key值而冗余代码，使属性创建更简单
 */
public class GMLAttributesBuilder: NSObject {
    /// 默认属性，会自动添加到结果属性
    var attributes: GMLAttributesSet?
    private lazy var stack = [GMLAttributesContainer]()
}

public extension GMLAttributesBuilder {
    /// 弹入一个新的属性进行设置
    func push(attributes: GMLAttributesSet? = nil) -> Self {
        stack.append(container(attributes: attributes))
        return self
    }
    /// 弹出最近一个属性, 没有的话返回默认属性
    func pop() -> GMLAttributesSet? {
        return stack.popLast()?.get() ?? attributes
    }
    /// 获取最后一个属性
    func last() -> GMLAttributesSet? {
        return stack.last?.get()
    }
}

extension GMLAttributesBuilder {
    
    /**
     * 当前正在使用的属性容器
     * 为之后可以选择设置属性容器预留
     */
    func currentContainer() -> GMLAttributesContainer {
        return lastContainer()
    }
    
    /// 获取最后一个属性容器，没有就创建一个
    func lastContainer() -> GMLAttributesContainer {
        if let lastContainer = stack.last {
            return lastContainer
        }
        /// 没有先push一个新的, 再返回容器
        return push().stack.last!
    }
}

private extension GMLAttributesBuilder {
    /// 创建一个属性容器
    private func container(attributes: GMLAttributesSet? = nil) -> GMLAttributesContainer {
        var set = GMLAttributesSet()
        if self.attributes != nil {
            set.ml_append(dict: self.attributes!)
        }
        if attributes != nil {
            set.ml_append(dict: attributes!)
        }
        
        func set(key: GMLAttributesKey, value: Any?) {
            set[key] = value
        }
        func get() -> GMLAttributesSet {
            return set
        }
        return (set(key:value:), get)
    }
}

#if os(OSX)
//MARK:- 整合 OSX 环境下 NSAttributedString.Key 值
@available(OSX 10.10, *)
public extension GMLAttributesBuilder {
    /// 字体设置
    func font(_ font: NSFont) -> Self  {
        currentContainer().set(.font, font)
        return self
    }
    /// 背景设置
    func backgroundColor(_ color: NSColor) -> Self {
        currentContainer().set(.backgroundColor, color)
        return self
    }
    /// 字体颜色设置
    func foregroundColor(_ color: NSColor) -> Self {
        currentContainer().set(.foregroundColor, color)
        return self
    }
}
#elseif os(iOS)
//MARK:- 整合 iOS 环境下 NSAttributedString.Key 值
@available(iOS 8.0, *)
public extension GMLAttributesBuilder {
    func font(_ font: UIFont) -> Self {
        currentContainer().set(.font, font)
        return self
    }
    func backgroundColor(_ color: UIColor) -> Self {
        currentContainer().set(.backgroundColor, color)
        return self
    }
}
#endif
//MARK:- 整合平台通下 NSAttributedString.Key 值
extension GMLAttributesBuilder {
    
    func paragraphStyle(_ style: NSParagraphStyle) -> Self {
        currentContainer().set(.paragraphStyle, style)
        return self
    }
}
