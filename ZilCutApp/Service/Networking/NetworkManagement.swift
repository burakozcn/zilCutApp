import Foundation

struct NetworkManagement {
  
  func insertMaterial(name: String, color: String, issueDate: Date, partyNumber: String, userID: Int, active: Bool, width: Float, height: Float, completion: @escaping (Array<Dictionary<String, Any>>, HTTPURLResponse) -> ()) {
    let session = URLSession.shared
    
    let url = URL(string: "http://localhost:8080/material")!
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd hh:mm:ss"
    
    let parameters: [String : Any] = ["name": name, "color": color, "issueDate": df.string(from: issueDate), "partyNumber": partyNumber, "userID": userID, "active": active, "width": width, "height": height]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
    } catch {
      print("JSON Serialization Error")
    }
    let sem = DispatchSemaphore(value: 0)
    let dataTask = session.dataTask(with: request) { (data, response, error) in
      if let error = error {
        print(error)
      }
      
      let responseDict = try? JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
      if let dict = responseDict as? Array<Dictionary<String, Any>> {
        if let httpResponse = response as? HTTPURLResponse {
          completion(dict, httpResponse)
        }
      }
      sem.signal()
    }
    dataTask.resume()
    sem.wait()
  }
  
  func getNames(completion: @escaping (Array<Dictionary<String, Any>>) -> ()) {
    let session = URLSession.shared
    
    let url = URL(string: "http://localhost:8080/material/indexNames")!
    
    var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
    request.httpMethod = "GET"
    
    let sem = DispatchSemaphore(value: 0)
    let dataTask = session.dataTask(with: request) { (data, response, error) in
      if let error = error {
        print(error)
      }
      
      let responseDict = try? JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
      if let dict = responseDict as? Array<Dictionary<String, Any>> {
        completion(dict)
      }
      sem.signal()
    }
    dataTask.resume()
    sem.wait()
  }
}
