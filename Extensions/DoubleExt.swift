//
//  DoubleExt.swift
//  SiriKit-LegDay
//
//  Created by Erish Latorre on 7/2/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import Foundation

extension Double {
    func convertToClockTime() -> String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%0d:%02d", minutes, seconds)
    }
}
