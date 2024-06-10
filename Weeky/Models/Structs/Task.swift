//
//  Task.swift
//  Weeky
//
//  Created by Екатерина Кондратьева
//

import SwiftUI

struct Task: Identifiable, Codable, Hashable {
    var id = UUID().uuidString
    var title: String = ""
    var dateString: String = ""
    var colorName = ""
    var isCompleted: Bool = false


}


