//
//  ApiCall.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-18.
//

import Foundation

class apiCall {
    func getApi(completion: @escaping (DineOnCampusAPI) -> ()) {
        // url of the api
        guard let url = URL(string: "https://api.dineoncampus.ca/v1/location/63b7353d92d6b47d412fff24/periods?platform=0&date=20230404") else { return }
        
        // fetch data from url
        URLSession.shared.dataTask(with: url) { data, response, error in
            // unwrap data, check for error in getting data
            guard let data = data, error == nil else {
                print("error: \(error!)")
                exit(EXIT_FAILURE)
            }
            
            // decode data into DineOnCampusAPI struct
            var api: DineOnCampusAPI
            do {
                api = try JSONDecoder().decode(DineOnCampusAPI.self, from: data)
            } catch {
                fatalError(error.localizedDescription)
            }
            
            // escape the api object
            DispatchQueue.main.async {
                completion(api)
            }
        }
        .resume()
    }
}
