//
//  Score.swift
//  love competence
//
//  Created by saki shishikura on 2022/06/05.
//

import Foundation
import RealmSwift

class Score: Object {
    @objc dynamic var createdAt = Date()
    @objc dynamic var totalScore: Double = 0
    @objc dynamic var finalCon: Double = 0
    @objc dynamic var finalMen: Double = 0
}
