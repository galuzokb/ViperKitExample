//
//  Constants.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/15/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation

struct Constants {
    struct URLs {
        static let baseURL = "http://www.softomate.net/"
        static let basePostsURL = "https://jsonplaceholder.typicode.com/"
    }
    
    enum ErrorCode: String {
        case accessExpired = "TOKEN_IS_EXPIRED"
        case accessDenied = "ACCESS_DENIED"
        case unauthorized = "UNAUTHORIZED"
        case notVerified = "NOT_VERIFIED"
        case incorrectVerificationCode = "INCORRECT_VERIFICATION_CODE"
        case notFound = "NOT_FOUND"
        case badRequest = "BAD_REQUEST"
        case defaultCode = "SOMETHING_GOES_WRONG"
        case conflict = "CONFLICT"
        case refreshExpired = "REFRESH_IS_EXPIRED"
        case arrivalConflict = "ARRIVAL_CONFLICT"
        case spotOwnerConflict = "SPOT_OWNER_CONFLICT"
        case notSpotMember = "NOT_SPOT_MEMBER"
        case spotMemberConflict = "SPOT_MEMBER_CONFLICT"
        case tooLateToJoin = "TOO_LATE_TO_JOIN"
        case noActiveSpot = "NO_ACTIVE_SPOT"
        case none = ""
    }
    
    struct Constraints {
        static let minPostTVHeight = 50.0
        static let maxPostTVHeight = 150.0
    }
}
