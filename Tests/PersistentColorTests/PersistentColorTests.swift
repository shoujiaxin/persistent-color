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
    @Test
    func initFromHexValue() async throws {
        #expect(PersistentColor("") == nil)

        let white = PersistentColor("ffffffff")
        #expect(white?.red == 1 && white?.green == 1 && white?.blue == 1 && white?.alpha == 1)

        let black = PersistentColor("000000ff")
        #expect(black?.red == 0 && black?.green == 0 && black?.blue == 0 && black?.alpha == 1)

        let red = PersistentColor("ff0000ff")
        #expect(red?.red == 1 && red?.green == 0 && red?.blue == 0 && red?.alpha == 1)

        let green = PersistentColor("00ff00ff")
        #expect(green?.red == 0 && green?.green == 1 && green?.blue == 0 && green?.alpha == 1)

        let blue = PersistentColor("0000ffff")
        #expect(blue?.red == 0 && blue?.green == 0 && blue?.blue == 1 && blue?.alpha == 1)

        let transparent = PersistentColor("ffffff00")
        #expect(transparent?.red == 1 && transparent?.green == 1 && transparent?.blue == 1 && transparent?.alpha == 0)
    }

    @Test
    func hexValue() async throws {
        let hexValues = [
            "ffffffff",
            "000000ff",
            "ff0000ff",
            "00ff00ff",
            "0000ffff",
            "ffffff00",
        ]

        for hex in hexValues {
            let color = PersistentColor(hex)
            #expect(color?.hexValue == hex)
        }
    }
}
