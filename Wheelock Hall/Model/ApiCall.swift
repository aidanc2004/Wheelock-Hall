//
//  ApiCall.swift
//  Wheelock Hall
//
//  Created by Aidan Carey on 2023-07-18.
//

import Foundation

// class to get the dine on campus api
class ApiCall {
    static var period_ids: [String] = [""] // none for first period
    static var error: String? // not `Error?` because this is for the user
    
    // get menu information
    func getApi(period periodNumber: Int, completion: @escaping (DineOnCampusAPI?) -> ()) {
        // get current date
        //let date = Date()
        //let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyyMMdd" // set date format to iso
        //let dateString = dateFormatter.string(from: date) // convert date to string
        
        // example date that has a current menu (april 4, 2023)
        let dateString = "20230404"
        
        let period = Self.period_ids[periodNumber]
        
        // get the url of the api
        guard let url = URL(string: "https://api.dineoncampus.ca/v1/location/63b7353d92d6b47d412fff24/periods/\(period)?platform=0&date=\(dateString)") else { return }
        
        // fetch data from url
        URLSession.shared.dataTask(with: url) { data, response, error in
            // unwrap data and check for error in getting data
            guard let data = data, error == nil else {
                print(String(describing: error))
                Self.error = "Cannot connect."
                
                // escape nil to show error
                completion(nil)
                return
            }
            
            // decode data into DineOnCampusAPI struct
            var api: DineOnCampusAPI?
            do {
                api = try JSONDecoder().decode(DineOnCampusAPI.self, from: data)
            } catch {
                print(String(describing: error))
                Self.error = "No menu avaliable for \(Date().formatted(date: .abbreviated, time: .omitted))."
                
                // escape nil to show error
                completion(nil)
                return
            }
            
            // fill period_ids if it only has the default ""
            if Self.period_ids.count == 1 {
                Self.period_ids = [] // clear array
                
                let periods = api?.periods
                
                for period in periods! {
                    Self.period_ids.append(period.id)
                }
            }
            
            // escape the api object
            completion(api)
        }
        .resume()
    }
    
    // get id of school
    func getSchool(school slug: String, completion: @escaping (String?) -> ()) {
        // NOTE: only for canadian website, for US use
        // "https://api.dineoncampus.com/v1/sites/public"
        guard let url = URL(string: "https://api.dineoncampus.ca/v1/sites/public_ca") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // unwrap data and check for error in getting data
            guard let data = data, error == nil else {
                print(String(describing: error))
                Self.error = "Cannot connect."
                
                // escape nil to show error
                completion(nil)
                return
            }
            
            // decode data into Schools struct
            var schools: Schools
            do {
                schools = try JSONDecoder().decode(Schools.self, from: data)
            } catch {
                print(String(describing: error))
                Self.error = "Error getting schools."
                
                // escape nil to show error
                completion(nil)
                return
            }
            
            // look for school
            for school in schools.sites {
                if school.slug == slug {
                    // escape school id
                    completion(school.id)
                    return
                }
            }
            
            Self.error = "\(slug) not found."
            completion(nil)
        }
        .resume()
    }
}
