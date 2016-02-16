---
title: TransAPI Business use cases
is_use_case: true
side_menu:
  - title: Authorization use cases
    url: /use-cases/authorization-use-cases/
  - title: TransAPI Business use cases
    url: /use-cases/transapi-business-use-cases/
    active: true
  - title: TransAPI Business dictionary
    url: /use-cases/transapi-business-dictionary/

table_of_content:
  - title: Adding a load offer based on an order in external system
    url: /use-cases/transapi-business-use-cases/#adding_a_load_offer_based_on_an_order_in_external_system
  - title: Search offers with free vehicle to complete order in external system
    url: /use-cases/transapi-business-use-cases/#search_offers_with_free_vehicle_to_complete_order_in_external_system
  - title: Find load offers for driver with empty vehicle on a way back based on order in external system
    url: /use-cases/transapi-business-use-cases/#find_load_offers_for_driver_with_empty_vehicle_on_a_way_back_based_on_order_in_external_system
  - title: Adding vehicle offer
    url: /use-cases/transapi-business-use-cases/#adding_vehicle_offer
  - title: Search additional loading during transit
    url: /use-cases/transapi-business-use-cases/#search_additional_loading_during_transit
  - title: Malfunction of vehicle executing transit. Search for vehicle offers in the area, which can replace it
    url: /use-cases/transapi-business-use-cases/#malfunction_of_vehicle_executing_transit_search_for_vehicle_offers_in_the_area_which_can_replace_it
  - title:  Additional transport offer on route
    url: /use-cases/transapi-business-use-cases/#additional_transport_offer_on_route
  - title: Finding specific vehicle offer type
    url: /use-cases/transapi-business-use-cases/#finding_specific_vehicle_offer_type
  - title: Several different types of truck body
    url: /use-cases/transapi-business-use-cases/#several_different_types_of_truck_body
  - title: Adding load offer within cluster
    url: /use-cases/transapi-business-use-cases/#adding_load_offer_within_cluster
   
---

<a class="anchor" name="adding_a_load_offer_based_on_an_order_in_external_system"></a>

## 1. Adding a load offer based on an order in external system

#### Scenario ####
* User of a system being integrated with Trans.eu platform (external system) receives a contract to transport a load, but doesn't have a contract with a transport company or doesn't have any vehicle available,
* the user adds the load offer in Trans.eu based on existing offer in external system,
* person or company interested in transport execution contacts owner of the offer.

#### HTTP Request #####

```http
POST /api/rest/v1/loads HTTP/1.1
Content-Type: application/hal+json
Accept: application/hal+json
Authorization: Bearer {access_token}
Host: offers.system.trans.eu

{
  "load_weight": {
    "value": 9.65,
    "unit_code": "TNE"
  },
  "loading_place": {
    "address": {
      "country": "PL",
      "locality": "Warszawa",
      "postal_code": "00-125"
    }
  },
  "required_truck_body": {
    "id": "tent"
  },
  "loading_date": "2015-10-22T14:57:56+00:00",
  "unloading_date" : "2015-10-23T14:59:56+00:00",
  "unloading_place": {
    "address": {
      "country": "PL",
      "locality": "Wrocław",
      "postal_code": "53-307"
    }
  },
  "price": 4.11,
  "price_currency": "PLN"
}
```

#### Expected response body: ####

```http
HTTP/1.1 201 Created
Content-Type: application/hal+json

{
  "id": 123456789,
  "creation_date": "2015-10-21T08:54:23+0000",
  "publication_date": null,
  "finish_date": "2015-10-23T14:59:56+0000",
  "loading_place": {
    "address": {
      "country": "PL",
      "postal_code": "00-125",
      "locality": "Warszawa"
    },
    "geo": {
      "latitude": null,
      "longitude": null
    }
  },
  "loading_date": "2015-10-22T14:57:56+0000",
  "unloading_place": {
    "address": {
      "country": "PL",
      "postal_code": "53-307",
      "locality": "Wrocław"
    },
    "geo": {
      "latitude": null,
      "longitude": null
    }
  },
  "unloading_date": "2015-10-23T14:59:56+0000",
  "price": 4.11,
  "price_currency": "PLN",
  "description": null,
  "type": "public",
  "load_length": {
    "unit_code": null,
    "value": null
  },
  "load_height": {
    "unit_code": null,
    "value": null
  },
  "load_volume": {
    "unit_code": null,
    "value": null
  },
  "load_weight": {
    "unit_code": "TNE",
    "value": 9.65
  },
  "pallets": null,
  "is_ltl": null,
  "is_lift_required": null,
  "is_truck_crane_required": null,
  "is_tir_cable_required": null,
  "is_tracking_system_required": null,
  "is_for_clearance": null,
  "required_ways_of_loading": null,
  "required_adr_classes": null,
  "_links": {
    "self": {
      "href": "https://offers.system.trans.eu/api/rest/v1/loads/GENERATED_ID"
    },
    "offerer": {
      "id": 1031652,
      "href": "https://companies.system.trans.eu/api/rest/v1/employees/1031652"
    },
    "company": {
      "id": 10,
      "href": "https://companies.system.trans.eu/api/rest/v1/companies/10"
    },
    "contact_persons": {
      "ids": [
        1031652
      ],
      "href": "https://companies.system.trans.eu/api/rest/v1/employees?filter={"id":[1031652]}"
    },
    "required_truck_body": {
      "id": "tent",
      "href": "https://offers.system.trans.eu/api/rest/v1/truck-bodies/tent"
    }
  }
}
```

<a class="anchor" name="search_offers_with_free_vehicle_to_complete_order_in_external_system"></a>

## 2. Search offers with free vehicle to complete order in external system ##

* User of a system being integrated with Trans.eu platform (external system) receives a contract to transport a load, but he doesn't have a contract with a transport company or doesn't have any vehicle available,
* User performs search for vehicles in Trans.eu based on offer existing in external system,
* user receives list of vehicles offers meeting his search criteria and can browse details of each offer.

#### Available filters #####

**Endpoint:** `https://offers.system.trans.eu/api/rest/v1/vehicles?filter={json_filter}`

* Locality

```json
{
   "loading_place":{
      "address":{
         "locality":"Warszawa"
      }
   },
   "unloading_place":{
      "address":{
         "locality":"Wrocław"
      },
      "required_truck_body":{
         "id":"tent"
      },
      "cargo_space_capacity":{
         "$gt":0.965
      }
   }
}
```

* Circle area (latitude, longitude)

```json
{
   "circle_area":{
      "start":{
         "latitude":"52,2296756",
         "longitude":"21,0122287",
         "distance":10000
      },
      "end":{
         "latitude":"51,108142",
         "longitude":"17,037338",
         "distance":10000
      }
   },
   "required_truck_body":{
      "id":"tent"
   },
   "cargo_space_capacity":{
      "$gt":0.965
   }
}
```

#### HTTP Request #####

```http
GET /api/rest/v1/vehicles?filter={json_filter} HTTP/1.1
Content-Type: application/hal+json
Accept: application/hal+json
Authorization: Bearer {access_token}
Host: offers.system.trans.eu
```

#### Response body: ####
```http
HTTP/1.1 201 Created
Content-Type: application/hal+json

{
  "_links": {
    "self": {
      "href": "https://offers.system.trans.eu/api/rest/v1/vehicles?filter={"circle_area":{"start":{"latitude":"52,2296756","longitude":"21,0122287","distance":10000},"end":{"latitude":"51,108142","longitude":"17,037338","distance":10000}},"required_truck_body":{"id":"tent"},"cargo_space_capacity":{"$gt":0.965}}&page=1"
    },
    "first": {
      "href": "https://offers.system.trans.eu/api/rest/v1/vehicles?filter={"circle_area":{"start":{"latitude":"52,2296756","longitude":"21,0122287","distance":10000},"end":{"latitude":"51,108142","longitude":"17,037338","distance":10000}},"required_truck_body":{"id":"tent"},"cargo_space_capacity":{"$gt":0.965}}"
    },
    "last": {
      "href": "https://offers.system.trans.eu/api/rest/v1/vehicles?filter={"circle_area":{"start":{"latitude":"52,2296756","longitude":"21,0122287","distance":10000},"end":{"latitude":"51,108142","longitude":"17,037338","distance":10000}},"required_truck_body":{"id":"tent"},"cargo_space_capacity":{"$gt":0.965}}&page=1"
    }
  },
  "_embedded": {
    "vehicles": [
      {
        "id": 396343484,
        "creation_date": "2015-10-05T08:24:58 0000",
        "publication_date": null,
        "finish_date": "2015-10-06T15:00:00 0000",
        "loading_place": {
          "address": {
            "country": "PL",
            "postal_code": "00-001",
            "locality": "Warszawa"
          },
          "geo": {
            "latitude": 52.2445,
            "longitude": 21.0291
          }
        },
        "loading_date": "2015-10-05T09:00:00 0000",
        "unloading_place": {
          "address": {
            "country": "PL",
            "postal_code": "50-001",
            "locality": "Wrocław"
          },
          "geo": {
            "latitude": 51.1194,
            "longitude": 17.028
          }
        },
        "unloading_date": "2015-10-06T15:00:00 0000",
        "price": 0,
        "price_currency": "EUR",
        "description": "16/17ep paleciak",
        "type": "public",
        "cargo_space_capacity": {
          "value": 6.5,
          "unit_code": "TNE"
        },
        "cargo_space_length": {
          "value": 7,
          "unit_code": "MTR"
        },
        "cargo_space_height": {
          "value": 2.4,
          "unit_code": "MTR"
        },
        "cargo_space_volume": {
          "value": null,
          "unit_code": null
        },
        "ltl_available": false,
        "has_adr": false,
        "has_lift": true,
        "has_truck_crane": false,
        "has_tir_cable": false,
        "has_tir_carnet": false,
        "has_pallet_bin": false,
        "has_tracking_system": false,
        "available_ways_of_loading": [
          "side",
          "back"
        ],
        "_embedded": {
          "start_distance": {
            "id": "0.911839,0.367027-0.911579806469,0.366732573997",
            "value": 2012.332764,
            "unit_code": "MTR",
            "_links": {
              "self": {
                "href": "https://offers.system.trans.eu/api/rest/v1/distances/0.911839,0.367027-0.911579806469,0.366732573997"
              }
            }
          },
          "end_distance": {
            "id": "0.892202,0.297195-0.892005352477,0.297357643875",
            "value": 1411.531616,
            "unit_code": "MTR",
            "_links": {
              "self": {
                "href": "https://offers.system.trans.eu/api/rest/v1/distances/0.892202,0.297195-0.892005352477,0.297357643875"
              }
            }
          }
        },
        "_links": {
          "self": {
            "href": "https://offers.system.trans.eu/api/rest/v1/vehicles/396343484"
          },
          "offerer": {
            "id": 1089919,
            "href": "https://companies.system.trans.eu/api/rest/v1/employees/1089919"
          },
          "company": {
            "id": 648761,
            "href": "https://companies.system.trans.eu/api/rest/v1/companies/648761"
          },
          "contact_persons": {
            "ids": [
              1089919
            ],
            "href": "https://companies.system.trans.eu/api/rest/v1/employees?filter={"id":[1089919]}"
          },
          "truck_body": {
            "id": "tent",
            "href": "https://offers.system.trans.eu/api/rest/v1/truck-bodies/tent"
          }
        }
      },
	  ...
    ]
  },
  "page_count": 1,
  "page_size": 20,
  "total_items": 3
}
```

<a class="anchor" name="find_load_offers_for_driver_with_empty_vehicle_on_a_way_back_based_on_order_in_external_system"></a>

## 3. Find load offers for driver with empty vehicle on a way back based on order in external system ##

* User of a system being integrated with Trans.eu platform (external system) knows that chosen vehicle will drive a route from Warsaw to Berlin,
* User doesn't have a contract for load transit on the way back,
* Based on the original order and the vehicle, user wants to search for a load offer with loading location near Berlin and unloading location near Warsaw.

#### Available filters #####

**URL** `https://offers.system.trans.eu/api/rest/v1/loads?filter={json_filter}`

* Circle area (latitude, longitude):
```json
{
    "circle_area":{
        "start":{
            "latitude":"52,5234051",
            "longitude":"13,4113999",
            "distance":25000
        },
        "end":{
            "latitude":"52,2296756",
            "longitude":"21,0122287",
            "distance":25000
        }
    }
}
```

#### HTTP Request #####

```http
GET /api/rest/v1/loads?filter={json_filter} HTTP/1.1
Accept: application/hal+json
Content-Type: application/hal+json
Authorization: Bearer {access_token}
Host: offers.system.trans.eu
```

#### Expected response body: ####

```json
{
  "_links": {
    "self": {
      "href": "https://offers.system.trans.eu/api/rest/v1/loads?filter={"circle_area":{"start":{"latitude":"52,5234051","longitude":"13,4113999","distance":25000},"end":{"latitude":"52,2296756","longitude":"21,0122287","distance":25000}}}&page=1"
    },
    "first": {
      "href": "https://offers.system.trans.eu/api/rest/v1/loads?filter={"circle_area":{"start":{"latitude":"52,5234051","longitude":"13,4113999","distance":25000},"end":{"latitude":"52,2296756","longitude":"21,0122287","distance":25000}}}"
    },
    "last": {
      "href": "https://offers.system.trans.eu/api/rest/v1/loads?filter={"circle_area":{"start":{"latitude":"52,5234051","longitude":"13,4113999","distance":25000},"end":{"latitude":"52,2296756","longitude":"21,0122287","distance":25000}}}&page=1"
    }
  },
  "_embedded": {
    "loads": [
      {
        "id": 396399892,
        "creation_date": "2015-10-05T09:19:22 0000",
        "publication_date": null,
        "finish_date": "2015-10-07T16:00:00 0000",
        "loading_place": {
          "address": {
            "country": "DE",
            "postal_code": "10245",
            "locality": "Berlin"
          },
          "geo": {
            "latitude": 52.5011,
            "longitude": 13.4557
          }
        },
        "loading_date": "2015-10-06T10:00:00 0000",
        "unloading_place": {
          "address": {
            "country": "PL",
            "postal_code": "00-002",
            "locality": "Warszawa"
          },
          "geo": {
            "latitude": 52.2355,
            "longitude": 21.0102
          }
        },
        "unloading_date": "2015-10-07T16:00:00 0000",
        "price": 440,
        "price_currency": "EUR",
        "description": "",
        "type": "public",
        "load_length": {
          "value": 15.4,
          "unit_code": "MTR"
        },
        "load_height": {
          "value": 2.8,
          "unit_code": "MTR"
        },
        "load_volume": {
          "value": null,
          "unit_code": null
        },
        "load_weight": {
          "value": 10.5,
          "unit_code": "TNE"
        },
        "pallets": null,
        "is_ltl": false,
        "is_lift_required": false,
        "is_truck_crane_required": false,
        "is_tir_cable_required": false,
        "is_tracking_system_required": false,
        "is_for_clearance": false,
        "required_ways_of_loading": [
          "side"
        ],
        "required_adr_classes": null,
        "_embedded": {
          "start_distance": {
            "id": "0.916317,0.234846-0.916706353354,0.234073085557",
            "value": 3899.559814,
            "unit_code": "MTR",
            "_links": {
              "self": {
                "href": "https://offers.system.trans.eu/api/rest/v1/distances/0.916317,0.234846-0.916706353354,0.234073085557"
              }
            }
          },
          "end_distance": {
            "id": "0.911681,0.366698-0.911579806469,0.366732573997",
            "value": 656.973145,
            "unit_code": "MTR",
            "_links": {
              "self": {
                "href": "https://offers.system.trans.eu/api/rest/v1/distances/0.911681,0.366698-0.911579806469,0.366732573997"
              }
            }
          }
        },
        "_links": {
          "self": {
            "href": "https://offers.system.trans.eu/api/rest/v1/loads/396399892"
          },
          "offerer": {
            "id": 950308,
            "href": "https://companies.system.trans.eu/api/rest/v1/employees/950308"
          },
          "company": {
            "id": 91299,
            "href": "https://companies.system.trans.eu/api/rest/v1/companies/91299"
          },
          "contact_persons": {
            "ids": [
              950308
            ],
            "href": "https://companies.system.trans.eu/api/rest/v1/employees?filter={"id":[950308]}"
          },
          "required_truck_body": {
            "id": "jumbo",
            "href": "https://offers.system.trans.eu/api/rest/v1/truck-bodies/jumbo"
          }
        }
      },
    ]
  },
  "page_count": 1,
  "page_size": 20,
  "total_items": 1
}
```

<a class="anchor" name="adding_vehicle_offer"></a>

## 4. Adding vehicle offer ##

* User of a system being integrated with Trans.eu platform (external system) vehicle is not involved in any load transport at this moment,
* user adds an offer of free vehicle in Trans.eu offers exchange,
* person or company interested in that offer contacts user.


#### HTTP Request #####

```http
POST /api/rest/v1/vehicles HTTP/1.1
Accept: application/hal+json
Content-Type: application/hal+json
Authorization: Bearer {access_token}
Host: offers.system.trans.eu

{
  "cargo_space_capacity": {
    "value": 9.65,
    "unit_code": "TNE"
  },
  "loading_place": {
    "address": {
      "country": "PL",
      "locality": "Warszawa",
      "postal_code": "00-125"
    }
  },
  "truck_body": {
    "id": "tent"
  },
  "loading_date": "2015-10-22T14:57:56+00:00",
  "unloading_date" : "2015-10-23T14:59:56+00:00",
  "unloading_place": {
    "address": {
      "country": "PL",
      "locality": "Wrocław",
      "postal_code": "53-307"
    }
  }
}
```

#### Response body: ####

```json
{
  "id": 123456789,
  "creation_date": "2015-10-21T12:08:01 0000",
  "publication_date": null,
  "finish_date": "2015-10-23T14:59:56 0000",
  "loading_place": {
    "address": {
      "country": "PL",
      "postal_code": "00-125",
      "locality": "Warszawa"
    },
    "geo": {
      "latitude": null,
      "longitude": null
    }
  },
  "loading_date": "2015-10-22T14:57:56 0000",
  "unloading_place": {
    "address": {
      "country": "PL",
      "postal_code": "53-307",
      "locality": "Wrocław"
    },
    "address": {
      "country": "PL",
      "postal_code": "53-307",
      "locality": "Wrocław"
    },
    "geo": {
      "latitude": null,
      "longitude": null
    }
  },
  "unloading_date": "2015-10-23T14:59:56 0000",
  "price": null,
  "price_currency": null,
  "description": null,
  "type": "public",
  "cargo_space_capacity": {
    "unit_code": "TNE",
    "value": 9.65
  },
  "cargo_space_length": null,
  "cargo_space_height": null,
  "cargo_space_volume": null,
  "ltl_available": null,
  "has_adr": null,
  "has_lift": null,
  "has_truck_crane": null,
  "has_tir_cable": null,
  "has_tir_carnet": null,
  "has_pallet_bin": null,
  "has_tracking_system": null,
  "available_ways_of_loading": [],
  "_links": {
    "self": {
      "href": "http://offers.dev-trans.rst.com.pl/api/rest/v1/vehicles/GENERATED_ID"
    },
    "company": {
      "id": 10,
      "href": "http://companies.dev-trans.rst.com.pl/api/rest/v1/companies/10"
    },
    "offerer": {
      "id": 1031652,
      "href": "http://companies.dev-trans.rst.com.pl/api/rest/v1/employees/1031652"
    },
    "truck_body": {
      "id": "tent",
      "href": "http://offers.dev-trans.rst.com.pl/api/rest/v1/truck-bodies/tent"
    },
    "contact_persons": {
      "ids": [
        1031652
      ],
      "href": "http://companies.dev-trans.rst.com.pl/api/rest/v1/employees?filter={"id":[1031652]}"
    }
  }
}
```

<a class="anchor" name="search_additional_loading_during_transit"></a>

## 5. Search additional loading during transit ##

* User of a system being integrated with Trans.eu platform (external system) vehicle will perform load transit from Warsaw to Berlin,
* the vehicle has some free loading space left,
* user wants to search for load offers matching available space at points along the vehicles route,
* user receives list of matching load offers.

#### Available filters #####

**URL with circle area (latitude, longitude):** `https://offers.system.trans.eu/api/rest/v1/loads?filter={json_filter}`

* Circle area
```json
{
    "circle_area": {
        "start": {
            "latitude":"52,2296756",
            "longitude":"21,0122287",
            "distance":25000
        },
        "end": {
            "latitude":"52,5234051",
            "longitude":"13,4113999",
            "distance":25000
        }
    }
}
```

#### HTTP Request #####

```http
GET /api/rest/v1/loads?filter={json_filter}
Accept: application/hal+json
Content-Type: application/hal+json
Authorization: Bearer {access_token}
Host: offers.system.trans.eu
```

#### Response body: ####

```json
{
  "_links": {
    "self": {
      "href": "https://offers.system.trans.eu/api/rest/v1/loads?filter={"circle_area":{"start":{"latitude":"52,2296756","longitude":"21,0122287","distance":25000},"end":{"latitude":"52,5234051","longitude":"13,4113999","distance":25000}}}&page=1"
    },
    "first": {
      "href": "https://offers.system.trans.eu/api/rest/v1/loads?filter={"circle_area":{"start":{"latitude":"52,2296756","longitude":"21,0122287","distance":25000},"end":{"latitude":"52,5234051","longitude":"13,4113999","distance":25000}}}"
    },
    "last": {
      "href": "https://offers.system.trans.eu/api/rest/v1/loads?filter={"circle_area":{"start":{"latitude":"52,2296756","longitude":"21,0122287","distance":25000},"end":{"latitude":"52,5234051","longitude":"13,4113999","distance":25000}}}&page=1"
    }
  },
  "_embedded": {
    "loads": [
      {
        "id": 396504956,
        "creation_date": "2015-10-05T11:14:21 0000",
        "publication_date": null,
        "finish_date": "2015-10-06T18:00:00 0000",
        "loading_place": {
          "address": {
            "country": "PL",
            "postal_code": "00-693",
            "locality": "Warszawa"
          },
          "geo": {
            "latitude": 52.2298,
            "longitude": 21.0118
          }
        },
        "loading_date": "2015-10-05T12:00:00 0000",
        "unloading_place": {
          "address": {
            "country": "DE",
            "postal_code": "14050",
            "locality": "Charlottenburg"
          },
          "geo": {
            "latitude": 52.519,
            "longitude": 13.313
          }
        },
        "unloading_date": "2015-10-06T18:00:00 0000",
        "price": 0,
        "price_currency": "PLN",
        "description": "",
        "type": "public",
        "load_length": {
          "value": null,
          "unit_code": null
        },
        "load_height": {
          "value": null,
          "unit_code": null
        },
        "load_volume": {
          "value": null,
          "unit_code": null
        },
        "load_weight": {
          "value": 24,
          "unit_code": "TNE"
        },
        "pallets": null,
        "is_ltl": false,
        "is_lift_required": false,
        "is_truck_crane_required": false,
        "is_tir_cable_required": false,
        "is_tracking_system_required": false,
        "is_for_clearance": false,
        "required_ways_of_loading": null,
        "required_adr_classes": null,
        "_embedded": {
          "start_distance": {
            "id": "0.911581,0.366725-0.911579806469,0.366732573997",
            "value": 32.412907,
            "unit_code": "MTR",
            "_links": {
              "self": {
                "href": "https://offers.system.trans.eu/api/rest/v1/distances/0.911581,0.366725-0.911579806469,0.366732573997"
              }
            }
          },
          "end_distance": {
            "id": "0.916629,0.232356-0.916706353354,0.234073085557",
            "value": 6697.331055,
            "unit_code": "MTR",
            "_links": {
              "self": {
                "href": "https://offers.system.trans.eu/api/rest/v1/distances/0.916629,0.232356-0.916706353354,0.234073085557"
              }
            }
          }
        },
        "_links": {
          "self": {
            "href": "https://offers.system.trans.eu/api/rest/v1/loads/396504956"
          },
          "offerer": {
            "id": 459880,
            "href": "https://companies.system.trans.eu/api/rest/v1/employees/459880"
          },
          "company": {
            "id": 244310,
            "href": "https://companies.system.trans.eu/api/rest/v1/companies/244310"
          },
          "contact_persons": {
            "ids": [
              459880
            ],
            "href": "https://companies.system.trans.eu/api/rest/v1/employees?filter={"id":[459880]}"
          },
          "required_truck_body": {
            "id": "tent",
            "href": "https://offers.system.trans.eu/api/rest/v1/truck-bodies/tent"
          }
        }
      },
      ]
  },
  "page_count": 1,
  "page_size": 20,
  "total_items": 1
}
```

<a class="anchor" name="malfunction_of_vehicle_executing_transit_search_for_vehicle_offers_in_the_area_which_can_replace_it"></a>

## 6. Malfunction of vehicle executing transit. Search for vehicle offers in the area, which can replace it ##
* User of a system being integrated with Trans.eu platform (external system) vehicle executes load transit from Warsaw to Berlin,
* During transit vehicle breaks,
* User wants to search for matching vehicle offer,
* User is able to browse matching vehicle offers details.

#### Available filters #####

**URL with circle area (latitude, longitude):** `https://offers.system.trans.eu/api/rest/v1/vehicles?filter={json_filter}`

* Circle area

```json
{
    "circle_area":{
        "start":{
            "latitude":"52,2296756",
            "longitude":"21,0122287",
            "distance":25000
        },
        "end":{
            "latitude":"52,5234051",
            "longitude":"13,4113999",
            "distance":25000
        }
    }
}
```

#### HTTP Request #####

```http
GET /api/rest/v1/vehicles?filter={json_filter}
Accept: application/hal+json
Content-Type: application/hal+json
Authorization: Bearer {access_token}
Host: offers.system.trans.eu
```

#### Response body: ####

```json
{
  "_links": {
    "self": {
      "href": "https://offers.system.trans.eu/api/rest/v1/vehicles?filter={"circle_area":{"start":{"latitude":"52,2296756","longitude":"21,0122287","distance":25000},"end":{"latitude":"52,5234051","longitude":"13,4113999","distance":25000}}}&page=1"
    },
    "first": {
      "href": "https://offers.system.trans.eu/api/rest/v1/vehicles?filter={"circle_area":{"start":{"latitude":"52,2296756","longitude":"21,0122287","distance":25000},"end":{"latitude":"52,5234051","longitude":"13,4113999","distance":25000}}}"
    },
    "last": {
      "href": "https://offers.system.trans.eu/api/rest/v1/vehicles?filter={"circle_area":{"start":{"latitude":"52,2296756","longitude":"21,0122287","distance":25000},"end":{"latitude":"52,5234051","longitude":"13,4113999","distance":25000}}}&page=1"
    }
  },
  "_embedded": {
    "vehicles": [
      {
        "id": 396045311,
        "creation_date": "2015-10-02T12:12:08 0000",
        "publication_date": null,
        "finish_date": "2015-10-05T19:00:00 0000",
        "loading_place": {
          "address": {
            "country": "PL",
            "postal_code": "00-001",
            "locality": "Warszawa"
          },
          "geo": {
            "latitude": 52.2445,
            "longitude": 21.0291
          }
        },
        "loading_date": "2015-10-03T13:00:00 0000",
        "unloading_place": {
          "address": {
            "country": "DE",
            "postal_code": "12043",
            "locality": "Berlin"
          },
          "geo": {
            "latitude": 52.4763,
            "longitude": 13.4458
          }
        },
        "unloading_date": "2015-10-05T19:00:00 0000",
        "price": 0,
        "price_currency": "PLN",
        "description": "",
        "type": "public",
        "cargo_space_capacity": {
          "value": 24,
          "unit_code": "TNE"
        },
        "cargo_space_length": {
          "value": null,
          "unit_code": null
        },
        "cargo_space_height": {
          "value": null,
          "unit_code": null
        },
        "cargo_space_volume": {
          "value": null,
          "unit_code": null
        },
        "ltl_available": false,
        "has_adr": true,
        "has_lift": false,
        "has_truck_crane": false,
        "has_tir_cable": false,
        "has_tir_carnet": false,
        "has_pallet_bin": false,
        "has_tracking_system": false,
        "available_ways_of_loading": null,
        "_embedded": {
          "start_distance": {
            "id": "0.911839,0.367027-0.911579806469,0.366732573997",
            "value": 2012.332764,
            "unit_code": "MTR",
            "_links": {
              "self": {
                "href": "https://offers.system.trans.eu/api/rest/v1/distances/0.911839,0.367027-0.911579806469,0.366732573997"
              }
            }
          },
          "end_distance": {
            "id": "0.915884,0.234673-0.916706353354,0.234073085557",
            "value": 5738.689453,
            "unit_code": "MTR",
            "_links": {
              "self": {
                "href": "https://offers.system.trans.eu/api/rest/v1/distances/0.915884,0.234673-0.916706353354,0.234073085557"
              }
            }
          }
        },
        "_links": {
          "self": {
            "href": "https://offers.system.trans.eu/api/rest/v1/vehicles/396045311"
          },
          "offerer": {
            "id": 402308,
            "href": "https://companies.system.trans.eu/api/rest/v1/employees/402308"
          },
          "company": {
            "id": 228588,
            "href": "https://companies.system.trans.eu/api/rest/v1/companies/228588"
          },
          "contact_persons": {
            "ids": [
              402308
            ],
            "href": "https://companies.system.trans.eu/api/rest/v1/employees?filter={"id":[402308]}"
          },
          "truck_body": {
            "id": "tent",
            "href": "https://offers.system.trans.eu/api/rest/v1/truck-bodies/tent"
          }
        }
      },
      ...
    ]
  },
  "page_count": 1,
  "page_size": 20,
  "total_items": 3
}
```

<a class="anchor" name="additional_transport_offer_on_route"></a>

## 7. Additional transport offer on route
 - User of a system being integrated with Trans.eu platform (external system) has a vehicle executing transport, but not all cargo space is used,
 - User adds single vehicle offer as a number of vehicle offers in Trans.eu platform with different cities placed on route to fill available cargo space,
 - Person or company interested in vehicle offer contacts user using contact data provided,
 - Each of load offers is deleted from Trans.eu platform by external system.

###Offer 1### 
#### HTTP Request #####
```http
POST /api/rest/v1/vehicles HTTP/1.1
Content-Type: application/hal+json
Accept: application/hal+json
Authorization: Bearer {access_token}
Host: offers.system.trans.eu

{
  "loading_place": {
    "address": {
      "country": "PL",
      "postal_code": "80-858",
      "locality": "Gdańsk"
    },
  },
  "loading_date": "2016-03-07T07:00:00+0000",
  "unloading_place": {
    "address": {
      "country": "PL",
      "postal_code": "02-495",
      "locality": "Warszawa"
    },
  },
  "unloading_date": "2016-03-09T07:00:00+0000",
...
}
```

#### HTTP Response ##### 

```http
HTTP/1.1 201 Created
Content-Type: application/hal+json

{
  "id": 123456789,
...
}
```

###Offer 2###
#### HTTP Request #####

```http
POST /api/rest/v1/vehicles HTTP/1.1
Content-Type: application/hal+json
Accept: application/hal+json
Authorization: Bearer {access_token}
Host: offers.system.trans.eu

{
  "loading_place": {
    "address": {
      "country": "PL",
      "postal_code": "83-322",
      "locality": "Malbork"
    },
  },
  "loading_date": "2016-03-07T07:00:00+0000",
  "unloading_place": {
    "address": {
      "country": "PL",
      "postal_code": "02-495",
      "locality": "Warszawa"
    },
  },
  "unloading_date": "2016-03-09T07:00:00+0000",
...
}
```

#### HTTP Response ##### 

```http
HTTP/1.1 201 Created
Content-Type: application/hal+json

{
  "id": 123456790,
...
}
```

###Offer 3###
#### HTTP Request #####

```http
POST /api/rest/v1/vehicles HTTP/1.1
Content-Type: application/hal+json
Accept: application/hal+json
Authorization: Bearer {access_token}
Host: offers.system.trans.eu

{
  "loading_place": {
    "address": {
      "country": "PL",
      "postal_code": "06-500",
      "locality": "Mława"
    },
  },
  "loading_date": "2016-03-07T07:00:00+0000",
  "unloading_place": {
    "address": {
      "country": "PL",
      "postal_code": "02-495",
      "locality": "Warszawa"
    },
  },
  "unloading_date": "2016-03-09T07:00:00+0000",
...
}
```

#### HTTP Response ##### 

```HTTP
HTTP/1.1 201 Created
Content-Type: application/hal+json

{
  "id": 123456791,
...
}
```

<a class="anchor" name="finding_specific_vehicle_offer_type"></a>

## 8. Finding specific vehicle offer type
 - User of a system being integrated with Trans.eu platform (external system) receives a contract to transport a hazardous load, but doesn't have contact with proper transport company or doesn't have any vehicle available with ADR license,
 - User adds the load offer in Trans.eu based on existing offer in external system,
 - Person or company interested in transport execution contacts user,
 - When offer is accepted, it is removed from Trans.eu platform by external system.
 
#### HTTP Request #####

```http
POST /api/rest/v1/loads HTTP/1.1
Content-Type: application/hal+json
Accept: application/hal+json
Authorization: Bearer {access_token}
Host: offers.system.trans.eu

{
  "required_adr_classes": [ "1", "4.3", "5.2" ],
...
}
```

#### HTTP Response ##### 

```HTTP
HTTP/1.1 201 Created
Content-Type: application/hal+json

{
  "id": 123456791,
...
}
```

<a class="anchor" name="several_different_types_of_truck_body"></a>

## 9. Several different types of truck body
 - User of a system being integrated with Trans.eu platform (external system) wants to offer an available vehicle with 'mega' body,
 - External system posts several vehicle offers with different truck body types corresponding to 'mega' body type ('curtainsider', 'tent' and 'colimulde')
 - Person or company interested in using given vehicle contacts user,
 - When offer is accepted, all vehicle offers are removed by external system.

###Offer 1###
#### HTTP Request #####

```http
POST /api/rest/v1/loads HTTP/1.1
Content-Type: application/hal+json
Accept: application/hal+json
Authorization: Bearer {access_token}
Host: offers.system.trans.eu

{
 "required_truck_body" : {
    "id": "curtainsider"
  },
...
}
```

#### HTTP Response #### 

```HTTP
HTTP/1.1 201 Created
Content-Type: application/hal+json

{
  "id": 123456791,
...
}
```

###Offer 2###
#### HTTP Request #####

```http
POST /api/rest/v1/loads HTTP/1.1
Content-Type: application/hal+json
Accept: application/hal+json
Authorization: Bearer {access_token}
Host: offers.system.trans.eu

{
 "required_truck_body" : {
    "id": "tent"
  },
...
}
```

#### HTTP Response ####

```HTTP
HTTP/1.1 201 Created
Content-Type: application/hal+json

{
  "id": 123456791,
...
}
```

###Offer 3###
#### HTTP Request #####

```http
POST /api/rest/v1/loads HTTP/1.1
Content-Type: application/hal+json
Accept: application/hal+json
Authorization: Bearer {access_token}
Host: offers.system.trans.eu

{
 "required_truck_body" : {
    "id": "coilmulde"
  },
...
}
```

#### HTTP Response #### 

```HTTP
HTTP/1.1 201 Created
Content-Type: application/hal+json

{
  "id": 123456791,
...
}
```

<a class="anchor" name="adding_load_offer_within_cluster"></a>

## 10. Adding load offers within cluster
 - User of a system being integrated with Trans.eu platform (external system) wants wants to offer load for transporting to trusted company,
 - User is a employee of company being a member of transport cluster in Trans.eu System
 - Load transport offer is added within cluster
 - Person or company belonging to the same cluster as offer was added is able to contact user using contact data provided.
 
#### HTTP Request ####

```http
POST /api/rest/v1/loads HTTP/1.1
Content-Type: application/hal+json
Accept: application/hal+json
Authorization: Bearer {access_token}
Host: offers.system.trans.eu

{
  "load_weight": {
    "value":12.00,
    "unit_code": "TNE"
  },
  "loading_place": {
    "address": {
      "country": "PL",
      "locality": "Warszawa",
      "postal_code": "00-125"
    }
  },
  "required_truck_body": {
    "id": "tent"
  },
  "loading_date": "2015-10-22T14:57:56+00:00",
  "unloading_date" : "2015-10-23T14:59:56+00:00",
  "unloading_place": {
    "address": {
      "country": "PL",
      "locality": "Wrocław",
      "postal_code": "53-307"
    }
  },
  "type": "cluster",
    "clusters" : [
      { "id": 10192}
    ]
}
```


#### HTTP Response #### 

```HTTP
HTTP/1.1 201 Created
Content-Type: application/hal+json

{
  "id": 123456791,
...
}
```