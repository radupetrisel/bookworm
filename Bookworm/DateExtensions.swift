//
//  DateExtensions.swift
//  Bookworm
//
//  Created by Radu Petrisel on 17.07.2023.
//

import Foundation

extension Date {
    var ignoreTime: Date {
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: self)
        
        return Calendar.current.date(from: dateComponents) ?? self
    }
}
