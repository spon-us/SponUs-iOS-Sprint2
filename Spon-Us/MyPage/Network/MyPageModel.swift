//
//  MyPageModel.swift
//  Spon-Us
//
//  Created by 황인성 on 7/1/24.
//

import Foundation
import UIKit

struct ClubProfile {
    var image: UIImage?
    var name: String
    var introduce: String
    var member: Int
    var link: Link?
    var fields: [String]
}

struct Link {
    var instagram: String
    var facebook: String
    var website: String
}

struct Portfolio {
    var projectName: String
    var activityDetail: String
//    var date
    var multiImage: [UIImage]
}
