//
//  EventEmmiter.swift
//  Course App
//
//  Created by macbook on 30.05.2024.
//

import Foundation
import Combine

protocol EventEmitting {
    associatedtype Event
    var eventPublisher: AnyPublisher<Event, Never> { get }
}
