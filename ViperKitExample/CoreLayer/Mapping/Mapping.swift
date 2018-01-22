//
//  Mapping.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/15/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import ObjectMapper
import PromiseKit

class Mapping: MappingType {
    
    func map<T: Mappable>(data: Data) -> Promise<[T]> {
        debugPrint(data)
        guard let response = String(data: data, encoding: .utf8) else {
            return Promise(error: BackendError.unconvertableData)
        }
        
        debugPrint(response)
        guard let ts = Mapper<T>().mapArray(JSONString: response) else {
            return Promise(error: BackendError.unconvertableData)
        }
        
        return Promise(value: ts)
    }
    
    func map<T: Mappable>(data: Data) -> Promise<T> {
        debugPrint(data)
        guard let response = String(data: data, encoding: .utf8) else {
            return Promise(error: BackendError.unconvertableData)
        }
        debugPrint(response)
        guard let t = Mapper<T>().map(JSONString: response) else {
            return Promise(error: BackendError.unconvertableData)
        }
        
        return Promise(value: t)
    }
    
    func map<V: Mappable>(data: Data) -> Promise<[String: V]> {
        debugPrint(data)
        guard let response = String(data: data, encoding: .utf8) else {
            return Promise(error: BackendError.unconvertableData)
        }
        debugPrint(response)
        guard let dict = Mapper<V>().mapDictionary(JSONString: response) else {
            return Promise(error: BackendError.unconvertableData)
        }
        
        return Promise(value: dict)
    }
    
    func map<T: ImmutableMappable>(data: Data) -> Promise<[T]> {
        debugPrint(data)
        guard let response = String(data: data, encoding: .utf8) else {
            return Promise(error: BackendError.unconvertableData)
        }
        debugPrint(response)
        do {
            let ts = try Mapper<T>().mapArray(JSONString: response)
            return Promise(value: ts)
        } catch {
            return Promise(error: error)
        }
    }
    
    func map<T: ImmutableMappable>(data: Data) -> Promise<T> {
        debugPrint(data)
        guard let response = String(data: data, encoding: .utf8) else {
            return Promise(error: BackendError.unconvertableData)
        }
        debugPrint(response)
        do {
            let t = try Mapper<T>().map(JSONString: response)
            return Promise(value: t)
        } catch {
            return Promise(error: error)
        }
    }
    
    func map<V: ImmutableMappable>(data: Data) -> Promise<[String: V]> {
        debugPrint(data)
        guard let response = String(data: data, encoding: .utf8) else {
            return Promise(error: BackendError.unconvertableData)
        }
        debugPrint(response)
        do {
            let dict = try Mapper<V>().mapDictionary(JSONString: response)
            return Promise(value: dict)
        } catch {
            return Promise(error: error)
        }
    }
    
}


