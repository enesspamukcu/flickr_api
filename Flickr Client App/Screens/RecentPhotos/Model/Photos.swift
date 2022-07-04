//
//  Photos.swift
//  Flickr Client App
//
//  Created by mono on 2.07.2022.
//

import Foundation

struct Photos:Codable{
    let page:Int?
    let pages:Int?
    let perpage:Int?
    let total:Int?
    let photo:[Photo]?
    
}


