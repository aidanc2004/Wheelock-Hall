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
    static var schoolID: String?
    static var locationID: String?
    static var title: String?
    
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
        
        getLocationID(school: "acadiau", location: "Wheelock Dining Hall") { locationID in
            guard let locationID else {
                Self.error = "Could not get school and location."
                completion(nil)
                return
            }
            
            // get the url of the api
            let url = URL(string: "https://api.dineoncampus.ca/v1/location/\(locationID)/periods/\(period)?platform=0&date=\(dateString)")!
            
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
    }
    
    // get id of school (ex. acadiau)
    func getSchool(school slug: String, completion: @escaping (String?) -> ()) {
        // dont call api if school id is already stored
        if Self.schoolID != nil {
            completion(Self.schoolID)
            return
        }
        
        // NOTE: only for canadian website, for US use
        // "https://api.dineoncampus.com/v1/sites/public"
        let url = URL(string: "https://api.dineoncampus.ca/v1/sites/public_ca")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // unwrap data and check for error in getting data
            guard let data = data, error == nil else {
                print("school id: couldn't connect")
                completion(nil)
                return
            }
            
            // decode data into Schools struct
            var schools: Schools
            do {
                schools = try JSONDecoder().decode(Schools.self, from: data)
            } catch {
                print("school id: couldn't decode json")
                completion(nil)
                return
            }
            
            // look for school
            for school in schools.sites {
                if school.slug == slug {
                    // escape school id
                    Self.schoolID = school.id
                    completion(school.id)
                    return
                }
            }
            
            // unable to find school
            print("school id: \(slug) not found.")
            completion(nil)
        }
        .resume()
    }
    
    // get id of location (ex. wheelock hall)
    func getLocationID(school: String, location name: String, completion: @escaping (String?) -> ()) {
        getSchool(school: school) { schoolID in
            // dont call api if location id is already stored
            if Self.locationID != nil {
                completion(Self.locationID)
                return
            }
            
            guard let schoolID else {
                completion(nil)
                return
            }
            
            let url = URL(string: "https://api.dineoncampus.ca/v1/locations/buildings_locations?site_id=\(schoolID)")!
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                // unwrap data and check for error in getting data
                guard let data = data, error == nil else {
                    print("location id: couldn't connect")
                    completion(nil)
                    return
                }
                
                // decode data into Schools struct
                var locations: Locations
                do {
                    locations = try JSONDecoder().decode(Locations.self, from: data)
                } catch {
                    print("locaiton id: couldn't decode json")
                    completion(nil)
                    return
                }
                
                // look for location
                for location in locations.standalone_locations {
                    if location.name == name {
                        // escape locations id
                        Self.locationID = location.id
                        Self.title = location.name // get title for TitleView
                        completion(location.id)
                        return
                    }
                }
                
                // unable to find location
                print("location id: \(name) not found.")
                completion(nil)
            }
            .resume()
        }
    }
}
