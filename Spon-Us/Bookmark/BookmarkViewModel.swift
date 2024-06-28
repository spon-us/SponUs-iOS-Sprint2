//
//  BookmarkViewModel.swift
//  Spon-Us
//
//  Created by KimYuBin on 5/12/24.
//

import Foundation
import Moya

@Observable
final class BookmarkListCellViewModel: Identifiable {
    var isLoaded = false
    var companyName: String
    var imageURL: String?
    var isBookmarked: Bool = false
    let id: Int
    
    init(bookmarkModel: BookmarkModel) {
        self.id = bookmarkModel.id
        self.companyName = bookmarkModel.name
        self.imageURL = bookmarkModel.imageUrl
    }
}

@Observable
final class BookmarkListViewModel {
    var bookmarkList: [BookmarkListCellViewModel] = []
    let provider = MoyaProvider<SponusAPI>()
    
    func fetchBookmarks(sort: BookmarkTargetType, completion: @escaping (Bool) -> Void) {
        provider.request(.getBookmark(sort: sort)) { response in
            switch response {
            case .success(let response):
                do {
                    let bookmarkResponse = try JSONDecoder().decode(BookmarkResponseModel.self, from: response.data)
                    self.bookmarkList = bookmarkResponse.content.map { BookmarkListCellViewModel(bookmarkModel: $0) }
                    completion(true)
                } catch let error {
                    print("fetch bookmark decode error: \(error.localizedDescription)")
                    completion(false)
                }
            case .failure(let error):
                print("getBookmark API error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}
