//
//  PersistentColor+UI.swift
//  PersistentColor
//
//  Created by Jiaxin Shou on 2023/11/28.
//

import SwiftUI

@available(iOS 14.0, *)
public extension PersistentColor {
    var color: Color {
        get {
            .init(red: red, green: green, blue: blue, opacity: alpha)
        }
        set {
            self = .init(newValue)
        }
    }

    init(_ color: Color) {
        let rgba = UIColor(color).rgba
        self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }

    init(_ colorSpace: Color.RGBColorSpace = .sRGB, white: Double, opacity: Double = 1) {
        self.init(.init(colorSpace, white: white, opacity: opacity))
    }
}

@available(iOS 14.0, *)
public extension PersistentColor {
    /// A color that reflects the accent color of the system or app.
    static var accentColor: PersistentColor {
        .init(.accentColor)
    }
}

@available(iOS 15.0, *)
extension PersistentColor: ShapeStyle {
    public func resolve(in _: EnvironmentValues) -> some ShapeStyle {
        color
    }
}

private extension UIColor {
    var rgba: (red: Double, green: Double, blue: Double, alpha: Double) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (Double(red), Double(green), Double(blue), Double(alpha))
    }
}
