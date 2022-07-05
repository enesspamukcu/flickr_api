//
//  NetworkManager.swift
//  Flickr Client App
//
//  Created by mono on 5.07.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager() //Singleton
    
    func fetchImage(with url:String?,competion: @escaping (Data) -> Void){
        if let urlString = url, let url = URL(string: urlString){
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data,response,error in
                if error != nil {
                    print("Something went wrong image")
                    return
                }
                if let data = data {
                 DispatchQueue.main.async {
                    competion(data)
            }
        }
    }.resume()
}
}
}
