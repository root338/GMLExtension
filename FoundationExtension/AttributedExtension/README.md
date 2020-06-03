## AttributedExtension
对创建 NSAttributedString 进行一层包装
主要文件说明:
1. GMLRichTextBuilder NSAttributedString 的构建器，主要负责处理 NSAttributedString 的创建/修改/拼接
2. GMLAttributesBuilder 富文本属性([NSAttributedString.Key : Any]) 构建器，为 NSAttributedString.Key 各个属性提供快捷设置方法
3. GMLAttributedStringExtension 对 NSAttributedString 的扩展
4. GMLAttributesBuilderExtension 对 GMLAttributesBuilder 的扩展，提供一些对 NSAttributedString.Key 内部属性的快捷创建方法
5. GMLAttributesKeyDefines 一般为 GMLAttributesBuilde 内部用的类型定义
6. GMLAttributedStringDefines 一般为 NSAttributedString 所用类型的定义
