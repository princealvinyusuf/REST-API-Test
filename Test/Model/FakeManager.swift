//
//  FakeManager.swift
//  Test
//
//  Created by Prince Alvin Yusuf on 09/04/21.
//

import Foundation

protocol FakeManagerDelegate {
    func didFailWithError(error: Error)
    func updateData(_ fakeManager: FakeManager, fakeModel: FakeModel)
}

class FakeManager {
    
    var delegate: FakeManagerDelegate?
    
    let url = "https://jsonplaceholder.typicode.com/posts/" // FETCH, POST
    let url2 = "https://jsonplaceholder.typicode.com/posts/1/" // DELETE, PUT
    
    
    func fetchData() {
        // Create a url
        
        if let urlString = URL(string: url) {
            // Crate a session
            
            let session = URLSession(configuration: .default)
            
            // Give a session a task
            let task = session.dataTask(with: urlString) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                
                if let safeData = data {
                    if let fakeData = self.fetchJSON(data: safeData) {
                        self.delegate?.updateData(self, fakeModel: fakeData)
                    }
                    
                }
            }
            
            // Execution
            task.resume()
        }
        
    }
    
    
    
    
    // MARK: - GET DATA
    
    func fetchJSON(data: Data) -> FakeModel? {
        let decode = JSONDecoder()
        var bodyData = [String]()
        var userIdData = [Int]()
        var idData = [Int]()
        var titleData = [String]()
        
        do {
            let decodedData = try decode.decode(Fake.self, from: data)
            for index in 0...99 {
                bodyData.append(decodedData[index].body)
                userIdData.append(decodedData[index].userID)
                idData.append(decodedData[index].id)
                titleData.append(decodedData[index].title)
                
            }
            
            let fakeModel = FakeModel(id: idData, userID: userIdData, title: titleData, body: bodyData)
            
            return fakeModel
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    
    
    
    // MARK: - POST DATA
    
    func postData() {
        // Prepare a URL
        let urlString = URL(string: url)
        guard let requestURL = urlString else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create model
        struct UploadData: Codable {
            let title: String
            let body: String
            let id : Int
            let userId: Int
        }
        
        // Add data to the model
        let uploadDataModel = UploadData(title: "Buku Dongeng", body: "Percobaan Membaca", id: 100, userId: 100)
        
        
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        // Set HTTP Request Body
        request.httpBody = jsonData
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if error != nil {
                print("Error took place \(error!)")
                return
            }
            
            // Convert HTTP response data to a string
            if let safeData = data {
                let dataString = String(data: safeData, encoding: .utf8)
                print("Response data string: \(dataString!)")
            }
            
            /// For TroubleShooting
            //            if let response = response as? HTTPURLResponse {
            //                    // Read all HTTP Response Headers
            //                    print("All headers: \(response.allHeaderFields)")
            //                    // Read a specific HTTP Response Header by name
            //                    print("Specific header: \(response.value(forHTTPHeaderField: "Content-Type") ?? " header not found")")
            //                }
        }
        
        task.resume()
    }
    
    
    
    
    // MARK: - DELETE DATA
    
    func deleteData() {
        // Prepare a URL
        let urlString = URL(string: url2)
        guard let requestURL = urlString else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if error != nil {
                print("Error took place \(error!)")
                return
            }
            
            // Convert HTTP response data to a string
            if let safeData = data {
                let dataString = String(data: safeData, encoding: .utf8)
                print("Response data string: \(dataString!)")
            }
            
        }
        
        task.resume()
    }
    
    
    
    
    
    // MARK: - PUT DATA / UPDATE DATA
    
    func putData() {
        // Prepare a URL
        let urlString = URL(string: url2)
        guard let requestURL = urlString else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create model
        struct UploadData: Codable {
            let title: String
            let body: String
            let id : Int
            let userId: Int
        }
        
        // Add data to the model
        let uploadDataModel = UploadData(title: "Prince Alvin", body: "iOS Developer", id: 20, userId: 20)
        
        
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        // Set HTTP Request Body
        request.httpBody = jsonData
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if error != nil {
                print("Error took place \(error!)")
                return
            }
            
            // Convert HTTP response data to a string
            if let safeData = data {
                let dataString = String(data: safeData, encoding: .utf8)
                print("Response data string: \(dataString!)")
            }
            
        }
        
        task.resume()
    }
    
    
    
}

