import UIKit

//creating a PirateShip by adhering to SOLID principles.

protocol Cannonable {
    var cannonsCount: Int? { get }
    func fireCannons(count: Int)
}

class PirateShip: Cannonable {
    let name: String
    var cannonsCount: Int?
    private let cargoManager: CargoManaging
    private let crewManager: CrewManaging
    
    init(name: String, cargoManager: CargoManaging, crewManager: CrewManaging) {
        self.name = name
        self.cargoManager = cargoManager
        self.crewManager = crewManager
    }
    
    func addCargo() {
        cargoManager.addCargo()
    }
    
    func removeCargo() {
        cargoManager.removeCargo()
    }
    
    func addCrew(name: String) {
        crewManager.addCrew(name: name)
    }
    
    func removeCrew() {
        crewManager.removeCrew()
    }
    
    func fireCannons(count: Int) {
        if let availableCannons = cannonsCount, availableCannons >= count {
            print("Fired \(count) cannons!")
            cannonsCount = availableCannons - count
        } else {
            print("Not enough cannons!")
        }
    }
}

//You may find subclasses of Pirateship in the following code:

class Frigate: PirateShip {
    var speed: Double
    
    init(name: String, speed: Double, cargoManager: CargoManaging, crewManager: CrewManaging) {
        self.speed = speed
        super.init(name: name, cargoManager: cargoManager, crewManager: crewManager)
    }
}

class Galleon: PirateShip {
    var maneuverability: Double
    var cargoCapacity: Double
    private var cannonsCountStored: Int?
    
    init(name: String, maneuverability: Double, cargoCapacity: Double, cannonsCountStored: Int? = nil, cargoManager: CargoManaging, crewManager: CrewManaging) {
        self.maneuverability = maneuverability
        self.cargoCapacity = cargoCapacity
        self.cannonsCountStored = cannonsCountStored
        super.init(name: name, cargoManager: cargoManager, crewManager: crewManager)
    }
}

protocol CrewManaging {
    func addCrew(name: String)
    func removeCrew()
    func checkCrewMember(name: String) -> Bool
}

protocol CargoManaging {
    func addCargo()
    func removeCargo()
}

//CargoManager and crewManager classes that adhere to their respective protocols:

class CargoManager: CargoManaging {
    var cargo: [String] = []
    
    func addCargo() {
        cargo.append("Generic Cargo Item")
        print("Cargo added!")
    }
    
    func removeCargo() {
        if cargo.isEmpty == false {
            cargo.removeLast()
            print("Cargo removed!")
        } else {
            print("No cargo to remove!")
        }
    }
}

class CrewManager: CrewManaging {
    var crew: [String] = []
    
    func addCrew(name: String) {
        crew.append(name)
        print("\(name) has been added to the crew!")
    }
    
    func removeCrew() {
        if let removedMember = crew.popLast() {
            print("\(removedMember) has been removed from the crew!")
        } else {
            print("No crew members to remove!")
        }
    }
}

//adding some extensions:

extension CrewManager {
    func checkCrewMember(name: String) -> Bool {
        return crew.contains(name)
    }
}

extension PirateShip {
    func checkCrewMember(name: String) -> Bool {
        return crewManager.checkCrewMember(name: name)
    }
}

//creating two instances:

let baratieCargoManager = CargoManager()
let baratieCrewManager = CrewManager()

//creating class Treasuremap which contains a hint to the adventure. According to our coordinates, the hint gives us a clue where to go. It then calculates the distance and allows us to find the treasure:

class TreasureMap {
    let treasureX: Int
    let treasureY: Int
    
    init(treasureX: Int, treasureY: Int) {
        self.treasureX = treasureX
        self.treasureY = treasureY
    }
    
    func hintToAdventure(checking firstCoordinate: Int, and secondCoordinate: Int) -> String {
        if firstCoordinate == treasureX && secondCoordinate == treasureY {
            return "Congratulations! You have found the treasure!"
        }
        
        let differenceX = treasureX - firstCoordinate
        let differenceY = treasureY - secondCoordinate
        
        if differenceX > 0 && differenceY > 0 {
            return "Head Northeast by \(differenceX) steps horizontally and \(differenceY) steps vertically."
        } else if differenceX < 0 && differenceY > 0 {
            return "Head Northwest by \(-differenceX) steps horizontally and \(differenceY) steps vertically."
        } else if differenceX > 0 && differenceY < 0 {
            return "Head Southeast by \(differenceX) steps horizontally and \(-differenceY) steps vertically."
        } else if differenceX < 0 && differenceY < 0 {
            return "Head Southwest by \(-differenceX) steps horizontally and \(-differenceY) steps vertically."
        } else if differenceX == 0 && differenceY > 0 {
            return "Head North by \(differenceY) steps."
        } else if differenceX == 0 && differenceY < 0 {
            return "Head South by \(-differenceY) steps."
        } else if differenceX > 0 && differenceY == 0 {
            return "Head East by \(differenceX) steps."
        } else if differenceX < 0 && differenceY == 0 {
            return "Head West by \(-differenceX) steps."
        } else {
            return "You are on the right spot, but no treasure here."
        }
    }
}
    
//checking the treasureMap hint with our original coordinates:

let tornOutTreasureMap = TreasureMap(treasureX: 4, treasureY: 4)
var originalX = 0
var originalY = 0
print(tornOutTreasureMap.hintToAdventure(checking: originalX, and: originalY))

//using the hint to find the treasure:

originalX += 4
originalY += 4
print(tornOutTreasureMap.hintToAdventure(checking: originalX, and: originalY))

//Creating a class SeaAdventure with a method for encountering an adventure of a specific type.
        
class SeaAdventure {
    var adventureType: String
    init(adventureType: String) {
        self.adventureType = adventureType
    }
    
    func encounter(){
        print("The ship has just encountered a \(adventureType) adventure")
    }
}

//creating a class PirateCode, which gives us a way to discuss how to handle an adventure:

class PirateCode {
    private func discussTerms(term: String) {
        print("Maximus is on the crew, he will decide: \(term)")
    }
    
    func parley() {
        discussTerms(term: "We would like to negotiate!")
        print("Negotiations are currently in progress")
    }
    
    func mutiny() {
        discussTerms(term: "We will fight!")
        print("The crew has mutinied!")
    }
}

// Creating an instance for a PirateCode and an instance for PirateShip:

let baratiePirateCode = PirateCode()

let baratie = PirateShip(name: "Baratie", cargoManager: baratieCargoManager, crewManager: baratieCrewManager)

// Adding some crew members and some cargo:

for _ in 1...5 {
    baratie.addCargo()
}

baratie.addCrew(name: "John")
baratie.addCrew(name: "Mia")
baratie.addCrew(name: "Maximus Decimus Meridius, commander of the Armies of the North, General of the Felix Legions, loyal servant to the true emperor, Marcus Aurelius, father to a murdered son, husband to a murdered wife and he will have his vengeance in this life or the next")
baratie.addCrew(name: "Lasha")

print("Let's sail off!")
            

//We have encountered a Sea Advevnture!

var flyingDutchMan = SeaAdventure(adventureType: "Fight")
flyingDutchMan.encounter()

//As long as Maximus is on the crew, we decide to fight!

if baratie.checkCrewMember(name:"Maximus Decimus Meridius, commander of the Armies of the North, General of the Felix Legions, loyal servant to the true emperor, Marcus Aurelius, father to a murdered son, husband to a murdered wife and he will have his vengeance in this life or the next") {
    baratiePirateCode.mutiny()
} else {
    baratiePirateCode.parley()
}
