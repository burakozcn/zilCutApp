import Foundation

struct NetworkManagement {
  
  func check(completion: @escaping (HTTPURLResponse) -> ()) {
    let session = URLSession.shared
    
    let url = URL(string: "https://kiremitsoftware.com/check")!
    
    var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
    request.httpMethod = "GET"
    
    let sem = DispatchSemaphore(value: 0)
    let dataTask = session.dataTask(with: request) { (data, response, error) in
      if let error = error {
        print(error)
      }
      
      let responseDict = try? JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
      if let httpResponse = response as? HTTPURLResponse {
        completion(httpResponse)
      }
      sem.signal()
    }
    dataTask.resume()
    sem.wait()
  }
  
  func login(mail: String, password: String, completion: @escaping (HTTPURLResponse) -> ()) {
    let session = URLSession.shared
    
    let url = URL(string: "https://kiremitsoftware.com/login")!
    
    let parameters: [String : Any] = ["mail": mail, "password": password]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpShouldHandleCookies = true
    
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
      if let httpResponse = response as? HTTPURLResponse {
        completion(httpResponse)
      }
      sem.signal()
    }
    dataTask.resume()
    sem.wait()
  }
  
  func logout(completion: @escaping (HTTPURLResponse) -> ()) {
    let session = URLSession.shared
    
    let url = URL(string: "https://kiremitsoftware.com/logout")!
    
    var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
    request.httpMethod = "GET"
    
    let sem = DispatchSemaphore(value: 0)
    let dataTask = session.dataTask(with: request) { (data, response, error) in
      if let error = error {
        print(error)
      }
      
      let responseDict = try? JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
      if let httpResponse = response as? HTTPURLResponse {
        completion(httpResponse)
      }
      sem.signal()
    }
    dataTask.resume()
    sem.wait()
  }
  
  func insertMaterial(name: String, color: String, issueDate: String, partyNumber: String, userID: Int, active: Bool, width: Float, height: Float, completion: @escaping (Array<Dictionary<String, Any>>, HTTPURLResponse) -> ()) {
    let session = URLSession.shared
    
    let url = URL(string: "https://kiremitsoftware.com/material")!
    
    let parameters: [String : Any] = ["name": name, "color": color, "issueDate": issueDate, "partyNumber": partyNumber, "userID": userID, "active": active, "width": width, "height": height]
    
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
    
    let url = URL(string: "https://kiremitsoftware.com/material/indexNames")!
    
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
  
  func getMaterialRecord(partyNum: String, completion: @escaping (Array<Dictionary<String, Any>>) -> ()) {
    let session = URLSession.shared
    
    let url = URL(string: "https://kiremitsoftware.com/material/indexMat/\(partyNum)")!
    
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
  
  func insertCut(_ cutRecord: CutRecord, count: Int, partyNumber: String, completion: @escaping (Array<Dictionary<String, Any>>, HTTPURLResponse) -> (),
                 closure: @escaping () -> Void) {
    let session = URLSession.shared
    
    let url = URL(string: "https://kiremitsoftware.com/material/cut")!
    
    let parameters: [String : Any] = ["xStart": cutRecord.xStart, "xEnd": cutRecord.xEnd, "yStart": cutRecord.yStart, "yEnd": cutRecord.yEnd, "horizontal": cutRecord.horizontal, "vertical": cutRecord.vertical, "left": cutRecord.left, "up": cutRecord.up, "cutNumber" : "0000" + String(count), "userID": 323, "partyNumber": partyNumber]
    
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
      closure()
      sem.signal()
    }
    dataTask.resume()
    sem.wait()
  }
  
  func getCutRecord(partyNum: String, completion: @escaping (Array<Dictionary<String, Any>>) -> (), closure: @escaping () -> Void) {
    let session = URLSession.shared
    
    let url = URL(string: "https://kiremitsoftware.com/material/indexCut/\(partyNum)")!
    
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
      closure()
      sem.signal()
    }
    dataTask.resume()
    sem.wait()
  }
  
  func getAllMaterial(completion: @escaping (Array<Dictionary<String, Any>>) -> (), closure: @escaping () -> Void) {
    let session = URLSession.shared
    
    let url = URL(string: "https://kiremitsoftware.com/material")!
    
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
      closure()
      sem.signal()
    }
    dataTask.resume()
    sem.wait()
  }
  
  func getVersion(completion: @escaping (Array<Dictionary<String, Any>>) -> ()) {
    let session = URLSession.shared
    
    let url = URL(string: "https://kiremitsoftware.com/material/version")!
    
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
//      closure()
      sem.signal()
    }
    dataTask.resume()
    sem.wait()
  }
}
