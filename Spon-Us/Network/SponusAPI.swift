//
//  SponusAPI.swift
//  Spon-Us
//
//  Created by 박현수 on 6/23/24.
//

import Foundation
import Moya


enum SponusAPI {
    
}

extension SponusAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.sponus.co.kr/api/v2")!
    }
    
    var path: String {
        switch self {
            
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        }
    }
    
    var sampleData: Data {
        switch self {
            
        }
    }
    
    var task: Task {
        switch self {
            
        }
    }
    
    var validationType: ValidationType {
        switch self {
            
        }
    }
    
    var headers: [String : String]? {
        switch self {
            
        }
    }
}
