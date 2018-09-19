//
//  NetworkManager.swift
//  Cars24
//
//  Created by Coffeebeans on 18/09/18.
//  Copyright © 2018 Coffeebeans. All rights reserved.
//

import Foundation

class NetworkManager {
    static let sharedInstance=NetworkManager()
    
    //MARK:API for facilities
    func getDataForFacilititesAndOptions(completion:@escaping((FacilitiesModel?,Error?)->Void)) {
        URLSession.shared.dataTask(with: URL(string: facilitiesAndOptionsApiURL)!) { (data, response, error) in
            if(error == nil && data != nil){
                do{
                    let decoder = JSONDecoder()
                    let modelToSend = try decoder.decode(FacilitiesModel.self, from: data!)
                    completion(modelToSend,nil)
                }catch let parseerror {
                    //TODO:Handle parsing error
                    completion(nil,parseerror)
                }
            }else{
                //TODO:Handle Error
                completion(nil,error)
            }
        }.resume()
    }

}
