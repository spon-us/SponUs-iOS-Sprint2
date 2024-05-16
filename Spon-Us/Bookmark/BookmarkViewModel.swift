//
//  BookmarkViewModel.swift
//  Spon-Us
//
//  Created by KimYuBin on 5/12/24.
//

import Foundation

@Observable
final class BookmarkListCellViewModel {
    var isLoaded = false
    var companyName: String
    var imageURL: String
    var isBookmarked: Bool = false
    
    init(companyName: String, imageURL: String) {
        self.companyName = companyName
        self.imageURL = imageURL
    }
}
