//
//  Network.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/15/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import PromiseKit

class Network: NetworkType, RequestAdapter {
    var manager: SessionManager = SessionManager.default
    var additionalHeaders: [String: String] = [:]
    var httpErrorParser: HTTPErrorParserType
    let baseURL = Constants.URLs.baseURL
    
    init(httpErrorParser: HTTPErrorParserType) {
        self.httpErrorParser = httpErrorParser
        manager.adapter = self
    }
    
    func setDefaultHeader(key: String, value: String) {
        additionalHeaders[key] = value
    }
    
    func removeDefaultHeader(key: String) {
        additionalHeaders.removeValue(forKey: key)
    }
    
    func setIOSHeader() {
        additionalHeaders["X-Platform"] = "IOS"
    }
    
    func setRetrier(retrier: RequestRetrier) {
        manager.retrier = retrier
    }
    
    func request(method: Method, url: String) -> Promise<Data> {
        return request(method: method, url: url, json: nil)
    }
    
    func request(method: Method, url: String, json: [String: Any]?) -> Promise<Data> {
        return Promise { (fulfill, reject) in
            guard let httpMethod = HTTPMethod(rawValue: method.rawValue) else {
                throw CustomError(message: "Try again")
            }
            manager.request(url, method: httpMethod, parameters: json, encoding: JSONEncoding.default)
                .debugLog()
                .validate()
                .responseData(completionHandler: { response in
                    
                    debugPrint("response -> " + response.debugDescription)
                    debugPrint("response data -> ")
                    debugPrint(response.data?.description ?? "")
                    switch response.result {
                    case .success(let data):
                        fulfill(data)
                    case .failure(_):
                        print("response.response.statuscode")
                        print(response.response?.statusCode ?? 0)
                        if let code = response.response?.statusCode, response.data?.count == 0 {
                            reject(BackendError.badStatusWithStatusCode(code))
                        } else {
                            reject(BackendError.badStatusWithData(response.data ?? Data()))
                        }
                    }
                })
            }.recover { error -> Promise<Data> in
                throw self.httpErrorParser.parseHTTPError(error: error)
        }
    }
    
    func upload(url: String, data: Data) -> Promise<Void> {
        return uploadMethod(url: url, data: data)
    }
    
    func uploadMethod(url: String, data: Data) -> Promise<Void> {
        return Promise { (fulfill, reject) in
            guard let URL = URL(string: url) else {
                throw CustomError(message: "Wrong url")
            }
            manager.upload(data, to: URL, method: .put, headers: nil)
                .debugLog()
                .validate()
                .responseData(completionHandler: { response in
                    switch response.result {
                    case .success(_):
                        fulfill(())
                    case .failure(_):
                        print("response.response.statuscode")
                        print(response.response?.statusCode ?? 0)
                        if let code = response.response?.statusCode, let isResponseDataEmpty = response.data?.isEmpty, isResponseDataEmpty {
                            reject(BackendError.badStatusWithStatusCode(code))
                        } else {
                            reject(BackendError.badStatusWithData(response.data ?? Data()))
                        }
                    }
                })
            }.recover { error -> Promise<Void> in
                throw self.httpErrorParser.parseHTTPError(error: error)
        }
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        
        guard let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(Constants.URLs.baseURL) else {
            return urlRequest
        }
        var urlRequest = urlRequest
        urlRequest.setValue("IOS", forHTTPHeaderField: "X-Platform")
        guard let refreshString = urlRequest.url?.absoluteString,
            !refreshString.hasPrefix(baseURL + "/user/refresh-access-token") else {
                return urlRequest
        }
        
        guard additionalHeaders["Authorization"] != nil else {
            return urlRequest
        }
        
        urlRequest.setValue(additionalHeaders["Authorization"]!, forHTTPHeaderField: "Authorization")
        //urlRequest.setValue("IOS", forHTTPHeaderField: "X-Platform")
        return urlRequest
    }
}

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
            debugPrint(self)
        #endif
        return self
    }
}
