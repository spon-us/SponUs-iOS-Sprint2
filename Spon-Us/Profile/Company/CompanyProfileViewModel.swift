//
//  CompanyProfileVIewModel.swift
//  Spon-Us
//
//  Created by 박현수 on 5/14/24.
//

import Foundation

@Observable
final class CompanyProfileViewModel {
    var companyname: String = "무신사"
    var coworkCategory: [CoworkCategory] = [.linkedProject, .partnership, .sponsorship]
    var companyCategory: [CompanyCategory] = [.food, .education, .beauty]
    var sponsoredGoods: String = "풀무원선물세트풀무원선물세트풀무원선물세트풀무원선물세트"
    var isBookmarked = false
    var isSuggestModalPresented = false
}
