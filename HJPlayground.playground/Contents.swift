//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
    deinit {
        print("Country deinit")
    }
    
    func swapAandB<T>(inout a:T, inout b:T) {
        let temp = a
        a = b
        b = temp
    }
}

class City {
    let name: String
    unowned var country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
    deinit {
        print("City deinit")
    }
}

var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")

var usaCountry: Country?
usaCountry = Country(name: "Amareca", capitalName: "Hston")
print("\(usaCountry!.name)'s capital city is called \(usaCountry!.capitalCity.name)")
usaCountry = nil

var midCountry = Country(name: "China", capitalName: "Beijing")
var cityAName = "London"
var cityBName = "Berlin"
midCountry.swapAandB(&cityAName, b: &cityBName)
print("now cityAname:\(cityAName),and cityBName:\(cityBName)")

