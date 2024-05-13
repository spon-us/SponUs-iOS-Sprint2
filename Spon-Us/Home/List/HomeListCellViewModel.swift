//
//  HomeListCellViewModel.swift
//  Spon-Us
//
//  Created by 박현수 on 5/12/24.
//

import Foundation

@Observable
final class HomeListCellViewModel {
    var isLoaded = false
    
    let companyName: String
    let imageURL: String
    var isBookmarked: Bool = false
    
    init(companyName: String, imageURL: String) {
        self.companyName = companyName
        self.imageURL = imageURL
    }
}
