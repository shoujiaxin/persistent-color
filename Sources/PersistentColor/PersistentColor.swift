//
//  PersistentColor.swift
//  PersistentColor
//
//  Created by Jiaxin Shou on 2023/11/27.
//

import Foundation

@frozen
public struct PersistentColor: Hashable, Sendable {
    /// The red component of the color.
    let red: Double

    /// The green component of the color.
    let green: Double

    /// The blue component of the color.
    let blue: Double

    /// The alpha value of the color.
    let alpha: Double

    var hexValue: String {
        .init(
            format: "%02x%02x%02x%02x",
            Int(red * 255),
            Int(green * 255),
            Int(blue * 255),
            Int(alpha * 255)
        )
    }

    public init(red: Double, green: Double, blue: Double, alpha: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    public init?(_ hexValue: String) {
        guard hexValue.count == 8 else {
            return nil
        }

        var rgba: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgba)
        self.init(
            red: Double((rgba & 0xFF00_0000) >> 24) / 255,
            green: Double((rgba & 0x00FF_0000) >> 16) / 255,
            blue: Double((rgba & 0x0000_FF00) >> 8) / 255,
            alpha: Double(rgba & 0x0000_00FF) / 255
        )
    }
}

/// Fix compatibility issues with SwiftData.
extension PersistentColor: Codable {
    private enum CodingKeys: String, CodingKey {
        case red
        case green
        case blue
        case alpha
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        red = try container.decode(Double.self, forKey: .red)
        green = try container.decode(Double.self, forKey: .green)
        blue = try container.decode(Double.self, forKey: .blue)
        alpha = try container.decode(Double.self, forKey: .alpha)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(red, forKey: .red)
        try container.encode(green, forKey: .green)
        try container.encode(blue, forKey: .blue)
        try container.encode(alpha, forKey: .alpha)
    }
}

extension PersistentColor: Identifiable {
    public typealias ID = String

    public var id: ID {
        hexValue
    }
}

extension PersistentColor: RawRepresentable {
    public typealias RawValue = String

    public var rawValue: RawValue {
        hexValue
    }

    public init?(rawValue: RawValue) {
        self.init(rawValue)
    }
}
