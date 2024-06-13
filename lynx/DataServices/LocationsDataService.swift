//
//  LocationsDataService.swift
//  lynx
//
//  Created by Andrew Tran on 8/8/22.
//

import Foundation
import MapKit

class LocationsDataService {
    
    static let locations: [Location] = [
        // MARK: NEW DORMS
        Location(
            name: "Cauthen House",
            address: "450 Tree House Dr.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03347283730541, longitude: -78.51625620285897),
            imageName: "cauthen"),
        Location(
            name: "Balz Dobie House",
            address: "571 McCormick Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.034199839271174, longitude: -78.51735358936516),
            imageName: "balz"),
        Location(
            name: "Watson Webb House",
            address: "561 McCormick Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03491463684645, longitude: -78.51666313169436),
            imageName: "watson-webb"),
        Location(
            name: "Lile Maupin House",
            address: "421 McCormick Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03473138675729, longitude: -78.5159729182006),
            imageName: "lile"),
        Location(
            name: "Tuttle-Dunnington House",
            address: "New Dorms",
            coordinates: CLLocationCoordinate2D(latitude: 38.034123087880424, longitude: -78.51595840285896),
            imageName: "tuttle"),
        Location(
            name: "Shannon House",
            address: "New Dorms",
            coordinates: CLLocationCoordinate2D(latitude: 38.0337811918753, longitude: -78.51511066052977),
            imageName: "shannon"),
        Location(
            name: "Gibbons House",
            address: "425 Tree House Dr.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03326498700324, longitude: -78.51462535868197),
            imageName: "gibbons"),
        Location(
            name: "Kellogg House",
            address: "579 McCormick Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03356719477916, longitude: -78.51761540285901),
            imageName: "kellogg"),
        Location(
            name: "Woody House",
            address: "435 Tree House Dr.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03331640814795, longitude: -78.51564169121298),
            imageName: "woody"),
        
        // MARK: OLD DORMS
        Location(
            name: "Hancock House",
            address: "Old Dorms",
            coordinates: CLLocationCoordinate2D(latitude: 38.03622898679401, longitude: -78.51154441635266),
            imageName: "hancock"),
        Location(
            name: "Bonnycastle House",
            address: "Old Dorms",
            coordinates: CLLocationCoordinate2D(latitude: 38.035915735509455, longitude: -78.51089083354213),
            imageName: "bonnycastle"),
        Location(
            name: "Metcalf House",
            address: "Old Dorms",
            coordinates: CLLocationCoordinate2D(latitude: 38.03585190497585, longitude: -78.51181631349378),
            imageName: "metcalf"),
        Location(
            name: "Lefevre House",
            address: "Old Dorms",
            coordinates: CLLocationCoordinate2D(latitude: 38.03558768447988, longitude: -78.51241246422536),
            imageName: "lefevere"),
        Location(
            name: "Dabney House",
            address: "Old Dorms",
            coordinates: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922),
            imageName: "dabney"),
        Location(
            name: "Kent House",
            address: "2 Bonnycastle Dr.",
            coordinates: CLLocationCoordinate2D(latitude: 38.035087584479506, longitude: -78.51080660040463),
            imageName: "kent"),
        Location(
            name: "Humphreys House",
            address: "Old Dorms",
            coordinates: CLLocationCoordinate2D(latitude: 38.03489809869007, longitude: 78.51203119907815),
            imageName: "humphreys"),
        Location(
            name: "Echols House",
            address: "Old Dorms",
            coordinates: CLLocationCoordinate2D(latitude: 38.03450297526917, longitude: 78.51244723636265),
            imageName: "echols"),
        Location(
            name: "Emmet House",
            address: "Old Dorms",
            coordinates: CLLocationCoordinate2D(latitude: 38.0348126355921, longitude: -78.5114840088998),
            imageName: "emmet"),
        Location(
            name: "Page House",
            address: "Old Dorms",
            coordinates: CLLocationCoordinate2D(latitude: 38.03443544279708, longitude: -78.51137457954566),
            imageName: "page"),
        
        // MARK: APARTMENTS
        Location(
            name: "Grandmarc",
            address: "301 15th St. NW",
            coordinates: CLLocationCoordinate2D(latitude: 38.03753553418177, longitude: -78.49894355040722),
            imageName: "grandmarc"),
        Location(
            name: "The Standard",
            address: "853 W Main St.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03246399378092, longitude: -78.49323682385034),
            imageName: "standard"),
        Location(
            name: "The Flats",
            address: "852 W Main St.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03223418894139, longitude: -78.49371823569518),
            imageName: "flats"),
        Location(
            name: "Lark On Main",
            address: "1000 W Main St.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03240685366085, longitude: -78.49518471360419),
            imageName: "lark"),
        Location(
            name: "Wertland Square",
            address: "216 14th St NW,",
            coordinates: CLLocationCoordinate2D(latitude: 38.035343261919834, longitude: -78.49854353734104),
            imageName: "wsquare"),
        Location(
            name: "The Fred",
            address: "Wertland St.",
            coordinates: CLLocationCoordinate2D(latitude: 38.035163956835156, longitude: -78.49707859071381),
            imageName: "thefred"),
        Location(
            name: "The V",
            address: "201 15th St NW",
            coordinates: CLLocationCoordinate2D(latitude: 38.03610649421932, longitude: -78.49961567027243),
            imageName: "thev"),
        Location(
            name: "The Pointe",
            address: "780 Madison Ave",
            coordinates: CLLocationCoordinate2D(latitude: 38.04159252465451, longitude: -78.4942536582542),
            imageName: "thepointe"),
        Location(
            name: "1029 Wertland",
            address: "1029 Wertland St.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03531171483838, longitude: -78.49548331474975),
            imageName: "1029"),
        Location(
            name: "Dovecote",
            address: "1204 Wertland St.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03428043, longitude: -78.49657448820774),
            imageName: "dovecote"),
        Location(
            name: "Grad Court",
            address: "301 14th St NW",
            coordinates: CLLocationCoordinate2D(latitude: 38.03621088327754, longitude: -78.4986119275195),
            imageName: "gradcourt"),
        Location(
            name: "The Corner Village",
            address: "1215 Wertland St",
            coordinates: CLLocationCoordinate2D(latitude: 38.03453188271576, longitude: -78.49743650175934),
            imageName: "cornervillage"),
        Location(
            name: "Camden Plaza",
            address: "224 14th St NW.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03574786425877, longitude: -78.49844427795978),
            imageName: "camden"),
        Location(
            name: "John Street Place",
            address: "1308 John St.",
            coordinates: CLLocationCoordinate2D(latitude: 38.036895835988915, longitude: -78.49716027659672),
            imageName: "johnstreet"),
        Location(
            name: "1021 Wertland",
            address: "1021 Wertland St.",
            coordinates: CLLocationCoordinate2D(latitude: 38.034605492328254, longitude: -78.49500667231155),
            imageName: "1021"),
        Location(
            name: "The Warehouse",
            address: "1308 Wertland St",
            coordinates: CLLocationCoordinate2D(latitude: 38.034207367686264, longitude: -78.4985251933453),
            imageName: "warehouse"),
        Location(
            name: "College Court",
            address: "312 13th St. NW",
            coordinates: CLLocationCoordinate2D(latitude: 38.03608451824911, longitude: -78.49677724162036),
            imageName: "collegecourt"),
        Location(
            name: "The Grove",
            address: "126 13th St NW",
            coordinates: CLLocationCoordinate2D(latitude: 38.034000401828344, longitude: -78.49766066617747),
            imageName: "thegrove"),
        Location(
            name: "Jefferson Commons",
            address: "1620 Jefferson Park Ave.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03083102343987, longitude: -78.50791666086106),
            imageName: "jeffersoncommons"),
        Location(
            name: "Montebello Circle",
            address: "Montebello Circle",
            coordinates: CLLocationCoordinate2D(latitude: 38.02945723681587, longitude: -78.51048763813938),
            imageName: "montebellocircle"),
        Location(
            name: "The Wedge at South Lawn",
            address: "416 Monroe Lane",
            coordinates: CLLocationCoordinate2D(latitude: 38.03137937971699, longitude: -78.50253198396842),
            imageName: "wedge"),
        Location(
            name: "Carrolton Terrace",
            address: "Carrolton Terrace",
            coordinates: CLLocationCoordinate2D(latitude: 38.02768268736969, longitude: -78.51021536065485),
            imageName: "carroltonterrace"),
        Location(
            name: "Venable Court Apartments",
            address: "409 13th St. NW",
            coordinates: CLLocationCoordinate2D(latitude: 38.03751730473587, longitude: -78.4967818790593),
            imageName: "vennables"),
        
        // MARK: GREEK LIFE
        Location(
            name: "Alpha Epsilon Pi",
            address: "1702 Grady Ave",
            coordinates: CLLocationCoordinate2D(latitude: 38.04123869357673, longitude: -78.49979479754187),
            imageName: "aepi"),
        Location(
            name: "Alpha Tau Omega",
            address: "125 Chancellor St.",
            coordinates: CLLocationCoordinate2D(latitude: 38.037101553811404, longitude: -78.50116475492663),
            imageName: "ato"),
        Location(
            name: "Beta Theta Pi",
            address: "180 Rugby Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03915583627535, longitude: -78.50180048274564),
            imageName: "beta"),
        Location(
            name: "Chi Phi",
            address: "161 Rugby Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03851041, longitude: -78.50284446),
            imageName: "chiphi"),
        Location(
            name: "Chi Psi",
            address: "170 Madison Ln.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03852876160937, longitude: -78.50091893762385),
            imageName: "chipsi"),
        Location(
            name: "Delta Kappa Epsilon",
            address: "173 Culbreth Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03919042331371, longitude: -78.50476620175913),
            imageName: "dke"),
        Location(
            name: "Delta Sigma Phi",
            address: "517 Rugby Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.0416568907291, longitude: -78.50076509071363),
            imageName: "dsig"),
        Location(
            name: "Delta Upsilon",
            address: "171 Madison Ln.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03870950617188, longitude: -78.50132318219222),
            imageName: "du"),
        Location(
            name: "Kappa Alpha Order",
            address: "600 Rugby Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.042047054369554, longitude: -78.49997039560441),
            imageName: "ka"),
        Location(
            name: "Kappa Sigma",
            address: "165 Rugby Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03889607315857, longitude: -78.50260083856372),
            imageName: "ksig"),
        Location(
            name: "Phi Delta Theta",
            address: "1703 Grady Ave.",
            coordinates: CLLocationCoordinate2D(latitude: 38.041691711621475, longitude: -78.49971896333882),
            imageName: "phidelt"),
        Location(
            name: "Phi Gamma Delta (FIJI)",
            address: "128 Madison Ln.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03707601259626, longitude: -78.50175224246317),
            imageName: "fiji"),
        Location(
            name: "Phi Kappa Psi",
            address: "159 Madison Ln.",
            coordinates: CLLocationCoordinate2D(latitude: 38.038341123463816, longitude: -78.50159360728193),
            imageName: "phipsi"),
        Location(
            name: "Phi Sigma Kappa",
            address: "1702 Gordon Ave.",
            coordinates: CLLocationCoordinate2D(latitude: 38.040291579715564, longitude: -78.50025788396832),
            imageName: "phisigkapp"),
        Location(
            name: "Phi Society",
            address: "1 University Cir",
            coordinates: CLLocationCoordinate2D(latitude: 38.04215595453377, longitude: -78.50045204426092),
            imageName: "phisociety"),
        Location(
            name: "Pi Kappa Alpha (PIKA)",
            address: "513 Rugby Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.04100056479141, longitude: -78.50123240887697),
            imageName: "pika"),
        Location(
            name: "Pi Kappa Phi",
            address: "510 Rugby Rd",
            coordinates: CLLocationCoordinate2D(latitude: 38.04149098121958, longitude: -78.50031437477747),
            imageName: "pikapp"),
        Location(
            name: "Pi Lambda Phi",
            address: "Pi Lambda Phi",
            coordinates: CLLocationCoordinate2D(latitude: 38.041108292539384, longitude: -78.50053123348283),
            imageName: "pilam"),
        Location(
            name: "Sigma Alpha Epsilon (SAE)",
            address: "150 Madison Ln.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03775860139629, longitude: -78.50139465827702),
            imageName: "sae"),
        Location(
            name: "Sigma Alpha Mu (Sammy)",
            address: "129 Chancellor St.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03745122897497, longitude: -78.50094538825316),
            imageName: "sammy"),
        Location(
            name: "Sigma Chi",
            address: "608 Preston Pl.",
            coordinates: CLLocationCoordinate2D(latitude: 38.04157586673351, longitude: -78.49814041087764),
            imageName: "sigchi"),
        Location(
            name: "Sigma Nu (SNU)",
            address: "189 Culbreth Rd",
            coordinates: CLLocationCoordinate2D(latitude: 38.038941810778816, longitude: -78.50514178643438),
            imageName: "snu"),
        Location(
            name: "Sigma Phi Society (SERP)",
            address: "163 Rugby Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03876386387811, longitude: -78.50308697837015),
            imageName: "serp"),
        Location(
            name: "St. Anthony Hall",
            address: "133 Chancellor St.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03785880839149, longitude: -78.50102887364986),
            imageName: "thehall"),
        Location(
            name: "St. Elmo Hall",
            address: "130 Madison Ln",
            coordinates: CLLocationCoordinate2D(latitude: 38.03729010989096, longitude: -78.50158512272148),
            imageName: "elmo"),
        Location(
            name: "Theta Chi",
            address: "600 Preston Pl",
            coordinates: CLLocationCoordinate2D(latitude: 38.04119423384954, longitude: -78.49837081904874),
            imageName: "thetachi"),
        Location(
            name: "Zeta Psi (Zete)",
            address: "169 Rugby Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03926538019811, longitude: -78.50237801708406),
            imageName: "zete"),
        Location(
            name: "Alpha Chi Omega",
            address: "158 Madison Ln.",
            coordinates: CLLocationCoordinate2D(latitude: 38.0382495184556, longitude: -78.50119034565203),
            imageName: "axo"),
        Location(
            name: "Alpha Delta Pi",
            address: "502 Rugby Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.04090785416697, longitude: -78.50065606695672),
            imageName: "adpi"),
        Location(
            name: "Alpha Phi",
            address: "518 17th St NW",
            coordinates: CLLocationCoordinate2D(latitude: 38.041016928708224, longitude: -78.49922234433032),
            imageName: "aphi"),
        Location(
            name: "Chi Omega",
            address: "123 Chancellor St.",
            coordinates: CLLocationCoordinate2D(latitude: 38.036925017527885, longitude: -78.50121593129704),
            imageName: "xo"),
        Location(
            name: "Delta Delta Delta",
            address: "1537 Virginia Ave",
            coordinates: CLLocationCoordinate2D(latitude: 38.03904410468316, longitude: -78.50038571955011),
            imageName: "tridelt"),
        Location(
            name: "Delta Gamma",
            address: "138 Madison Ln.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03761197378741, longitude: -78.50146007320532),
            imageName: "dg"),
        Location(
            name: "Delta Zeta",
            address: "150 Chancellor St.",
            coordinates: CLLocationCoordinate2D(latitude: 38.0377604174478, longitude: -78.50052582254133),
            imageName: "dz"),
        Location(
            name: "Gamma Phi Beta",
            address: "510 17th St NW",
            coordinates: CLLocationCoordinate2D(latitude: 38.04069082989995, longitude: -78.49941864134885),
            imageName: "gphibeta"),
        Location(
            name: "Kappa Alpha Theta",
            address: "127 Chancellor St.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03728216922609, longitude: -78.5010285557253),
            imageName: "theta"),
        Location(
            name: "Kappa Delta",
            address: "136 Chancellor St.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03732021739889, longitude: -78.5005307905287),
            imageName: "kd"),
        Location(
            name: "Kappa Kappa Gamma",
            address: "503 Rugby Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.04072212454124, longitude: -78.50129324100901),
            imageName: "kappa"),
        Location(
            name: "Pi Beta Phi",
            address: "1509 Grady Ave",
            coordinates: CLLocationCoordinate2D(latitude: 38.040975596064484, longitude: -78.4979228695276),
            imageName: "piphi"),
        Location(
            name: "Sigma Kappa",
            address: "503 16th St NW",
            coordinates: CLLocationCoordinate2D(latitude: 38.04024935712165, longitude: -78.49883291831391),
            imageName: "sk"),
        Location(
            name: "Zeta Tau Alpha",
            address: "136 Madison Ln",
            coordinates: CLLocationCoordinate2D(latitude: 38.03745952677482, longitude: -78.50155221736544),
            imageName: "zeta"),
        
        // MARK: UVA BUILDINGS
        Location(
            name: "Aquatics and Fitness Center (AFC)",
            address: "450 Whitehead Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.032901207403434, longitude: -78.5135671269653),
            imageName: "afc"),
        Location(
            name: "Brooks Hall",
            address: "1700 University Ave.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03581079220464, longitude: -78.50213864043992),
            imageName: "brooks"),
        Location(
            name: "Bryan Hall",
            address: "University of Virginia",
            coordinates: CLLocationCoordinate2D(latitude: 38.033299505658746, longitude: -78.50597624527386),
            imageName: "bryan"),
        Location(
            name: "Clark Hall",
            address: "291 McCormick Rd",
            coordinates: CLLocationCoordinate2D(latitude: 38.032920333801805, longitude: -78.50792113115608),
            imageName: "clark"),
        Location(
            name: "New Cabell Hall",
            address: "1605 Jefferson Park Ave.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03254569137978, longitude: -78.50504419883453),
            imageName: "newcab"),
        Location(
            name: "Cobb Hall",
            address: "University of Virginia",
            coordinates: CLLocationCoordinate2D(latitude: 38.032439794237405, longitude: -78.50299106190117),
            imageName: "cobb"),
        Location(
            name: "Cocke Hall",
            address: "University of Virginia",
            coordinates: CLLocationCoordinate2D(latitude: 38.0336472825348, longitude: -78.50504222207323),
            imageName: "cocke"),
        Location(
            name: "Chemistry Building",
            address: "409 McCormick Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.033843027687624, longitude: -78.51147074527995),
            imageName: "chembuilding"),
        Location(
            name: "Nau Hall",
            address: "1540 Jefferson Park Ave.",
            coordinates: CLLocationCoordinate2D(latitude: 38.031746039351255, longitude: -78.50502535512744),
            imageName: "nau"),
        Location(
            name: "Gibson Hall",
            address: "University of Virginia",
            coordinates: CLLocationCoordinate2D(latitude: 38.03175613217278, longitude: -78.50505249638785),
            imageName: "gibson"),
        Location(
            name: "Gilmer Hall",
            address: "485 McCormick Rd",
            coordinates: CLLocationCoordinate2D(latitude: 38.03414048878122, longitude: -78.51290464296355),
            imageName: "gilmer"),
        Location(
            name: "Lambeth House",
            address: "1914 Thomson Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03651466879834, longitude: -78.50886520798728),
            imageName: "lambeth"),
        Location(
            name: "Old Cabell Hall",
            address: "University of Virginia",
            coordinates: CLLocationCoordinate2D(latitude: 38.03285914735249, longitude: -78.50486981796227),
            imageName: "oldcab"),
        Location(
            name: "Olsson Hall",
            address: "151 Engineer's Way",
            coordinates: CLLocationCoordinate2D(latitude: 38.0320964304539, longitude: -78.51071109501405),
            imageName: "olsson"),
        Location(
            name: "Peabody Hall",
            address: "190 McCormick Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03566484803066, longitude: -78.50611505626377),
            imageName: "peabody"),
        Location(
            name: "Physics Building",
            address: "University of Virginia",
            coordinates: CLLocationCoordinate2D(latitude: 38.03430044840402, longitude: -78.5102402376426),
            imageName: "phys"),
        Location(
            name: "Rouss-Robertson Hall (Comm)",
            address: "140 Hospital Dr.",
            coordinates: CLLocationCoordinate2D(latitude: 38.032877507927005, longitude: -78.50339669545059),
            imageName: "rrh"),
        Location(
            name: "The Rotunda",
            address: "1826 University Ave.",
            coordinates: CLLocationCoordinate2D(latitude: 38.03554889236978, longitude: -78.50344241389197),
            imageName: "tundy"),
        Location(
            name: "Slaughter Recreation Center",
            address: "505 Edgemont Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.0350535993191, longitude: -78.51759389770152),
            imageName: "slaughter"),
        Location(
            name: "Wilson Hall",
            address: "University of Virginia",
            coordinates: CLLocationCoordinate2D(latitude: 38.03247728016114, longitude: -78.50401395600626),
            imageName: "wilson"),
        Location(
            name: "Newcomb Hall",
            address: "180 McCormick Rd",
            coordinates: CLLocationCoordinate2D(latitude: 38.03604133045879, longitude: -78.50696039475625),
            imageName: "newcomb"),
        Location(
            name: "Rice Hall",
            address: "85 Engineer's Way",
            coordinates: CLLocationCoordinate2D(latitude: 38.031622768520485, longitude: -78.51086469559307),
            imageName: "rice"),
        Location(
            name: "Memorial Gymnasium",
            address: "210 Emmet St S",
            coordinates: CLLocationCoordinate2D(latitude: 38.0378252984442, longitude: -78.50700511900716),
            imageName: "mem"),
        Location(
            name: "Monroe Hall",
            address: "University of Virginia",
            coordinates: CLLocationCoordinate2D(latitude: 38.03483114350283, longitude: -78.50643126052802),
            imageName: "monroe"),
        Location(
            name: "Maury Hall",
            address: "University of Virginia",
            coordinates: CLLocationCoordinate2D(latitude: 38.03341701667491, longitude: -78.50684643186189),
            imageName: "maury"),
        Location(
            name: "Thornton Hall",
            address: "351 McCormick Rd.",
            coordinates: CLLocationCoordinate2D(latitude: 38.033270509854646, longitude: -78.50966346793375),
            imageName: "thornton"),
        
        // MARK: BROWN RESIDENTIAL
        Location(
            name: "Brown College",
            address: "256 McCormick Rd",
            coordinates: CLLocationCoordinate2D(latitude: 38.034927760550055, longitude: -78.50786695775557),
            imageName: "brown"),
        
        // MARK: GOOCH/DILLARD
        Location(
            name: "Gooch-Dillard",
            address: "Gooch-Dillard",
            coordinates: CLLocationCoordinate2D(latitude: 38.02918678832225, longitude: -78.51820524638136),
            imageName: "gooch"),
        
        // MARK: HEREFORD RESIDENTIAL
        Location(
            name: "Hereford College",
            address: "185 Hereford Dr",
            coordinates: CLLocationCoordinate2D(latitude: 38.0303468363597, longitude: -78.51988798465743),
            imageName: "hereford"),
        
        // MARK: IRC
        Location(
            name: "International Residential College (IRC)",
            address: "108 Emmet St N",
            coordinates: CLLocationCoordinate2D(latitude: 38.039827693876504, longitude: -78.50745193123154),
            imageName: "irc"),
        
        // MARK: MOTELS
        Location(
            name: "Courtenay House",
            address: "795 Alderman Rd",
            coordinates: CLLocationCoordinate2D(latitude: 38.03091341765395, longitude: -78.51625877116435),
            imageName: "courtenay"),
        Location(
            name: "Dunglison House",
            address: "775 Alderman Rd",
            coordinates: CLLocationCoordinate2D(latitude: 38.03147606718376, longitude: -78.51568745775555),
            imageName: "dunglison"),
        Location(
            name: "Fitzhugh House",
            address: "735 Alderman Rd",
            coordinates: CLLocationCoordinate2D(latitude: 38.032366029129015, longitude: -78.51529840459388),
            imageName: "fitzhugh"),
    ]
    
}

