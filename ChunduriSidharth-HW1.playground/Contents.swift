// Project: ChunduriSidharth-HW1
// EID: sc69966
// Course: CS329E

struct GameData {
    //mapping between weapons and their damages
    static let weaponMap : [String: Int] = [
        "dagger" : 4,
        "axe" : 6,
        "staff" : 6,
        "sword" : 10,
        "none" : 1
    ]
    //mapping between armors and their AC values
    static let armorMap : [String: Int] = [
        "plate" : 2,
        "chain" : 5,
        "leather" : 8,
        "none" : 10
    ]
    //mapping between spells and their cost and effect as a tuple
    static let spellMap : [String: (cost: Int, effect: Int)] = [
        "Fireball" : (3, 5),
        "Lightning Bolt" : (10, 10),
        "Heal" : (6, -6)
    ]
        
}

//weapon class
class Weapon {
    var weaponType: String = ""
    var damage: Int = 0
    
    init(weaponType: String) {
        self.weaponType = weaponType
        self.damage = GameData.weaponMap[self.weaponType] ?? 0
    }
}

//armor class
class Armor {
    var armorType: String = ""
    var protection: Int = 0
    
    init(armorType: String) {
        self.armorType = armorType
        self.protection = GameData.armorMap[self.armorType] ?? 0
    }
}

//spell class
class Spell {
    var spellName: String = ""
    var cost : Int = 0
    var effect : Int = 0
    
    init(spellName: String) {
        self.spellName = spellName
        self.cost = GameData.spellMap[self.spellName]!.cost
        self.effect = GameData.spellMap[self.spellName]!.effect
    }
}

//takes RPGCharacter as a parameter and determines if it has been defeated based on health attribute
func checkForDefeat(character: RPGCharacter) {
    if character.health <= 0 {
        print("\(character.name) has been defeated!")
    }
}

//RPG Character class
class RPGCharacter {
    //limit variable defenitions
    var maxHealth : Int = 0
    var maxSpell : Int = 0
    var allowedWeapons : [String] = []
    var allowedArmors: [String] = []
    
    //state variable defenitions
    var name : String = ""
    var health : Int = 0
    var spell : Int = 0
    var weapon : Weapon
    var armor : Armor
    
    //Inititalizes
    init(name: String) {
        self.name = name
        self.health = maxHealth
        self.spell = maxSpell
        self.weapon = Weapon(weaponType: "none")
        self.armor = Armor(armorType: "none")
    }
    
    //wield method takes weapon object as parameter and assigns it as weapon attribute of self(if its allowed for the class)
    func wield(weaponObject: Weapon) {
        if self.allowedWeapons.contains(weaponObject.weaponType) {
            self.weapon = weaponObject
            print("\(self.name) is now wielding a(n) \(self.weapon.weaponType)")
        }
        else {
            print("Weapon not allowed for this character class.")
        }
    }
    
    //method sets weapon parameter of self to none
    func unwield() {
        self.weapon = Weapon(weaponType: "none")
        print("\(self.name) is no longer wielding anything.")
    }
    
    //method takes armor object as parameter and sets armor attribute of self to that object(if its allowed for the class)
    func putOnArmor(armorObject: Armor) {
        if self.allowedArmors.contains(armorObject.armorType) {
            self.armor = armorObject
            print("\(self.name) is now wearing \(self.armor.armorType)")
        }
        else {
            print("Armor not allowed for this character class.")
        }
    }
    
    //method sets armor to none
    func takeOffArmor() {
        self.armor = Armor(armorType: "none")
        print("\(self.name) is no longer wearing any armor.")
    }
    
    //takes opponent RPGCharacter object as parameter. Deducts health based on weapon attribute and checks for defeat
    func fight(opponent: RPGCharacter) {
        print("\(self.name) attacks \(opponent.name) with a(n) \(self.weapon.weaponType)")
        opponent.health -= self.weapon.damage
        print("\(self.name) does \(self.weapon.damage) damage to \(opponent.name).")
        print("\(opponent.name) is now down to \(opponent.health) health.")
        checkForDefeat(character: opponent)
    }
    
    //displays useful stats about self
    func show() {
        print("\(self.name)")
        print("Current Health: \(self.health)")
        print("Current Spell Points: \(self.spell)")
        print("Wielding: \(self.weapon.weaponType)")
        print("Wearing: \(self.armor.armorType)")
        print("Armor class: \(self.armor.protection)")
    }
    
}

//Fighter inherits RPG Character
class Fighter : RPGCharacter {
    override init(name: String) {
        //inherit RPG Character init
        super.init(name: name)
        //initialize class attributes
        self.maxHealth = 40
        self.maxSpell = 0
        self.allowedWeapons = ["dagger", "axe", "staff", "sword", "none"]
        self.allowedArmors = ["plate", "chain", "leather", "none"]
        //initialize health and spell
        self.health = self.maxHealth
        self.spell = self.maxSpell
    }
}

class Wizard : RPGCharacter {
    override init(name: String) {
        //inherit RPG Character init
        super.init(name: name)
        //initialize class attributes
        self.maxHealth = 16
        self.maxSpell = 20
        self.allowedWeapons = ["dagger", "staff", "none"]
        self.allowedArmors = ["none"]
        //initialize health and spell
        self.health = self.maxHealth
        self.spell = self.maxSpell
    }
    
    //Takes spell name and RPG character object. Deducts health from opponent and deducts spell from self according to attributes of spell object
    func castSpell(spellName: String, target: RPGCharacter) {
        if GameData.spellMap.contains(where: { $0.key == spellName }) {
            //initialized spell object based on name
            let spell = Spell(spellName: spellName)
            print("\(self.name) casts \(spellName) at \(target.name)")
            
            if (self.spell < spell.cost) {
                print("Insufficient spell points")
                return
            }
            //deduct health from target
            target.health -= spell.effect
            if target.health > target.maxHealth {
                target.health = target.maxHealth
            }
            self.spell -= spell.cost
            //determines whether to heal or do damage
            if spell.spellName == "Heal" {
                print("\(self.name) heals \(target.name) for \(spell.effect * -1) health points")
                print("\(target.name) is now at \(target.health) health.")
            }
            //checks for defeat if it was an attack
            else {
                print("\(self.name) does \(spell.effect) damage to \(target.name)")
                print("\(target.name) is now down to \(target.health) health")
                checkForDefeat(character: target)
            }
            
        }
        else{
            print("Unknown spell name. Spell failed.")
            return
        }
    }
}

// top level code
let plateMail = Armor(armorType: "plate")
let chainMail = Armor(armorType: "chain")
let sword = Weapon(weaponType: "sword")
let staff = Weapon(weaponType: "staff")
let axe = Weapon(weaponType: "axe")
let gandalf = Wizard(name: "Gandalf the Grey")
gandalf.wield(weaponObject: staff)
let aragorn = Fighter(name: "Aragorn")
aragorn.putOnArmor(armorObject: plateMail)
aragorn.wield(weaponObject: axe)
gandalf.show()
aragorn.show()
gandalf.castSpell(spellName: "Fireball", target: aragorn)
aragorn.fight(opponent: gandalf)
gandalf.show()
aragorn.show()
gandalf.castSpell(spellName: "Lightning Bolt", target: aragorn)
aragorn.wield(weaponObject: sword)
gandalf.show()
aragorn.show()
gandalf.castSpell(spellName: "Heal", target: gandalf)
aragorn.fight(opponent: gandalf)
gandalf.fight(opponent: aragorn)
aragorn.fight(opponent: gandalf)
gandalf.show()
aragorn.show()
