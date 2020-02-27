//
//  main.swift
//  5
//
//  Created by Admin on 25.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import Swift


class GenericRobot {
    var name: String
    var catchPhrase: String
    var charge: Int
    var selfDestruct: selfDestruct

    enum KillerMode {
        case active, inactive
    }

    enum Magazine {
        case full, empty
    }

    enum selfDestruct {
        case on, off
    }

    enum getReady {
        case ready
        case steady
        case go
    }
    
    func print_properties(mirror: GenericRobot) {
   
        let mirrored_robot = Mirror(reflecting: mirror)
        
        for (index, attr) in mirrored_robot.children.enumerated(){
            if let propertyName = attr.label as String? {
                print("Attr \(index): \(propertyName) = \(attr.value)")
        }
        }
    }
    
    
    func executeMainDirective(){
    }
    
    init(name: String, catchPhrase: String, charge: Int, selfDestruct: selfDestruct) {
        self.name = name
        self.charge = charge
        self.catchPhrase = catchPhrase
        self.selfDestruct = selfDestruct
    }
    
}
    
class KillerRobot: GenericRobot {
    var killCount: Int
    var gunClip: Magazine
    var readyForAction: KillerMode
    
    func reload() {
        if self.gunClip == .empty {
            print("*Reloads*")
            self.gunClip = .full
        } else if self.gunClip == .full {
            print("I'am already full")
        }
    }
    
    func startSelfDestruct(){
        self.selfDestruct = .on
        print("I’ll Be Back.")
        print("💥Boom!💥")
    }
    
    func killSomePunyHumans(){
        if charge > 0 {
        if self.gunClip != .empty {
        print("Bam!💥 Bang!💥")
        self.killCount += 1
            self.charge -= 10
        self.gunClip = .empty
        } else {
            print("I'm out of bullets")
        }
        } else {
        print("Out of juice")
            startSelfDestruct()
        }
    }
    
    func mode(mode: getReady){
        switch mode {
        case .ready:
            print(catchPhrase)
        case .steady:
            print(catchPhrase)
            reload()
        case .go:
            print(catchPhrase)
            reload()
            readyForAction.self = .active
            killSomePunyHumans()
            }
        }
    
    override func executeMainDirective(){
        let peopleAround = Int.random(in: 0...10)
        var peopleAlive = peopleAround
        for _ in 0...peopleAround {
            if peopleAlive != 0 {
                killSomePunyHumans()
                peopleAlive -= 1
                reload()
            }
        }
    }
    
    init(name: String, catchPhrase: String, charge: Int, killCount: Int, gunClip: Magazine, readyForAction: KillerMode, selfDestruct: selfDestruct){
        self.killCount = killCount
        self.gunClip = gunClip
        self.readyForAction = readyForAction
        super.init(name: name, catchPhrase: catchPhrase, charge: charge, selfDestruct: selfDestruct)
    }

    
}

class GoofyRobot: GenericRobot {
    var beerCount: Int
    var isDrunk: Bool
    var readyForAction: KillerMode
 
     func haveSomeBeer() {
        self.beerCount += 1
        print("*Burps*")
    }
        
        func startSelfDestruct(){
            self.selfDestruct = .on
            print("Oops, I think I've had too much")
            print("💥Boom!💥")
        }
        
        func mode(mode: getReady){
            switch mode {
            case .ready:
                print(catchPhrase)
            case .steady:
                print(catchPhrase)
                haveSomeBeer()
            case .go:
                print(catchPhrase)
                haveSomeBeer()
                readyForAction.self = .active
                }
            }
    
    override func executeMainDirective() {
        let holdYourLiqourStat = Int.random(in: 0...10)
        let upperThresholdOfBeerCapacity = Int.random(in: 5...15)
        
        for _ in 0...holdYourLiqourStat {
            if holdYourLiqourStat <= upperThresholdOfBeerCapacity {
                if holdYourLiqourStat != beerCount {
                    haveSomeBeer()
                }
            } else if holdYourLiqourStat > upperThresholdOfBeerCapacity {
                startSelfDestruct()
                break
            }
        }
    }
    
    
    init(name: String, beerCount: Int, catchPhrase: String, isDrunk: Bool, charge: Int, readyForAction: KillerMode, selfDestruct: selfDestruct) {
        self.beerCount = beerCount
        self.isDrunk = isDrunk
        self.readyForAction = readyForAction
        super.init(name: name, catchPhrase: catchPhrase, charge: charge, selfDestruct: selfDestruct)
        }

}


var Terminator = KillerRobot(name: "T-800", catchPhrase: "Hasta la vista, Baby", charge: 100, killCount: 0, gunClip: .full, readyForAction: .active, selfDestruct: .off)

Terminator.executeMainDirective()
Terminator.mode(mode: .steady)
print(Terminator.killCount)


var Bender = GoofyRobot(name: "Bender", beerCount: 0, catchPhrase: "Bite my shiny metal ass", isDrunk: false, charge: 50, readyForAction: .inactive, selfDestruct: .off)

Bender.executeMainDirective()
Bender.mode(mode: .go)

Terminator.print_properties(mirror: Terminator)
Terminator.print_properties(mirror:Bender)
