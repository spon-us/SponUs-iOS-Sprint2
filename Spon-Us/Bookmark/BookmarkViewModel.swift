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
    let target: Int
    var companyName: String
    var imageURL: String?
    
    init(bookmarkModel: BookmarkModel) {
        self.target = bookmarkModel.target
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
    
    func postBookmark(target: Int, completion: @escaping (Bool) -> Void) {
        provider.request(.postBookmark(target: target)) { response in
            switch response {
            case .success(let response):
                do {
                    _ = try JSONDecoder().decode(postBookmarkResponseModel.self, from: response.data)
                    completion(true)
                } catch {
                    print("post bookmark decode error", error.localizedDescription)
                    completion(false)
                }
            case .failure(let error):
                print("postBookmark API error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}
