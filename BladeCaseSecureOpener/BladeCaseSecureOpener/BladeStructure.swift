//
//  BladeStructure.swift
//  BladeCaseSecureOpener
//
//  Created by SunTory on 2025/2/17.
//

import Foundation

class SpinManager {
    static let shared = SpinManager()
    
    private let maxSpins = 10
    private let resetInterval: TimeInterval = 4 * 60 * 60
    
    private let spinsKey = "remainingSpins"
    private let lastResetKey = "lastResetTime"
    
    private init() {
        resetSpinsIfNeeded()
    }
    
    var remainingSpins: Int {
        return UserDefaults.standard.integer(forKey: spinsKey)
    }
    
    private func resetSpinsIfNeeded() {
        let lastReset = UserDefaults.standard.object(forKey: lastResetKey) as? Date ?? Date.distantPast
        if Date().timeIntervalSince(lastReset) >= resetInterval {
            resetSpins()
        }
    }
    
    private func resetSpins() {
        UserDefaults.standard.set(maxSpins, forKey: spinsKey)
        UserDefaults.standard.set(Date(), forKey: lastResetKey)
    }
    
    func attemptSpin() -> Bool {
        resetSpinsIfNeeded()
        
        var spins = remainingSpins
        if spins > 0 {
            spins -= 1
            UserDefaults.standard.set(spins, forKey: spinsKey)
            return true
        }
        return false
    }
    
    // Get time remaining until next reset
    func timeUntilNextReset() -> TimeInterval {
        let lastReset = UserDefaults.standard.object(forKey: lastResetKey) as? Date ?? Date()
        let timeElapsed = Date().timeIntervalSince(lastReset)
        return max(resetInterval - timeElapsed, 0)
    }
}
 
struct Gun: Codable {
    let name: String
    let price: String
    let images: String
    let rarity: String
    let description: String
}

 struct GunCategory {
    let categoryName: String
    let categoryImage: String
    let guns: [Gun]
}

// Sample Data
let gunData: [GunCategory] = [
    GunCategory(
        categoryName: "Sniper",
        categoryImage: "Barrett M82",
        guns: [
            Gun(
                name: "Barrett M82",
                price: "🌹12,000",
                images: "Barrett M82",
                rarity: "Legendary",
                description: "The Barrett M82 is a semi-automatic anti-materiel sniper rifle known for its immense stopping power and long-range accuracy. Capable of penetrating armored targets, it’s widely used by military forces around the world. Its heavy recoil is balanced by unparalleled firepower."
            ),
            Gun(
                name: "CheyTac M200",
                price: "🌹11,700",
                images: "CheyTac M200",
                rarity: "Epic",
                description: "The CheyTac M200 Intervention is a precision sniper rifle designed for extreme long-range shooting. Known for its accuracy beyond 2,000 meters, it’s favored by elite military units. The advanced ballistic system ensures unmatched precision in the field."
            ),
            Gun(
                name: "Dragunov SVD",
                price: "🌹3,500",
                images: "Dragunov SVD",
                rarity: "Rare",
                description: "The Dragunov SVD is a semi-automatic sniper rifle famed for its rugged design and reliability. It has been a staple in military arsenals since the Cold War, offering moderate range and high durability. Perfect for mid-range engagements."
            ),
            Gun(
                name: "L115A3 AWM",
                price: "🌹9,000",
                images: "L115A3 AWM",
                rarity: "Epic",
                description: "The L115A3 AWM is a bolt-action sniper rifle renowned for its exceptional accuracy and range. Used by British special forces, it holds the record for one of the longest confirmed sniper kills. Its precision makes it a top choice in modern warfare."
            ),
            Gun(
                name: "M24 SWS",
                price: "🌹6,000",
                images: "M24 SWS",
                rarity: "Uncommon",
                description: "The M24 Sniper Weapon System is a bolt-action rifle based on the Remington 700. Used extensively by the U.S. military, it offers reliability and consistent accuracy. It’s a versatile rifle suitable for both tactical and long-range shooting."
            ),
            Gun(
                name: "McMillan TAC-50",
                price: "🌹10,000",
                images: "McMillan TAC-50",
                rarity: "Legendary",
                description: "The McMillan TAC-50 is a long-range sniper rifle known for its record-breaking range and accuracy. Used by Canadian special forces, it holds the world record for the longest confirmed sniper kill. Its power and precision make it a formidable weapon."
            ),
            Gun(
                name: "Steyr SSG 69",
                price: "🌹4,000",
                images: "Steyr SSG 69",
                rarity: "Rare",
                description: "The Steyr SSG 69 is an Austrian bolt-action sniper rifle celebrated for its lightweight design and precision. It has been a favorite among military and law enforcement units for decades due to its reliability and consistent performance."
            )
        ]
    ),
    GunCategory(
        categoryName: "Pistols",
        categoryImage: "Beretta 92FS",
        guns: [
            Gun(
                name: "Beretta 92FS",
                price: "🌹650",
                images: "Beretta 92FS",
                rarity: "Uncommon",
                description: "The Beretta 92FS is a semi-automatic pistol known for its accuracy and durability. Widely used by military and law enforcement, it offers a smooth trigger pull and a large magazine capacity. Its sleek design and reliability make it a popular choice globally."
            ),
            Gun(
                name: "Browning Hi-Power",
                price: "🌹700",
                images: "Browning Hi-Power",
                rarity: "Rare",
                description: "The Browning Hi-Power is a classic single-action pistol designed by John Browning. Celebrated for its ergonomic grip and high magazine capacity, it has served in military forces worldwide. Its historical significance and reliability make it a collector’s favorite."
            ),
            Gun(
                name: "Colt M1911",
                price: "🌹850",
                images: "Colt M1911",
                rarity: "Rare",
                description: "The Colt M1911 is an iconic semi-automatic pistol with over a century of military service. Known for its stopping power and robust design, it remains a symbol of American firearm innovation. Its timeless design is beloved by collectors and shooters alike."
            ),
            Gun(
                name: "CZ 75B",
                price: "🌹600",
                images: "CZ 75B",
                rarity: "Uncommon",
                description: "The CZ 75B is a Czech-designed semi-automatic pistol renowned for its accuracy and ergonomic grip. Featuring a double-action trigger and a steel frame, it’s popular among competitive shooters and law enforcement. Its balanced design offers excellent control."
            ),
            Gun(
                name: "FN Herstal FNX-45",
                price: "🌹1,200",
                images: "FN Herstal FNX-45",
                rarity: "Epic",
                description: "The FN Herstal FNX-45 is a tactical pistol designed for superior performance in adverse conditions. Chambered in .45 ACP, it offers high stopping power and modular features like threaded barrels for suppressors. Favored by military and special forces."
            ),
            Gun(
                name: "Glock 19",
                price: "🌹500",
                images: "Glock 19",
                rarity: "Common",
                description: "The Glock 19 is one of the most popular semi-automatic pistols in the world, known for its reliability, simplicity, and compact size. Ideal for concealed carry and law enforcement use, it offers a perfect balance of firepower and portability."
            ),
            Gun(
                name: "Heckler & Koch USP",
                price: "🌹1,000",
                images: "Heckler & Koch USP",
                rarity: "Epic",
                description: "The Heckler & Koch USP is a robust, German-engineered pistol designed for both military and civilian use. Known for its accuracy and modular safety features, it’s a favorite among tactical shooters. Its durable design ensures reliability in all conditions."
            ),
            Gun(
                name: "Sig Sauer P226",
                price: "🌹900",
                images: "Sig Sauer P226",
                rarity: "Rare",
                description: "The Sig Sauer P226 is a full-sized, high-capacity pistol favored by military and law enforcement agencies worldwide. Renowned for its precision and smooth trigger pull, it’s a reliable choice for both combat and competitive shooting."
            ),
            Gun(
                name: "Smith & Wesson M&P9",
                price: "🌹550",
                images: "Smith & Wesson M&P9",
                rarity: "Uncommon",
                description: "The Smith & Wesson M&P9 is a modern polymer-framed, striker-fired pistol designed for law enforcement and civilian use. Known for its ergonomic design and easy customization, it provides excellent performance in both training and real-world scenarios."
            ),
            Gun(
                name: "Walther P99",
                price: "🌹750",
                images: "Walther P99",
                rarity: "Rare",
                description: "The Walther P99 is a German semi-automatic pistol featuring an innovative striker system and ergonomic grip. Known for its accuracy and advanced safety features, it has been popular with law enforcement and appeared in several James Bond films."
            )
        ]
    ),
    GunCategory(
        categoryName: "AR",
        categoryImage: "AK-47",
        guns: [
            Gun(
                name: "AK-47",
                price: "🌹1,200",
                images: "AK-47",
                rarity: "Rare",
                description: "The AK-47 is a powerful, reliable assault rifle known for its durability and simplicity. Widely used by military forces worldwide, it delivers high damage with moderate accuracy. Its recoil is significant, but its stopping power makes it a favorite among marksmen."
            ),
            Gun(
                name: "AR-15",
                price: "🌹1,000",
                images: "AR-15",
                rarity: "Uncommon",
                description: "The AR-15 is a lightweight, versatile rifle favored for its modular design and precision. Its semi-automatic firing mode offers excellent control, making it suitable for both close and long-range engagements. Highly customizable with various attachments."
            ),
            Gun(
                name: "FN SCAR 17S",
                price: "🌹3,500",
                images: "FN SCAR 17S",
                rarity: "Epic",
                description: "The FN SCAR 17S is a battle rifle renowned for its accuracy and adaptability in combat. It features a robust build with a high-caliber punch, ideal for tactical operations. Its advanced ergonomics and superior range set it apart from other rifles."
            ),
            Gun(
                name: "Heckler & Koch G36",
                price: "🌹2,200",
                images: "Heckler & Koch G36",
                rarity: "Epic",
                description: "The Heckler & Koch G36 is a German-engineered rifle known for its precision and lightweight polymer frame. Its integrated optics and reliable performance under harsh conditions make it a preferred choice for special forces. Versatile for different combat scenarios."
            ),
            Gun(
                name: "M1 Garand",
                price: "🌹1,500",
                images: "M1 Garand",
                rarity: "Rare",
                description: "The M1 Garand is a historic semi-automatic rifle celebrated for its role in World War II. Known for its 'ping' sound when the clip ejects, it offers powerful shots with excellent range. A favorite among collectors and history enthusiasts."
            ),
            Gun(
                name: "Mosin-Nagant M91/30",
                price: "🌹800",
                images: "Mosin-Nagant M91:30",
                rarity: "Uncommon",
                description: "The Mosin-Nagant M91/30 is a classic bolt-action rifle recognized for its reliability and historical significance. Used extensively in both World Wars, it boasts long-range accuracy, making it a favored sniper rifle in military history."
            ),
            Gun(
                name: "Remington 700",
                price: "🌹1,400",
                images: "Remington 700",
                rarity: "Rare",
                description: "The Remington 700 is a precision bolt-action rifle widely used by military snipers and hunters alike. Known for its customizable design and unmatched accuracy, it’s a benchmark in the world of long-range shooting. Trusted for its consistent performance."
            ),
            Gun(
                name: "Ruger Mini-14",
                price: "🌹1,000",
                images: "Ruger Mini-14",
                rarity: "Uncommon",
                description: "The Ruger Mini-14 is a semi-automatic rifle known for its versatility and ease of use. Popular among ranchers and law enforcement, it offers reliable performance with low recoil, making it suitable for both novice and experienced shooters."
            ),
            Gun(
                name: "Savage 110",
                price: "🌹900",
                images: "Savage 110",
                rarity: "Uncommon",
                description: "The Savage 110 is a durable, accurate bolt-action rifle designed for hunting and long-range shooting. It features an adjustable trigger and a reputation for out-of-the-box accuracy. A reliable companion for outdoor enthusiasts."
            ),
            Gun(
                name: "Steyr AUG",
                price: "🌹2,500",
                images: "Steyr AUG",
                rarity: "Epic",
                description: "The Steyr AUG is a futuristic bullpup assault rifle known for its compact design and high precision. Its integrated optics and modular construction make it a favorite for special forces. Delivers exceptional performance in close-quarters combat."
            )
        ]
    ),
    GunCategory(
        categoryName: "Shotguns",
        categoryImage: "Benelli M2",
        guns: [
            Gun(
                name: "Benelli M2",
                price: "🌹1,400",
                images: "Benelli M2",
                rarity: "Rare",
                description: "The Benelli M2 is a semi-automatic shotgun renowned for its lightweight design and reliability. Featuring the Inertia-Driven System, it provides fast cycling and minimal recoil. Perfect for tactical, hunting, and competitive shooting due to its versatility and accuracy."
            ),
            Gun(
                name: "Beretta 1301",
                price: "🌹1,300",
                images: "Beretta 1301",
                rarity: "Rare",
                description: "The Beretta 1301 is a high-performance semi-automatic shotgun designed for speed and precision. Its compact build and fast cycling make it ideal for law enforcement and home defense. Known for its smooth operation and robust construction."
            ),
            Gun(
                name: "Saiga-12",
                price: "🌹1,200",
                images: "Saiga-12",
                rarity: "Epic",
                description: "The Saiga-12 is a Russian-made semi-automatic shotgun based on the AK-47 platform. Known for its rugged design and high-capacity magazines, it delivers rapid firepower. Popular in tactical scenarios and competitive shooting due to its versatility and reliability."
            )
        ]
    ),
    GunCategory(
        categoryName: "Knife",
        categoryImage: "Applegate-Fairbairn",
        guns: [
            Gun(
                name: "Applegate-Fairbairn",
                price: "🌹250",
                images: "Applegate-Fairbairn",
                rarity: "Rare",
                description: "The Applegate-Fairbairn knife is a modern combat knife designed for close-quarters battle. Inspired by WWII designs, it features a double-edged blade with excellent balance and durability. Favored by special forces for its tactical efficiency and rugged construction."
            ),
            Gun(
                name: "Benchmade Nimravus",
                price: "🌹200",
                images: "Benchmade Nimravus",
                rarity: "Uncommon",
                description: "The Benchmade Nimravus is a versatile fixed-blade knife known for its lightweight design and strong stainless steel blade. Its ergonomic grip and tactical sheath make it ideal for military, survival, and everyday carry situations."
            ),
            Gun(
                name: "Boker Plus Strike",
                price: "🌹150",
                images: "Boker Plus Strike",
                rarity: "Uncommon",
                description: "The Boker Plus Strike is an automatic knife designed for rapid deployment and reliability. Its durable aluminum handle and sharp drop-point blade make it perfect for tactical use. Popular among first responders for its quick accessibility."
            ),
            Gun(
                name: "Cold Steel SRK",
                price: "🌹120",
                images: "Cold Steel SRK",
                rarity: "Common",
                description: "The Cold Steel SRK (Survival Rescue Knife) is designed for survival and rescue operations. Featuring a durable, corrosion-resistant blade, it's a trusted tool for military personnel and outdoor enthusiasts alike. Known for its toughness in extreme conditions."
            ),
            Gun(
                name: "Eickhorn KM2000",
                price: "🌹300",
                images: "Eickhorn KM2000",
                rarity: "Epic",
                description: "The Eickhorn KM2000 is a German military knife used by the Bundeswehr. Its robust tanto-style blade and ergonomic handle make it suitable for both combat and utility tasks. Renowned for its strength and high-quality craftsmanship."
            ),
            Gun(
                name: "Fairbairn-Sykes",
                price: "🌹275",
                images: "Fairbairn-Sykes",
                rarity: "Rare",
                description: "The Fairbairn-Sykes fighting knife is an iconic WWII-era dagger, renowned for its role in British special forces operations. With its slender double-edged blade, it excels in precision thrusting, making it a symbol of elite military units."
            ),
            Gun(
                name: "Gerber Mark II",
                price: "🌹220",
                images: "Gerber Mark II",
                rarity: "Rare",
                description: "The Gerber Mark II is a legendary combat knife with a rich military history dating back to the Vietnam War. Its double-edged blade and distinctive serrations make it both a collector's item and a reliable tactical tool."
            ),
            Gun(
                name: "Ka-Bar",
                price: "🌹130",
                images: "Ka-Bar",
                rarity: "Uncommon",
                description: "The Ka-Bar is a classic utility and combat knife famously used by the US Marine Corps during WWII. Its durable 7-inch blade and leather-wrapped handle make it a versatile tool for survival, combat, and fieldwork."
            ),
            Gun(
                name: "Ontario M9",
                price: "🌹180",
                images: "Ontario M9",
                rarity: "Uncommon",
                description: "The Ontario M9 is a military-grade bayonet designed for durability and functionality. It features a strong, corrosion-resistant blade and can be mounted on rifles. Widely used by armed forces for its rugged versatility in the field."
            ),
            Gun(
                name: "SOG SEAL Team",
                price: "🌹240",
                images: "SOG SEAL Team",
                rarity: "Rare",
                description: "The SOG SEAL Team knife is engineered for elite military units, offering exceptional strength and corrosion resistance. Its partially serrated blade and ergonomic handle provide superior grip and cutting power, even in the harshest environments."
            )
        ]
    ),
    GunCategory(
        categoryName: "AMG",
        categoryImage: "FN MAG",
        guns: [
            Gun(
                name: "FN MAG",
                price: "🌹6,000",
                images: "FN MAG",
                rarity: "Epic",
                description: "The FN MAG is a Belgian general-purpose machine gun known for its reliability and widespread military use. It offers high rates of fire with exceptional durability in harsh environments. Trusted by NATO forces, it balances accuracy with sustained firepower."
            ),
            Gun(
                name: "M60",
                price: "🌹5,500",
                images: "M60",
                rarity: "Rare",
                description: "The M60 is an American-made, belt-fed machine gun that gained fame during the Vietnam War. Known for its heavy firepower and distinctive design, it remains a symbol of U.S. military might. Its versatility makes it suitable for both ground and vehicle use."
            ),
            Gun(
                name: "M249 SAW",
                price: "🌹4,500",
                images: "M249 SAW",
                rarity: "Rare",
                description: "The M249 Squad Automatic Weapon (SAW) is a light machine gun designed for providing suppressive fire. Lightweight and highly portable, it is standard issue for U.S. infantry squads. Its rapid rate of fire and accuracy make it a battlefield favorite."
            ),
            Gun(
                name: "MG42",
                price: "🌹7,000",
                images: "MG42",
                rarity: "Legendary",
                description: "The MG42 is a German World War II-era machine gun known for its incredible rate of fire, earning the nickname 'Hitler's Buzzsaw.' Its design influenced many modern machine guns, and it remains one of the most iconic weapons in military history."
            ),
            Gun(
                name: "PKM",
                price: "🌹5,000",
                images: "PKM",
                rarity: "Epic",
                description: "The PKM is a Soviet-designed general-purpose machine gun renowned for its simplicity and reliability. Lightweight yet powerful, it has seen widespread use in conflicts worldwide. Its rugged build and ease of maintenance make it a favorite among military forces."
            )        ]
    ),
    GunCategory(
        categoryName: "Bullets",
        categoryImage:"Armor-Piercing",
        guns: [
            Gun(
                name: "Armor-Piercing",
                price: "🌹5",
                images: "Armor-Piercing",
                rarity: "Epic",
                description: "Armor-Piercing rounds are designed to penetrate hard targets such as body armor and vehicles. Made with hardened materials like steel or tungsten, they deliver superior penetration while maintaining high velocity. Commonly used in military and law enforcement applications."
            ),
            Gun(
                name: "Ballistic Tip",
                price: "🌹3",
                images: "Ballistic Tip",
                rarity: "Rare",
                description: "Ballistic Tip ammunition features a polymer tip that enhances aerodynamic performance and ensures controlled expansion upon impact. Popular among hunters, these rounds combine the benefits of hollow points with improved accuracy for long-range shooting."
            ),
            Gun(
                name: "Boat Tail",
                price: "🌹2.5",
                images: "Boat Tail",
                rarity: "Uncommon",
                description: "Boat Tail bullets have a tapered base that reduces air drag, enhancing accuracy and stability over long distances. Commonly used in precision shooting and military sniping, they offer improved ballistic performance compared to flat-base bullets."
            ),
            Gun(
                name: "Frangible",
                price: "🌹4",
                images: "Frangible",
                rarity: "Rare",
                description: "Frangible ammunition is designed to disintegrate upon impact with hard surfaces, minimizing the risk of ricochets. Ideal for training in close-quarters environments, these rounds offer safety without sacrificing performance on soft targets."
            ),
            Gun(
                name: "Full Metal Jacket",
                price: "🌹1",
                images: "Full Metal Jacket",
                rarity: "Common",
                description: "Full Metal Jacket (FMJ) bullets feature a soft core encased in a harder metal shell. Known for their ability to retain shape and penetrate deeply, FMJ rounds are widely used in military training and general-purpose shooting."
            ),
            Gun(
                name: "Hollow Point",
                price: "🌹3.5",
                images: "Hollow Point",
                rarity: "Rare",
                description: "Hollow Point ammunition is designed to expand upon impact, causing greater damage to soft tissue. Favored for self-defense and law enforcement, these rounds maximize stopping power while minimizing the risk of over-penetration."
            ),
            Gun(
                name: "Incendiary",
                price: "🌹6",
                images: "Incendiary",
                rarity: "Legendary",
                description: "Incendiary rounds ignite upon impact, causing fires and intense heat damage to targets. Used in military operations to disable equipment or ignite fuel sources, these rounds are highly destructive and require careful handling."
            ),
            Gun(
                name: "Soft Point",
                price: "🌹2.5",
                images: "Soft Point",
                rarity: "Uncommon",
                description: "Soft Point bullets have an exposed lead tip that allows for controlled expansion upon impact. Combining the penetration of FMJ with the stopping power of hollow points, they are popular among hunters for medium to large game."
            ),
            Gun(
                name: "Tracer",
                price: "🌹4.5",
                images: "Tracer",
                rarity: "Epic",
                description: "Tracer rounds contain a pyrotechnic charge that leaves a visible trail when fired, allowing shooters to track trajectories. Used in military applications for targeting and signaling, tracers are both functional and visually striking in low-light conditions."
            ),
            Gun(
                name: "Wadcutter",
                price: "🌹2",
                images: "Wadcutter",
                rarity: "Common",
                description: "Wadcutter bullets are designed with a flat front to create clean, round holes in paper targets. Ideal for precision shooting and competitions, they offer minimal recoil and are favored in target practice for their accuracy and clean cuts."
            )
        ]
    )
]

