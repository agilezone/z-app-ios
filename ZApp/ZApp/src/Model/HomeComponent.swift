//
//  HomeComponent.swift
//  ZApp
//
//  Created by Ce YANG on 29/06/14.
//  Copyright (c) 2014 AgileZone. All rights reserved.
//

import Foundation


class HomeComponent {
    enum kComponentType : Int {
        case homeSection = 1
        case firstLevelMenu
        case secondLevelMenu
    }

    var componentType : kComponentType?
    var subSection: HomeComponent[]?
    var sectionName: String?

    init (componentType : kComponentType?, sectionName: String?){
        self.sectionName = sectionName
        self.componentType = componentType
    }
    
    
}