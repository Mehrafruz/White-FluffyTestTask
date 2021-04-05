//
//  Weather.swift
//  WhiteAndFluffyTestTask
//
//  Created by Мехрафруз on 01.04.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation

struct Weather: Codable{
    let fact: Fact
    let geo_object: GeoObject
    
    struct Fact: Codable{
        let temp: Double
        let feels_like: Double
        let icon: String
        let condition: String
        let wind_speed: Double
        let pressure_mm: Double
    }
    
    struct GeoObject: Codable{
        let locality: Name
    }
    
    struct Name: Codable{
        let name: String
    }
}

