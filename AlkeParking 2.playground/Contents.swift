import UIKit

protocol Parkable {
    var plate: String { get }
    
    //func checkOutVehicle (plate: String, onSuccess: (Int) -> Void , onError: () -> Void)
}

struct Parking {
    var vehicles: Set<Vehicle> = []
    let maxVehicles: Int = 20
    
    mutating func checkInVehicle(_ vehicle: Vehicle, onFinish: (Bool) -> Void) { // Excercise 5
        guard maxVehicles > vehicles.count else {
            return onFinish(false)
        }
        
        guard vehicles.insert(vehicle).inserted else {
            return onFinish(false)
        }
        
        onFinish(true)
        
    }
    
    func checkOutVehicle(plate: String, onSuccess: (Int) -> Void, onError: () -> Void) {
        let plateSearch = vehicles.filter {$0.plate == plate}
        guard plateSearch.first != nil else {
            onError()
            return
        }
        if plateSearch.count == 1 {
            let fit: Int = 5
            onSuccess(fit)
        } else {
            onError()
        }
    }
}

struct Vehicle: Parkable, Hashable {
    let plate: String
    let type: VehicleType
    let checkInTime: Date
    var discountCard: String?
    var parkedTime: Int { Calendar.current.dateComponents([.minute], from: checkInTime, to: Date()).minute ?? 0}
    
    func hash(into hasher: inout Hasher) { //validate that each car is unique
        hasher.combine(plate)
    }
    
    static func ==(lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.plate == rhs.plate
    }

    
}




//Excercise 1
//vehicles are defined as a set and not as an array because the set does not allow duplicate elements

//Excercise 2
//1. & 2. & 3.
enum VehicleType {
    case car
    case moto
    case miniBus
    case bus
    
    var rate: Int {
        switch self {
            case .car:
                return 20
            case .moto:
                return 15
            case .miniBus:
                return 25
            case .bus:
                return 30
        }
    }
}

//Yes, it could change because different types of vehicles could be included as well as changing the rates

//3.


// Excercise 5 clousere

//CLOUSURES

var onError = {() -> Void in print("Sorry, the check-in failed")}

var onSuccess = {(fit: Int) -> Void in print("Your fee is \(fit)Welcome to AlkeParking")}

var onFinish = {(containedVehicle: Bool) -> Void in
    
    (containedVehicle) ? print("Welcome to AlkeParking") : print("Sorry, the check-in failed")
}


//Excercise 4 validate every kind of vehicle

var alkeParking = Parking()

let car = Vehicle(plate: "AA111AA", type: VehicleType.car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")
let moto = Vehicle(plate: "B222BBB", type: VehicleType.moto, checkInTime: Date(), discountCard: nil)
let miniBus = Vehicle(plate: "CC333CC", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)
let bus = Vehicle(plate: "DD444DD", type: VehicleType.bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")

alkeParking.vehicles.insert(car)
alkeParking.vehicles.insert(moto)
alkeParking.vehicles.insert(miniBus)
alkeParking.vehicles.insert(bus)


//validation that each car is unique
let car2 = Vehicle(plate: "AA111AA", type: VehicleType.car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_003")
print(alkeParking.vehicles.insert(car2).inserted) // false


// Excercise 5 validate that park is full or not

let vehicle1 = Vehicle(plate: "AA111AA", type: VehicleType.car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")
let vehicle2 = Vehicle(plate: "B222BBB", type: VehicleType.moto, checkInTime: Date(), discountCard: nil)
let vehicle3 = Vehicle(plate: "CC333CC", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)
let vehicle4 = Vehicle(plate: "DD444DD", type: VehicleType.bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")
let vehicle5 = Vehicle(plate: "AA111BB", type: VehicleType.car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_003")
let vehicle6 = Vehicle(plate: "B222CCC", type: VehicleType.moto, checkInTime: Date(), discountCard: "DISCOUNT_CARD_004")
let vehicle7 = Vehicle(plate: "CC333DD", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)
let vehicle8 = Vehicle(plate: "DD444EE", type: VehicleType.bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_005")
let vehicle9 = Vehicle(plate: "AA111CC", type: VehicleType.car, checkInTime: Date(), discountCard: nil)
let vehicle10 = Vehicle(plate: "B222DDD", type: VehicleType.moto, checkInTime: Date(), discountCard: nil)
let vehicle11 = Vehicle(plate: "CC333EE", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)
let vehicle12 = Vehicle(plate: "DD444GG", type: VehicleType.bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_006")
let vehicle13 = Vehicle(plate: "AA111DD", type: VehicleType.car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_007")
let vehicle14 = Vehicle(plate: "B222EEE", type: VehicleType.moto, checkInTime: Date(), discountCard: nil)
let vehicle15 = Vehicle(plate: "CC333FF", type: VehicleType.car, checkInTime: Date(), discountCard: nil)
let vehicle16 = Vehicle(plate: "C3333FF", type: VehicleType.miniBus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_008")
let vehicle17 = Vehicle(plate: "CC33FFF", type: VehicleType.bus, checkInTime: Date(), discountCard: "DISCOUNT_CARD_009")
let vehicle18 = Vehicle(plate: "CC22FFF", type: VehicleType.moto, checkInTime: Date(), discountCard: "DISCOUNT_CARD_010")
let vehicle19 = Vehicle(plate: "CC333FA", type: VehicleType.miniBus, checkInTime: Date(), discountCard: nil)
let vehicle20 = Vehicle(plate: "CC333AF", type: VehicleType.car, checkInTime: Date(), discountCard: nil)
//let vehicle21 = Vehicle(plate: "AC333AF", type: VehicleType.car, checkInTime: Date(), discountCard: nil)

/*
let vehicle22 = Vehicle(plate: "CC333AF2", type: VehicleType.car, checkInTime: Date(), discountCard: nil)
let vehicle23 = Vehicle(plate: "CC333AF3", type: VehicleType.car, checkInTime: Date(), discountCard: nil)
let vehicle24 = Vehicle(plate: "CC333AF4", type: VehicleType.car, checkInTime: Date(), discountCard: nil)
let vehicle25 = Vehicle(plate: "CC333AF5", type: VehicleType.car, checkInTime: Date(), discountCard: nil)
let vehicle26 = Vehicle(plate: "CC333AF6", type: VehicleType.car, checkInTime: Date(), discountCard: nil)
*/

//Excercise 6
/*
alkeParking.checkInVehicle(vehicle1, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle2, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle3, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle4, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle5, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle6, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle7, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle8, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle9, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle10, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle11, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle12, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle13, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle14, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle15, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle16, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle17, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle18, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle19, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle20, onFinish: onFinish)
*/

/*
alkeParking.checkInVehicle(vehicle22, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle23, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle24, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle25, onFinish: onFinish)
alkeParking.checkInVehicle(vehicle26, onFinish: onFinish)
*/

//alkeParking.checkInVehicle(vehicle21, onFinish: onFinish)


var vehiclesAux: Set<Vehicle> = []
vehiclesAux.insert(vehicle1)
vehiclesAux.insert(vehicle2)
vehiclesAux.insert(vehicle3)
vehiclesAux.insert(vehicle4)
vehiclesAux.insert(vehicle5)
vehiclesAux.insert(vehicle6)
vehiclesAux.insert(vehicle7)
vehiclesAux.insert(vehicle8)
vehiclesAux.insert(vehicle9)
vehiclesAux.insert(vehicle10)
vehiclesAux.insert(vehicle11)
vehiclesAux.insert(vehicle12)
vehiclesAux.insert(vehicle13)
vehiclesAux.insert(vehicle14)
vehiclesAux.insert(vehicle15)
vehiclesAux.insert(vehicle16)
vehiclesAux.insert(vehicle17)
vehiclesAux.insert(vehicle18)
vehiclesAux.insert(vehicle19)
vehiclesAux.insert(vehicle20)

for vehicle in vehiclesAux {
    alkeParking.checkInVehicle(vehicle, onFinish: onFinish)
}


//remove vehicle
//alkeParking.vehicles.remove(moto)



