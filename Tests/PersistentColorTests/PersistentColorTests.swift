//
//  PersistentColorTests.swift
//  PersistentColorTests
//
//  Created by Jiaxin Shou on 2024/9/5.
//

@testable import PersistentColor
import Testing

@Suite
final class PersistentColorTests {
    @Test(arguments: [
        /// 8-digit lowercase hex (RRGGBBAA).
        ("ff0000ff", (1.00, 0.00, 0.00, 1.00)),
        ("00ff00ff", (0.00, 1.00, 0.00, 1.00)),
        ("0000ffff", (0.00, 0.00, 1.00, 1.00)),
        ("000000ff", (0.00, 0.00, 0.00, 1.00)),
        ("ffffff80", (1.00, 1.00, 1.00, 0.50)),

        /// 8-digit uppercase hex (RRGGBBAA).
        ("FF80FFFF", (1.00, 0.50, 1.00, 1.00)),

        /// 6-digit lowercase hex (RRGGBB).
        ("ff0000", (1.00, 0.00, 0.00, 1.00)),
        ("00ff00", (0.00, 1.00, 0.00, 1.00)),

        /// 4-digit lowercase hex (RGBA).
        ("f00f", (1.00, 0.00, 0.00, 1.00)),
        ("0f0f", (0.00, 1.00, 0.00, 1.00)),

        /// 3-digit lowercase hex (RGB).
        ("f00", (1.00, 0.00, 0.00, 1.00)),
        ("0f0", (0.00, 1.00, 0.00, 1.00)),

        /// With # prefix.
        ("#ff0000", (1.00, 0.00, 0.00, 1.00)),
        ("#f00", (1.00, 0.00, 0.00, 1.00)),
    ])
    func initFromValidHexValue(
        _ hex: String,
        expected: (r: Double, g: Double, b: Double, a: Double)
    ) async throws {
        let color = PersistentColor(hex)
        #expect(color != nil)
        #expect(color?.red.rounded(toPlaces: 2) == expected.r)
        #expect(color?.green.rounded(toPlaces: 2) == expected.g)
        #expect(color?.blue.rounded(toPlaces: 2) == expected.b)
        #expect(color?.alpha.rounded(toPlaces: 2) == expected.a)
    }

    @Test(arguments: [
        /// Empty string.
        "",

        /// Too short.
        "ff",

        /// Invalid length.
        "fffff",

        /// Invalid character.
        "fffffgff",

        /// Too long.
        "ffffffffff",

        /// Invalid length with # prefix.
        "#ff",

        /// Non-hex characters.
        "gg0000",

        /// Too long.
        "ff00ff00ff",
    ])
    func initFromInvalidHexValue(_ hex: String) async throws {
        let color = PersistentColor(hex)
        #expect(color == nil)
    }

    @Test(arguments: [
        ((1.00, 0.00, 0.00, 1.00), "ff0000ff"),
        ((0.00, 1.00, 0.00, 1.00), "00ff00ff"),
        ((0.00, 0.00, 1.00, 1.00), "0000ffff"),
        ((0.00, 0.00, 0.00, 1.00), "000000ff"),
        ((1.00, 1.00, 1.00, 0.50), "ffffff7f"),
    ])
    func hexValueFromRGBA(
        _ value: (r: Double, g: Double, b: Double, a: Double),
        expected: String
    ) async throws {
        let color = PersistentColor(
            red: value.r,
            green: value.g,
            blue: value.b,
            alpha: value.a
        )
        #expect(color.hexValue == expected)
    }
}
