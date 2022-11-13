//
//  NetworkManagre.swift
//  SaltCodeTest
//
//  Created by Chrismanto Natanail Manik on 13/11/22.
//

import Foundation

class NetworkManager: NSObject{
    typealias LoginCompletion = (LoginResponse?, NetworkError?) -> ()
    typealias UserCompletion = (UserResponse?, NetworkError?) -> ()
    
    
    
    
    var endPoint: EndPointType?
    
    func fetchData(with endPoint: EndPointType,params: [String: String], completion: @escaping UserCompletion){
        self.endPoint = endPoint
        
        // Construct a URL by assigning its parts to a URLComponents value
        var components = URLComponents()
        components.scheme = "https"
        components.host = endPoint.baseUrl
        components.path = endPoint.path
        
        var queryItems : [URLQueryItem] = []
        for(key,value) in params {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        components.queryItems = queryItems
        
        guard let url = components.url else {
            print("\(NetworkError.missingUrl.rawValue)")
            completion(nil, .missingUrl)
            return
        }
        
        
        //Create request to url
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue.uppercased()
        
        // Set the headers to request
        if let headers = endPoint.headers {
            for(key, value) in headers{
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed request from: \(error!.localizedDescription)")
                    completion(nil, .failed)
                    return
                }
                guard let data = data else {
                    print("No data returned from Weatherbit")
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable to process Weatherbit response")
                    completion(nil, .failed)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failure response from : \(response.statusCode)")
                    completion(nil, .badRequest)
                    return
                }
                
                do {
                    print(data)
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(UserResponse.self, from: data)
                    completion(responseData, nil)
                } catch {
                    print("Unable to decode User Data response: \(error.localizedDescription)")
                    completion(nil, .noData)
                }
            }
        }.resume()
    }
    func requestLogin(with endPoint: EndPointType, body: [String: String]?, completion: @escaping LoginCompletion){
        self.endPoint = endPoint
        
        // Construct a URL by assigning its parts to a URLComponents value
        var components = URLComponents()
        components.scheme = "https"
        components.host = endPoint.baseUrl
        components.path = endPoint.path
        
        guard let url = components.url else {
            print("\(NetworkError.missingUrl.rawValue)")
            completion(nil, .missingUrl)
            return
        }
        
        //Create request to url
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue.uppercased()
        
        //Set the headers to request
        if let headers = endPoint.headers {
            for(key, value) in headers{
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        var bodyData = Data()
        
        if let body = body{
            do{
                bodyData = try JSONSerialization.data(withJSONObject: body)
            }catch{
                print(NetworkError.noData.rawValue)
            }
        }
        request.httpBody = bodyData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed request from: \(error!.localizedDescription)")
                    completion(nil, .failed)
                    return
                }
                
                guard let data = data else {
                    print("No data returned from Reqres")
                    completion(nil, .noData)
                    return
                }
                
//                guard let response = response as? HTTPURLResponse else {
//                    print("Unable to process Reqres response")
//                    completion(nil, .failed)
//                    return
//                }
//                
//                guard response.statusCode == 200 else {
//                    print("Failure response from : \(response.statusCode)")
//                    completion(nil, .badRequest)
//                    return
//                }
                
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(LoginResponse.self, from: data)
                    completion(responseData, nil)
                } catch {
                    print("Unable to decode Login Data response: \(error.localizedDescription)")
                    completion(nil, .noData)
                }
            }
        }.resume()
    }
}


