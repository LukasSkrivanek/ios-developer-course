//
//  PageEnum.swift
//  Course App
//
//  Created by macbook on 31.05.2024.
//

import Foundation

enum Page: Int, CaseIterable {
   case firstPage
   case secondPage
   case thirdPage
   var title: String {
       switch self {
       case .firstPage:
           "First page"
       case .secondPage:
           "Second page"
       case .thirdPage:
           "Third page"
       }
   }
}
