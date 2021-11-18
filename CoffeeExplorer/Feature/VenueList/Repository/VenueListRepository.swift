//
//  VenueListRepository.swift
//  CoffeeExplorer
//
//  Created by ar on 18/11/2021.
//

import Combine
import CoreLocation

protocol VenueListRepositoryProtocol {
    func fetchVenues(coordinate: Coordinate, offset: Int) -> AnyPublisher<Server.VenueListResponse, NetworkError>
}

struct VenueListRepository {
    
    // MARK: - Properties
    private let network: Fetchable
    
    // MARK: - Intializers
    init(with network: Fetchable = NetworkManager()) {
        self.network = network
    }
}

extension VenueListRepository: VenueListRepositoryProtocol {
    
    func fetchVenues(coordinate: Coordinate, offset: Int) -> AnyPublisher<Server.VenueListResponse, NetworkError> {
        network.fetch(using: VenueListRequest(query: VenueListQuery(offset: offset, coordinate: coordinate)))
    }
}

var json: String {
    """
{
    "meta": {
        "code": 200,
        "requestId": "61967156715fba28a6047cad"
    },
    "response": {
        "headerLocation": "Al-Jadaf",
        "headerFullLocation": "Al-Jadaf, Dubai",
        "headerLocationGranularity": "neighborhood",
        "query": "coffee",
        "totalResults": 5,
        "suggestedBounds": {
            "ne": {
                "lat": 25.238640009000008,
                "lng": 55.347560509313986
            },
            "sw": {
                "lat": 25.22063999099999,
                "lng": 55.32769949068601
            }
        },
        "groups": [{
            "type": "Recommended Places",
            "name": "recommended",
            "items": [{
                "reasons": {
                    "count": 0,
                    "items": [{
                        "summary": "This spot is popular",
                        "type": "general",
                        "reasonName": "globalInteractionReason"
                    }]
                },
                "venue": {
                    "id": "4b69a4e4f964a52006ab2be3",
                    "name": "Panini بانيني",
                    "contact": {
                        "phone": "+97143172221",
                        "formattedPhone": "+971 4 317 2221"
                    },
                    "location": {
                        "address": "Grand Hyatt Hotel",
                        "crossStreet": "at Sheikh Rashid Rd",
                        "lat": 25.228349611900093,
                        "lng": 55.32819612430971,
                        "labeledLatLngs": [{
                            "label": "display",
                            "lat": 25.228349611900093,
                            "lng": 55.32819612430971
                        }],
                        "distance": 960,
                        "cc": "AE",
                        "city": "Bur Dubai",
                        "state": "Dubai",
                        "country": "United Arab Emirates",
                        "formattedAddress": ["Grand Hyatt Hotel (at Sheikh Rashid Rd)", "Bur Dubai", "United Arab Emirates"]
                    },
                    "categories": [{
                        "id": "4bf58dd8d48988d16d941735",
                        "name": "Café",
                        "pluralName": "Cafés",
                        "shortName": "Café",
                        "icon": {
                            "prefix": "https://ss3.4sqi.net/img/categories_v2/food/cafe_",
                            "suffix": ".png"
                        },
                        "primary": true
                    }],
                    "verified": false,
                    "stats": {
                        "tipCount": 32,
                        "usersCount": 647,
                        "checkinsCount": 1443
                    },
                    "url": "http://dubai.grand.hyatt.com/en/hotel/dining/Panini.html",
                    "price": {
                        "tier": 1,
                        "message": "Cheap",
                        "currency": "$"
                    },
                    "rating": 7.6,
                    "ratingColor": "C5DE35",
                    "ratingSignals": 73,
                    "menu": {
                        "type": "Menu",
                        "label": "Menu",
                        "anchor": "View Menu",
                        "url": "https://www.roundmenu.com/dubai/panini-cafe",
                        "mobileUrl": "https://www.roundmenu.com/dubai/panini-cafe",
                        "externalUrl": "https://www.roundmenu.com/dubai/panini-cafe"
                    },
                    "allowMenuUrlEdit": true,
                    "beenHere": {
                        "count": 0,
                        "marked": false,
                        "lastCheckinExpiredAt": 0
                    },
                    "hours": {
                        "status": "Open until 1:00 AM",
                        "richStatus": {
                            "entities": [],
                            "text": "Open until 1:00 AM"
                        },
                        "isOpen": true,
                        "isLocalHoliday": false
                    },
                    "photos": {
                        "count": 1,
                        "groups": [{
                            "type": "venue",
                            "name": "Venue photos",
                            "count": 1,
                            "items": [{
                                "id": "51d29697498e5a8f6d1c86be",
                                "createdAt": 1372755607,
                                "prefix": "https://fastly",
                                "suffix": "/48803883_V6oTmii9jy6vhSB26PK19dWPeIETPK__AgOe9h9M7ss.jpg",
                                "width": 960,
                                "height": 720,
                                "visibility": "public"
                            }]
                        }]
                    },
                    "hereNow": {
                        "count": 0,
                        "summary": "Nobody here",
                        "groups": []
                    },
                    "popularityByGeo": 0.9568935746643102,
                    "featuredPhotos": {
                        "count": 1,
                        "items": [{
                            "id": "51d29697498e5a8f6d1c86be",
                            "createdAt": 1372755607,
                            "prefix": "https://fastly.4sq",
                            "suffix": "/48803883_V6oTmii9jy6vhSB26PK19dWPeIETPK__AgOe9h9M7ss.jpg",
                            "width": 960,
                            "height": 720,
                            "visibility": "public"
                        }]
                    }
                },
                "tips": [{
                    "id": "51ddcdc1498e18209043fc78",
                    "createdAt": 1373490625,
                    "text": "The best strawberry cheesecake in Dubai!",
                    "type": "user",
                    "canonicalUrl": "https://foursquare.com/item/51ddcdc1498e18209043fc78",
                    "likes": {
                        "count": 17,
                        "groups": [],
                        "summary": "17 likes"
                    },
                    "logView": true,
                    "agreeCount": 17,
                    "disagreeCount": 0,
                    "todo": {
                        "count": 2
                    },
                    "user": {
                        "firstName": "Khulood",
                        "lastName": "A",
                        "countryCode": "AE"
                    }
                }],
                "referralId": "e-5-4b69a4e4f964a52006ab2be3-0"
            }, {
                "reasons": {
                    "count": 0,
                    "items": [{
                        "summary": "This spot is popular",
                        "type": "general",
                        "reasonName": "globalInteractionReason"
                    }]
                },
                "venue": {
                    "id": "52dd965f11d20cf4b3a32675",
                    "name": "Lobby Lounge",
                    "contact": {},
                    "location": {
                        "address": "Grand Hyatt Hotel Dubai",
                        "lat": 25.228388496096855,
                        "lng": 55.32820388912256,
                        "labeledLatLngs": [{
                            "label": "display",
                            "lat": 25.228388496096855,
                            "lng": 55.32820388912256
                        }],
                        "distance": 959,
                        "cc": "AE",
                        "city": "Dubai",
                        "state": "Dubai",
                        "country": "United Arab Emirates",
                        "formattedAddress": ["Grand Hyatt Hotel Dubai", "Dubai", "United Arab Emirates"]
                    },
                    "categories": [{
                        "id": "4bf58dd8d48988d16d941735",
                        "name": "Café",
                        "pluralName": "Cafés",
                        "shortName": "Café",
                        "icon": {
                            "prefix": "https://ss3.4sqi.net/img/categories_v2/food/cafe_",
                            "suffix": ".png"
                        },
                        "primary": true
                    }],
                    "verified": false,
                    "stats": {
                        "tipCount": 2,
                        "usersCount": 97,
                        "checkinsCount": 158
                    },
                    "price": {
                        "tier": 1,
                        "message": "Cheap",
                        "currency": "$"
                    },
                    "rating": 7.4,
                    "ratingColor": "C5DE35",
                    "ratingSignals": 9,
                    "allowMenuUrlEdit": true,
                    "beenHere": {
                        "count": 0,
                        "marked": false,
                        "lastCheckinExpiredAt": 0
                    },
                    "photos": {
                        "count": 1,
                        "groups": [{
                            "type": "venue",
                            "name": "Venue photos",
                            "count": 1,
                            "items": [{
                                "id": "5c17572931fd14002c329ac3",
                                "createdAt": 1545033513,
                                "prefix": "https://fastly.4sqi.net/img/general/",
                                "suffix": "/54924370_F8zCMAO7rWxkRdRMs3rYh6pi5vnE3oNv9R6ZVvtt8K4.jpg",
                                "width": 1440,
                                "height": 1920,
                                "visibility": "public"
                            }]
                        }]
                    },
                    "hereNow": {
                        "count": 0,
                        "summary": "Nobody here",
                        "groups": []
                    },
                    "popularityByGeo": 0.0979746886871026,
                    "featuredPhotos": {
                        "count": 1,
                        "items": [{
                            "id": "5c17572931fd14002c329ac3",
                            "createdAt": 1545033513,
                            "prefix": "https://fastly.4sqi.net/img/general/",
                            "suffix": "/54924370_F8zCMAO7rWxkRdRMs3rYh6pi5vnE3oNv9R6ZVvtt8K4.jpg",
                            "width": 1440,
                            "height": 1920,
                            "visibility": "public"
                        }]
                    }
                },
                "tips": [{
                    "id": "588ea8f62e9fde540df2eb0b",
                    "createdAt": 1485744374,
                    "text": "All of hear!!",
                    "type": "user",
                    "canonicalUrl": "https://foursquare.com/item/588ea8f62e9fde540df2eb0b",
                    "photo": {
                        "id": "588ea8f865be58175bf3a161",
                        "createdAt": 1485744376,
                        "source": {
                            "name": "Foursquare for iOS",
                            "url": "https://foursquare.com/download/#/iphone"
                        },
                        "prefix": "https://fastly.4sqi.net/img/general/",
                        "suffix": "/4591913_PEegeA5xqQ8_HPXm2Vv9jIjtOs27ioEynW4rb13_3uw.jpg",
                        "width": 1440,
                        "height": 1440,
                        "visibility": "public"
                    },
                    "photourl": "https://fastly.4sqi.net/img/general/original/4591913_PEegeA5xqQ8_HPXm2Vv9jIjtOs27ioEynW4rb13_3uw.jpg",
                    "logView": true,
                    "agreeCount": 0,
                    "disagreeCount": 0,
                    "todo": {
                        "count": 0
                    },
                    "user": {
                        "firstName": "JS",
                        "lastName": "L",
                        "countryCode": "KR"
                    }
                }],
                "referralId": "e-5-52dd965f11d20cf4b3a32675-1"
            }, {
                "reasons": {
                    "count": 0,
                    "items": [{
                        "summary": "This spot is popular",
                        "type": "general",
                        "reasonName": "globalInteractionReason"
                    }]
                },
                "venue": {
                    "id": "5687b41e498eede81b423676",
                    "name": "Sketch Art Cafe",
                    "contact": {},
                    "location": {
                        "address": "Al Boom Tourist Village",
                        "lat": 25.232662,
                        "lng": 55.335057,
                        "labeledLatLngs": [{
                            "label": "display",
                            "lat": 25.232662,
                            "lng": 55.335057
                        }],
                        "distance": 424,
                        "cc": "AE",
                        "country": "United Arab Emirates",
                        "formattedAddress": ["Al Boom Tourist Village", "United Arab Emirates"]
                    },
                    "categories": [{
                        "id": "4bf58dd8d48988d16d941735",
                        "name": "Café",
                        "pluralName": "Cafés",
                        "shortName": "Café",
                        "icon": {
                            "prefix": "https://ss3.4sqi.net/img/categories_v2/food/cafe_",
                            "suffix": ".png"
                        },
                        "primary": true
                    }],
                    "verified": false,
                    "stats": {
                        "tipCount": 1,
                        "usersCount": 10,
                        "checkinsCount": 12
                    },
                    "price": {
                        "tier": 1,
                        "message": "Cheap",
                        "currency": "$"
                    },
                    "allowMenuUrlEdit": true,
                    "beenHere": {
                        "count": 0,
                        "marked": false,
                        "lastCheckinExpiredAt": 0
                    },
                    "photos": {
                        "count": 1,
                        "groups": [{
                            "type": "venue",
                            "name": "Venue photos",
                            "count": 1,
                            "items": [{
                                "id": "56950489498edcab3c8c366f",
                                "createdAt": 1452606601,
                                "prefix": "https://fastly.4sqi.net/img/general/",
                                "suffix": "/37318010_rMmCmsUlDDo8NcLdA0vpPzqcXchmDZxEsLKNnHQKE2U.jpg",
                                "width": 1440,
                                "height": 1440,
                                "visibility": "public"
                            }]
                        }]
                    },
                    "hereNow": {
                        "count": 0,
                        "summary": "Nobody here",
                        "groups": []
                    },
                    "popularityByGeo": 0.6751477847522701,
                    "featuredPhotos": {
                        "count": 1,
                        "items": [{
                            "id": "56950489498edcab3c8c366f",
                            "createdAt": 1452606601,
                            "prefix": "https://fastly.4sqi.net/img/general/",
                            "suffix": "/37318010_rMmCmsUlDDo8NcLdA0vpPzqcXchmDZxEsLKNnHQKE2U.jpg",
                            "width": 1440,
                            "height": 1440,
                            "visibility": "public"
                        }]
                    }
                },
                "tips": [{
                    "id": "56b04707498e5cc8e5f5c0eb",
                    "createdAt": 1454393095,
                    "text": "It's cafe on old ship..Good specialty coffee .. They have few selection of dessert..I don't know what they will do in the summer.. ( it's an outdoor place )",
                    "type": "user",
                    "canonicalUrl": "https://foursquare.com/item/56b04707498e5cc8e5f5c0eb",
                    "logView": true,
                    "agreeCount": 0,
                    "disagreeCount": 0,
                    "todo": {
                        "count": 0
                    },
                    "user": {
                        "firstName": "Deema_Fahad",
                        "countryCode": "SA"
                    }
                }],
                "referralId": "e-5-5687b41e498eede81b423676-2"
            }, {
                "reasons": {
                    "count": 0,
                    "items": [{
                        "summary": "This spot is popular",
                        "type": "general",
                        "reasonName": "globalInteractionReason"
                    }]
                },
                "venue": {
                    "id": "52ee6a8a498e71d259f6e558",
                    "name": "seattle's best cofee I سياتل بيست كوفي",
                    "contact": {},
                    "location": {
                        "address": "مول الإمارات",
                        "lat": 25.231795042827596,
                        "lng": 55.34671465481645,
                        "labeledLatLngs": [{
                            "label": "display",
                            "lat": 25.231795042827596,
                            "lng": 55.34671465481645
                        }],
                        "distance": 945,
                        "cc": "AE",
                        "city": "Dubai",
                        "state": "Dubai",
                        "country": "United Arab Emirates",
                        "formattedAddress": ["مول الإمارات", "Dubai", "United Arab Emirates"]
                    },
                    "categories": [{
                        "id": "4bf58dd8d48988d16d941735",
                        "name": "Café",
                        "pluralName": "Cafés",
                        "shortName": "Café",
                        "icon": {
                            "prefix": "https://ss3.4sqi.net/img/categories_v2/food/cafe_",
                            "suffix": ".png"
                        },
                        "primary": true
                    }],
                    "verified": false,
                    "stats": {
                        "tipCount": 1,
                        "usersCount": 14,
                        "checkinsCount": 17
                    },
                    "price": {
                        "tier": 1,
                        "message": "Cheap",
                        "currency": "$"
                    },
                    "allowMenuUrlEdit": true,
                    "beenHere": {
                        "count": 0,
                        "marked": false,
                        "lastCheckinExpiredAt": 0
                    },
                    "photos": {
                        "count": 1,
                        "groups": [{
                            "type": "venue",
                            "name": "Venue photos",
                            "count": 1,
                            "items": [{
                                "id": "5880ef7fa14926637425e2e5",
                                "createdAt": 1484844927,
                                "prefix": "https://fastly.4sqi.net/img/general/",
                                "suffix": "/134514577_NF_p6iV9LHwkZp0eG8ZKNZh3rLWfuKihSdQSHG5xIH4.jpg",
                                "width": 720,
                                "height": 1039,
                                "visibility": "friends"
                            }]
                        }]
                    },
                    "hereNow": {
                        "count": 0,
                        "summary": "Nobody here",
                        "groups": []
                    },
                    "popularityByGeo": 0.9003087736404819,
                    "featuredPhotos": {
                        "count": 1,
                        "items": [{
                            "id": "5880ef7fa14926637425e2e5",
                            "createdAt": 1484844927,
                            "prefix": "https://fastly.4sqi.net/img/general/",
                            "suffix": "/134514577_NF_p6iV9LHwkZp0eG8ZKNZh3rLWfuKihSdQSHG5xIH4.jpg",
                            "width": 720,
                            "height": 1039,
                            "visibility": "friends"
                        }]
                    }
                },
                "tips": [{
                    "id": "53ed014f498e974a457ff9d7",
                    "createdAt": 1408041295,
                    "text": "القهوة الأمريكية لذيذة وخفيفة",
                    "type": "user",
                    "canonicalUrl": "https://foursquare.com/item/53ed014f498e974a457ff9d7",
                    "logView": true,
                    "agreeCount": 0,
                    "disagreeCount": 0,
                    "todo": {
                        "count": 0
                    },
                    "user": {
                        "firstName": "Ahmed",
                        "lastName": "a",
                        "countryCode": "SA"
                    }
                }],
                "referralId": "e-5-52ee6a8a498e71d259f6e558-3"
            }, {
                "reasons": {
                    "count": 0,
                    "items": [{
                        "summary": "This spot is popular",
                        "type": "general",
                        "reasonName": "globalInteractionReason"
                    }]
                },
                "venue": {
                    "id": "54c24896498ef486a9a00d2d",
                    "name": "Poolside Restaurant (بار بركة السباحة)",
                    "contact": {
                        "phone": "+97143172221",
                        "formattedPhone": "+971 4 317 2221",
                        "twitter": "grandhyattdxb",
                        "facebook": "237414769650134",
                        "facebookUsername": "GrandHyattDubai",
                        "facebookName": "Grand Hyatt Dubai"
                    },
                    "location": {
                        "address": "Grand Hyatt Dubai",
                        "crossStreet": "Dubai Healthcare City",
                        "lat": 25.229504145566914,
                        "lng": 55.32769080785248,
                        "labeledLatLngs": [{
                            "label": "display",
                            "lat": 25.229504145566914,
                            "lng": 55.32769080785248
                        }],
                        "distance": 1000,
                        "postalCode": "7978",
                        "cc": "AE",
                        "city": "Dubai",
                        "state": "Dubai",
                        "country": "United Arab Emirates",
                        "formattedAddress": ["Grand Hyatt Dubai (Dubai Healthcare City)", "Dubai", "United Arab Emirates"]
                    },
                    "categories": [{
                        "id": "4bf58dd8d48988d1c4941735",
                        "name": "Restaurant",
                        "pluralName": "Restaurants",
                        "shortName": "Restaurant",
                        "icon": {
                            "prefix": "https://ss3.4sqi.net/img/categories_v2/food/default_",
                            "suffix": ".png"
                        },
                        "primary": true
                    }],
                    "verified": false,
                    "stats": {
                        "tipCount": 1,
                        "usersCount": 51,
                        "checkinsCount": 85
                    },
                    "url": "http://dubai.grand.hyatt.com/en/hotel/dining/PoolsideRestaurant.html",
                    "price": {
                        "tier": 2,
                        "message": "Moderate",
                        "currency": "$"
                    },
                    "menu": {
                        "type": "Menu",
                        "label": "Menu",
                        "anchor": "View Menu",
                        "url": "http://www.hyattrestaurants.com/menu/?p_id=839&poolside-restaurant-fast-food-restaurant-menu=",
                        "mobileUrl": "http://www.hyattrestaurants.com/menu/?p_id=839&poolside-restaurant-fast-food-restaurant-menu=",
                        "externalUrl": "http://www.hyattrestaurants.com/menu/?p_id=839&poolside-restaurant-fast-food-restaurant-menu="
                    },
                    "allowMenuUrlEdit": true,
                    "beenHere": {
                        "count": 0,
                        "marked": false,
                        "lastCheckinExpiredAt": 0
                    },
                    "hours": {
                        "status": "Open until 8:00 PM",
                        "richStatus": {
                            "entities": [],
                            "text": "Open until 8:00 PM"
                        },
                        "isOpen": true,
                        "isLocalHoliday": false
                    },
                    "photos": {
                        "count": 1,
                        "groups": [{
                            "type": "venue",
                            "name": "Venue photos",
                            "count": 1,
                            "items": [{
                                "id": "5a09d36fc0f16370f31ae403",
                                "createdAt": 1510593391,
                                "prefix": "https://fastly.4sqi.net/img/general/",
                                "suffix": "/6327070_By_3deTNAaumiW_vWti2OcM3g338qXjRVqFNi9ajBK4.jpg",
                                "width": 1425,
                                "height": 1900,
                                "visibility": "public"
                            }]
                        }]
                    },
                    "hereNow": {
                        "count": 0,
                        "summary": "Nobody here",
                        "groups": []
                    },
                    "popularityByGeo": 0.8556280090194406,
                    "featuredPhotos": {
                        "count": 1,
                        "items": [{
                            "id": "5a09d36fc0f16370f31ae403",
                            "createdAt": 1510593391,
                            "prefix": "https://fastly.4sqi.net/img/general/",
                            "suffix": "/6327070_By_3deTNAaumiW_vWti2OcM3g338qXjRVqFNi9ajBK4.jpg",
                            "width": 1425,
                            "height": 1900,
                            "visibility": "public"
                        }]
                    }
                },
                "tips": [{
                    "id": "5d74eb12d569620006ea7146",
                    "createdAt": 1567943442,
                    "text": "We had fish bun Chips. Shrimp Pizza. Hot fresh plentifully, very large serving",
                    "type": "user",
                    "canonicalUrl": "https://foursquare.com/item/5d74eb12d569620006ea7146",
                    "logView": true,
                    "agreeCount": 0,
                    "disagreeCount": 0,
                    "todo": {
                        "count": 0
                    },
                    "user": {
                        "firstName": "Jasmine",
                        "lastName": "F",
                        "countryCode": "KN"
                    }
                }],
                "referralId": "e-5-54c24896498ef486a9a00d2d-4"
            }]
        }]
    }
}
"""
}
