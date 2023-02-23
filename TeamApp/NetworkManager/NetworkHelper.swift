//
//  NetworkHelper.swift
//  TeamApp
//
//  Created by APPLE on 22/02/23.
//

import Foundation


enum MatchEndPoints:String, CaseIterable{
    case match1 = "nzin01312019187360.json"
    case match2 = "sapk01222019186652.json"
    
    var completeURL: String {
        return NetworkHelper.baseUrl + self.rawValue
    }
}

struct NetworkHelper{
    static var baseUrl = "https://demo.sportz.io/"
}

