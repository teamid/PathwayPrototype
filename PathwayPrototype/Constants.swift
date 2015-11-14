//
//  Images.swift
//  PathwayPrototype
//
//  Created by David Smith on 11/12/15.
//  Copyright © 2015 David Smith. All rights reserved.
//

import UIKit

struct Constants {
      struct Images {
            static private let img: String -> UIImage = { name in
                  guard let image = UIImage(named: name) else{
                        fatalError("Failed to get image named: \(name)")
                  }
                  return image
            }
            static let rio = img("Rio")
            static let ibiza = img("Ibiza")
            static let whistler = img("Whistler")
            static let tab = img("Tab")
            
            struct Whistler {
                  static let deckerJesus = img("JesusChristSuperstar")
                  static let frenchieHanging = img("HangingOnTheEdge")
                  static let bros = img("TopOfTheMountain")
                  static let loveDE = img("Love")
                  static let lookingOutTheHeli = img("LookingOutTheWindow")
                  static let bored = img("BoredOnHeli")
                  static let beanie = img("Beanie")
                  static let beer = img("Beer")
                  
                  static let AllValues: [UIImage] = [
                        deckerJesus,
                        frenchieHanging,
                        bros,
                        loveDE,
                        lookingOutTheHeli,
                        bored,
                        beanie,
                        beer
                  ]
            }
      }
      
      
      struct Users {
            static let david = "David Smith"
            static let frenchie = "James Ephrati"
            static let decker = "Sam Decker"
      }
      
      struct Footprints {
            typealias WImage = Images.Whistler
            static let AllValues: [Footprint] = [
                  Footprint(WImage.deckerJesus, Users.decker),
                  Footprint(WImage.frenchieHanging, Users.frenchie),
                  Footprint(WImage.bros, Users.david),
                  Footprint(WImage.loveDE, Users.david),
                  Footprint(WImage.lookingOutTheHeli, Users.decker),
                  Footprint(WImage.bored, Users.frenchie),
                  Footprint(WImage.beanie, Users.david),
                  Footprint(WImage.beer, Users.decker),
                  Footprint(WImage.deckerJesus, Users.decker)
            ]
            
            static let captions: [String] = [
                  "I like ur personality bitch. You wanna see the dragon",
                  "Let's masturbate and stare into each other's eyes. Chipotle on me after",
                  "Has anyone else realized that the Eiffel Tower is just a big hunk of metal?",
                  "Stonehenge is just big bits of stone in a big field",
                  "My 8 year old builds better pyramids than the egyptians could, and they're really old!",
                  "Dude, you should've told me that the Golden Gate Bridge is red — bait and switch.",
                  "Big Ben is actually really small. I think Ben was overcompensating",
                  "The best part of the Sistine Chapel was selfies with Gelato on my face",
                  "The worst thing about being a tourist is having other tourists recognize you as a tourist",
                  "The first condition of understanding a foreign country is to smell it",
                  "Too often travel, instead of broadening the mind, merely lengthens the conversations.",
                  "Our happiest moments as tourists always seem to come when we stumble upon one thing while in pursuit of something else.",
                  "",
                  "",
                  "",
                  "",
                  "",
                  "",
                  "",
                  "",
                  "",
                  "",
                  ""
            ]

      }
}