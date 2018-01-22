//
//  MappingType.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/15/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import ObjectMapper
import PromiseKit

protocol MappingType {
    
    func map<T: Mappable>(data: Data) -> Promise<[T]>
    
    func map<T: Mappable>(data: Data) -> Promise<T>
    
    func map<V: Mappable>(data: Data) -> Promise<[String: V]>
    
    func map<T: ImmutableMappable>(data: Data) -> Promise<[T]>
    
    func map<T: ImmutableMappable>(data: Data) -> Promise<T>
    
    func map<V: ImmutableMappable>(data: Data) -> Promise<[String: V]>
}
