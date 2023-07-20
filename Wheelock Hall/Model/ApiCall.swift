//
//  ApiCall.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-18.
//

import Foundation

// class to get the dine on campus api
class ApiCall {
    func getApi(completion: @escaping (DineOnCampusAPI?) -> ()) {
        // get current date
        //let date = Date()
        //let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyyMMdd" // set date format to iso
        //let dateString = dateFormatter.string(from: date) // convert date to string
        
        // example date that has a current menu (april 4, 2023)
        // NOTE: only has rise and dine, once the api is avaliable again dont use it
        let dateString = "20230404"
        
        // url of the api
        guard let url = URL(string: "https://api.dineoncampus.ca/v1/location/63b7353d92d6b47d412fff24/periods?platform=0&date=\(dateString)") else { return }
        
        // fetch data from url
        URLSession.shared.dataTask(with: url) { data, response, error in
            // unwrap data, check for error in getting data
            guard let data = data, error == nil else {
                print("error: \(error!)")
                exit(EXIT_FAILURE)
            }
            
            // decode data into DineOnCampusAPI struct
            var api: DineOnCampusAPI?
            do {
                api = try JSONDecoder().decode(DineOnCampusAPI.self, from: data)
            } catch {
                api = nil
//                fatalError(error.localizedDescription)
            }
            
            // escape the api object
            DispatchQueue.main.async {
                completion(api)
            }
        }
        .resume()
    }
}
