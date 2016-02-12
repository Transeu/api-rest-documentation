---
title: Offers Api Endpoints Reference
is_specification: true
side_menu:
  - title: Companies Api Endpoints Reference
    url: /api-specification/companies-api-endpoints-reference/
  - title: Offers Api Endpoints Reference
    url: /api-specification/offers-api-endpoints-reference/
    active: true
---

---

**Version:** 1

**Base URL:** `https://offers.system.trans.eu/api/rest/v1`

## Resources

### Loads

**Important:** This resource contain only active load offers.

#### Get load offers

**Scopes**:

* offers.loads.manage

**Endpoint**
```
GET /loads
```

**Query parameters**

| Query parameter | Type | Required | Value |
|---|---|---|---|
| filter | json | no | Filter Load entities |
| sort | json | no | Sort Load entities |
| page | integer | no | Result page number |

**Filter parameters**

| Field| Type | Required |
|---|---|---|---|
| loading_place.address.country | string or array | yes, if we filter also on *loading_place.address.postal_code* or *loading_place.address.locality* |
| loading_place.address.postal_code | string | no |
| loading_place.address.locality | string | no |
| unloading_place.address.country | string or array | yes, if we filter also on *unloading_place.address.postal_code* or *unloading_place.address.locality* |
| unloading_place.address.postal_code | string | no |
| unloading_place.address.locality | string | no |
| description | string | no |
| type | string or array | no |
| price | range of floats | yes, if we filter also on *price_currency*  |
| price_currency | string | no |
| required_truck_body.id | string | no |
| circle_area.start.latitude | float | yes, if we filter also on *circle_area.start.longitude* and *circle_area.start.distance* |
| circle_area.start.longitude | float | yes, if we filter also on *circle_area.start.latitude* and *circle_area.start.distance* |
| circle_area.start.distance | integer | yes, if we filter also on *circle_area.start.latitude* and *circle_area.start.longitude* |
| circle_area.end.latitude | float | yes, if we filter also on *circle_area.end.longitude* and *circle_area.end.distance* |
| circle_area.end.longitude | float | yes, if we filter also on *circle_area.end.latitude* and *circle_area.end.distance* |
| circle_area.end.distance | integer | yes, if we filter also on *circle_area.end.latitude* and *circle_area.end.longitude* |
| creation_date | range of timestamps | no |
| loading_date | range of timestamps | no |
| load_weight (deprecated) | range of floats | no |
| load_weight.value | range of floats | no |
| load_length (deprecated) | range of floats | no |
| load_length.value | range of floats | no |

**Sort parameters**

| Field | Type | Required |
|---|---|---|---|
| loading_place.address.country | string or array | no |
| loading_place.address.locality | string | no |
| unloading_place.address.country | string or array | no |
| unloading_place.address.locality | string | no |
| creation_date | int | no |

**Response**

| Http status | Description |
|---|---|
| 200 | Return collection of Load entities. |

**Example**

```http
GET /api/rest/v1/loads?filter={"type":{"$in":["public"]},"price":{"$gt":1,"$lt":100},"price_currency":"EUR"}&sort={"loading_place.address.country":-1}}}&page=5 HTTP/1.1
Host: offers.system.trans.eu
Accept: application/hal+json
Authorization: Bearer {access_token}
```
```http
HTTP/1.1 200 OK
Content-Type: application/hal+json

{
  "_links": {
    "self": {
      "href": "https://offers.system.trans.eu/api/rest/v1/loads?filter=%7B%22type%22:%20%7B%22$in%22:%20%5B%22public%22%5D%7D,%20%22price%22:%7B%22$gt%22:1,%22$lt%22:100%7D,%22price_currency%22:%22EUR%22%7D&sort=%7B%22loading_place.address.country%22:-1%7D%7D%7D&page=5"
    },
    "first": {
      "href": "https://offers.system.trans.eu/api/rest/v1/loads?filter=%7B%22type%22:%20%7B%22$in%22:%20%5B%22public%22%5D%7D,%20%22price%22:%7B%22$gt%22:1,%22$lt%22:100%7D,%22price_currency%22:%22EUR%22%7D&sort=%7B%22loading_place.address.country%22:-1%7D%7D%7D"
    },
    "last": {
      "href": "https://offers.system.trans.eu/api/rest/v1/loads?filter=%7B%22type%22:%20%7B%22$in%22:%20%5B%22public%22%5D%7D,%20%22price%22:%7B%22$gt%22:1,%22$lt%22:100%7D,%22price_currency%22:%22EUR%22%7D&sort=%7B%22loading_place.address.country%22:-1%7D%7D%7D&page=18"
    },
    "prev": {
      "href": "https://offers.system.trans.eu/api/rest/v1/loads?filter=%7B%22type%22:%20%7B%22$in%22:%20%5B%22public%22%5D%7D,%20%22price%22:%7B%22$gt%22:1,%22$lt%22:100%7D,%22price_currency%22:%22EUR%22%7D&sort=%7B%22loading_place.address.country%22:-1%7D%7D%7D&page=4"
    },
    "next": {
      "href": "https://offers.system.trans.eu/api/rest/v1/loads?filter=%7B%22type%22:%20%7B%22$in%22:%20%5B%22public%22%5D%7D,%20%22price%22:%7B%22$gt%22:1,%22$lt%22:100%7D,%22price_currency%22:%22EUR%22%7D&sort=%7B%22loading_place.address.country%22:-1%7D%7D%7D&page=6"
    }
  },
  "_embedded": {
    "loads": [
      ...
    ]
  },
  "page_count": 172,
  "page_size": 20,
  "total_items": 3423
}
```

#### Get a load offer

**Scopes**:

* offers.loads.manage

**Endpoint**
```
GET /loads/{id}
```

**Query parameters**

| Query parameter | Type | Required | Value |
|---|---|---|---|
| fields | json | no | List of Load entity fields to include or exclude in response |

**Response**

| Http status | Description |
|---|---|
| 200 | Return Load entity |
| 404 | Load offer not found |

**Example**

```http
GET /api/rest/v1/loads/123456789?fields={"description":false} HTTP/1.1
Host: offers.system.trans.eu
Accept: application/hal+json
Authorization: Bearer {access_token}
```
```http
HTTP/1.1 200 OK
Content-Type: application/hal+json

{
  "id": 123456789,
  "creation_date": "2015-09-21T06:58:49+0000",
  "publication_date": null,
  "finish_date": "2015-10-14T08:00:00+0000",
  "loading_place": {
    "address": {
      "country": "BY",
      "postal_code": "224001",
      "locality": "Брест"
    },
    "geo": {
      "latitude": 52.105,
      "longitude": 23.6751
    }
  },
  "loading_date": "2015-09-30T08:00:00+0000",
  "unloading_place": {
    "address": {
      "country": "DE",
      "postal_code": "79098",
      "locality": "Фрайбург"
    },
    "geo": {
      "latitude": 47.9959,
      "longitude": 7.8522
    }
  },
  "unloading_date": "2015-10-14T08:00:00+0000",
  "price": 10,
  "price_currency": "EUR",
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
    "value": 100,
    "unit_code": "MTQ"
  },
  "load_weight": {
    "value": 21,
    "unit_code": "TNE"
  },
  "pallets": null,
  "is_ltl": false,
  "is_lift_required": false,
  "is_truck_crane_required": false,
  "is_tir_cable_required": true,
  "is_tracking_system_required": false,
  "is_for_clearance": false,
  "required_ways_of_loading": null,
  "required_adr_classes": null,
  "_links": {
    "self": {
      "href": "https://offers.system.trans.eu/api/rest/v1/loads/390869606"
    },
    "offerer": {
      "id": 1128668,
      "href": "https://companies.system.trans.eu/api/rest/v1/employees/1128668"
    },
    "company": {
      "id": 341134,
      "href": "https://companies.system.trans.eu/api/rest/v1/companies/341134"
    },
    "contact_persons": {
      "ids": [
        1128668
      ],
      "href": "https://companies.system.trans.eu/api/rest/v1/employees?filter=%7B%22id%22:%5B1128668%5D%7D"
    },
    "required_truck_body": {
      "id": "tent",
      "href": "https://offers.system.trans.eu/api/rest/v1/truck-bodies/tent"
    },
    "type_of_load": {
      "id": "roll2",
      "href": "https://offers.system.trans.eu/api/rest/v1/load-types/roll2"
    }
  }
}
```

#### Add a load offer

**Scopes**:

* offers.loads.manage

**Endpoint**
```
POST /loads
```

**Request body data**

| Field | Required |
|---|---|
| loading_place.address.country | yes |
| loading_place.address.postal_code | yes |
| loading_place.address.locality | no |
| loading_place.geo.latitude | yes, if we also add *loading_place.geo.longitude* |
| loading_place.geo.longitude | yes, if we also add *loading_place.geo.latitude* |
| loading_date | yes |
| unloading_place.address.country | yes |
| unloading_place.address.postal_code | yes |
| unloading_place.address.locality | no |
| unloading_place.geo.latitude | yes, if we also add *unloading_place.geo.longitude* |
| unloading_place.geo.longitude | yes, if we also add *unloading_place.geo.latitude* |
| unloading_date | yes |
| price | yes, if we also add *price_currency* |
| price_currency | yes, if we also add *price* |
| description | no |
| type | no, default: `public`
| load_length.value | if we also add *load_length.unit_code* |
| load_length.unit_code | if we also add *load_length.unit_code* |
| load_height.value | if we also add *load_height.unit_code* |
| load_height.unit_code | if we also add *load_height.unit_code* |
| load_volume.value | yes, if we also add *load_volume.unit_code* |
| load_volume.unit_code | yes, if we also add *load_volume.value* |
| load_weight.value | yes |
| load_weight.unit_code | yes |
| pallets.type | no |
| pallets.dimensions | no |
| pallets.amount | no |
| pallets.is_stackable | no |
| pallets.is_exchangeable | no |
| is_ltl | no |
| is_lift_required | no |
| is_truck_crane_required | no |
| is_tir_cable_required | no |
| is_tracking_system_required | no |
| is_for_clearance | no |
| required_ways_of_loading | no |
| required_adr_classes | no |
| contact_persons | no |
| required_truck_body.id | yes |
| type_of_load | no |

**Response**

| Http status | Description |
|---|---|
| 201 | Load offer has been created. Return Load entity. |

**Example**

```http
POST /api/rest/v1/loads HTTP/1.1
Host: offers.system.trans.eu
Accept: application/hal+json
Content-Type: application/json
Authorization: Bearer {access_token}

{
  "loading_place": {
    "address": {
      "country": "RU",
      "postal_code": "4531",
      "locality": "Sterlitamak"
    },
    "geo": {
      "latitude": 53.6246,
      "longitude": 55.9502
    }
  },
  "loading_date": "2015-10-07T07:00:00+0000",
  "unloading_place": {
    "address": {
      "country": "PL",
      "postal_code": "41-303",
      "locality": "Dąbrowa Górnicza - Gołonóg"
    },
    "geo": {
      "latitude": 50.3455,
      "longitude": 19.2518
    }
  },
  "unloading_date": "2015-10-12T13:00:00+0000",
  "price": 10,
  "price_currency": "EUR",
  "description": "Super oferta",
  "load_length": {
      "value": 5,
      "unit_code": "MTR"
  },
  "load_height": {
    "value": 10,
    "unit_code": "MTR"
  },
  "load_volume": {
    "value": 45,
    "unit_code": "MTQ"
  },
  "load_weight": {
    "value": 21,
    "unit_code": "TNE"
  },
  "is_ltl": false,
  "is_lift_required": false,
  "is_truck_crane_required": false,
  "is_tir_cable_required": true,
  "is_tracking_system_required": true,
  "is_for_clearance": false,
  "required_ways_of_loading": ["top", "back"],
  "required_adr_classes": ["1", "4.3", "5.2"],
  "contact_persons" : [
     {
        "id": 12345
     },
     {
        "id": 12346
     }
  ],
  "required_truck_body" : {
    "id": "box-truck"
  },
  "type_of_load": {
    "id": "package"
  }
}
```
```http
HTTP/1.1 201 Created
Content-Type: application/hal+json

{
  "id": 123456789,
  ...
}
```

#### Remove a load offer

**Scopes**:

* offers.loads.manage

**Endpoint**
```
DELETE /loads/{id}
```

**Response**

| Http status | Description |
|---|---|
| 204 | Load offer has been successfully removed. |
| 400 | You can only delete your load offers. |
| 404 | Load offer not found. |

**Example**

```http
DELETE /api/rest/v1/loads/123456789 HTTP/1.1
Host: offers.system.trans.eu
Authorization: Bearer {access_token}
```
```http
HTTP/1.1 204 No Content
```

### Vehicles

#### Get vehicle offers

**Scopes**:

* offers.vehicles.manage

**Endpoint**
```
GET /vehicles
```

**Query parameters**

| Query parameter | Type | Required | Value |
|---|---|---|---|
| filter | json | no | Filter Vehicle entities |
| sort | json | no | Sort Vehicle entities |
| page | integer | no | Result page number |

**Filter parameters**

| Field| Type | Required |
|---|---|---|
| loading_place.address.country | string or array | yes, if we filter also on *loading_place.address.postal_code* or *loading_place.address.locality* |
| loading_place.address.postal_code | string | no |
| loading_place.address.locality | string | no |
| unloading_place.address.country | string or array | yes, if we filter also on *unloading_place.address.postal_code* or *unloading_place.address.locality* |
| unloading_place.address.postal_code | string | no |
| unloading_place.address.locality | string | no |
| description | string | no |
| type | string or array | no |
| price | range of floats | yes, if we filter also on *price_currency*  |
| price_currency | string | no |
| required_truck_body.id | string | no |
| circle_area.start.latitude | float | yes, if we filter also on *circle_area.start.longitude* and *circle_area.start.distance* |
| circle_area.start.longitude | float | yes, if we filter also on *circle_area.start.latitude* and *circle_area.start.distance* |
| circle_area.start.distance | integer | yes, if we filter also on *circle_area.start.latitude* and *circle_area.start.longitude* |
| circle_area.end.latitude | float | yes, if we filter also on *circle_area.end.longitude* and *circle_area.end.distance* |
| circle_area.end.longitude | float | yes, if we filter also on *circle_area.end.latitude* and *circle_area.end.distance* |
| circle_area.end.distance | integer | yes, if we filter also on *circle_area.end.latitude* and *circle_area.end.longitude* |
| creation_date | range of timestamps | no |
| loading_date | range of timestamps | no |
| cargo_space_capacity (deprecated) | range of integers | no |
| cargo_space_capacity.value | range of integers | no |
| cargo_space_length (deprecated) | length range | no |
| cargo_space_length.value | length range | no |

**Sort parameters**

| Field | Type | Required |
|---|---|---|---|
| loading_place.address.country | string or array | no |
| loading_place.address.locality | string | no |
| unloading_place.address.country | string or array | no |
| unloading_place.address.locality | string | no |
| creation_date | int | no |

**Response**

| Http status | Description |
|---|---|
| 200 | Return collection of Vehicle entities. |

**Example**

```http
GET /api/rest/v1/vehicles/api/rest/v1/vehicles?filter={"type":{"$in":["public"]},"price":{"$gt":1,"$lt":100},"price_currency":"EUR","cargo_space_length":{"$gt":1,"$lt":100}}&sort={"loading_place.address.country":-1}}}&page=5 HTTP/1.1
Host: offers.system.trans.eu
Accept: application/hal+json
Authorization: Bearer {access_token}
```
```http
{
  "_links": {
    "self": {
      "href": "https://offers.system.trans.eu/api/rest/v1/vehicles?filter=%7B%22type%22:%20%7B%22$in%22:%20%5B%22public%22%5D%7D,%20%22price%22:%7B%22$gt%22:1,%22$lt%22:100%7D,%22price_currency%22:%22EUR%22,%22cargo_space_length%22:%7B%22$gt%22:1,%22$lt%22:100%7D%7D&sort=%7B%22loading_place.address.country%22:-1%7D%7D%7D&page=5"
    },
    "first": {
      "href": "https://offers.system.trans.eu/api/rest/v1/vehicles?filter=%7B%22type%22:%20%7B%22$in%22:%20%5B%22public%22%5D%7D,%20%22price%22:%7B%22$gt%22:1,%22$lt%22:100%7D,%22price_currency%22:%22EUR%22,%22cargo_space_length%22:%7B%22$gt%22:1,%22$lt%22:100%7D%7D&sort=%7B%22loading_place.address.country%22:-1%7D%7D%7D"
    },
    "last": {
      "href": "https://offers.system.trans.eu/api/rest/v1/vehicles?filter=%7B%22type%22:%20%7B%22$in%22:%20%5B%22public%22%5D%7D,%20%22price%22:%7B%22$gt%22:1,%22$lt%22:100%7D,%22price_currency%22:%22EUR%22,%22cargo_space_length%22:%7B%22$gt%22:1,%22$lt%22:100%7D%7D&sort=%7B%22loading_place.address.country%22:-1%7D%7D%7D&page=90"
    },
    "prev": {
      "href": "https://offers.system.trans.eu/api/rest/v1/vehicles?filter=%7B%22type%22:%20%7B%22$in%22:%20%5B%22public%22%5D%7D,%20%22price%22:%7B%22$gt%22:1,%22$lt%22:100%7D,%22price_currency%22:%22EUR%22,%22cargo_space_length%22:%7B%22$gt%22:1,%22$lt%22:100%7D%7D&sort=%7B%22loading_place.address.country%22:-1%7D%7D%7D&page=4"
    },
    "next": {
      "href": "https://offers.system.trans.eu/api/rest/v1/vehicles?filter=%7B%22type%22:%20%7B%22$in%22:%20%5B%22public%22%5D%7D,%20%22price%22:%7B%22$gt%22:1,%22$lt%22:100%7D,%22price_currency%22:%22EUR%22,%22cargo_space_length%22:%7B%22$gt%22:1,%22$lt%22:100%7D%7D&sort=%7B%22loading_place.address.country%22:-1%7D%7D%7D&page=6"
    }
  },
  "_embedded": {
    "vehicles": [
      ...
      ]
    },
    "page_count": 90,
    "page_size": 20,
    "total_items": 1796
  }
```

#### Get a vehicle offer

**Scopes**:

* offers.vehicles.manage

**Endpoint**
```
GET /vehicles/{id}
```

**Query parameters**

| Query parameter | Type | Required | Value |
|---|---|---|---|
| fields | json | no | Array  | List of Loads entity fields to include or exclude in response |

**Response**

| Http status | Description |
|---|---|
| 200 | Return Vehicle entity |
| 404 | Vehicle not found |

**Example**
```http
GET /api/rest/v1/vehicles/397936884?fields={"loading_place":false,"unloading_place.address.locality":false} HTTP/1.1
Host: offers.system.trans.eu
Accept: application/hal+json
Authorization: Bearer {access_token}
```
```http
HTTP/1.1 200 OK
Content-Type: application/hal+json

{
  "id": 397936884,
  "creation_date": "2015-10-08T09:52:18+0000",
  "publication_date": null,
  "finish_date": "2015-10-16T16:00:00+0000",
  "loading_date": "2015-10-12T04:00:00+0000",
  "unloading_place": {
    "address": {
      "country": "PL",
      "postal_code": "All"
    },
    "geo": {
      "latitude": null,
      "longitude": null
    }
  },
  "unloading_date": "2015-10-16T16:00:00+0000",
  "price": 1,
  "price_currency": "EUR",
  "description": "",
  "type": "public",
  "cargo_space_capacity": {
    "value": 24,
    "unit_code": "TNE"
  },
  "cargo_space_length": {
    "value": 13.6,
    "unit_code": "MTR"
  },
  "cargo_space_height": {
    "value": 3,
    "unit_code": "MTR"
  },
  "cargo_space_volume": {
    "value": null,
    "unit_code": null
  },
  "ltl_available": false,
  "has_adr": false,
  "has_lift": false,
  "has_truck_crane": false,
  "has_tir_cable": false,
  "has_tir_carnet": false,
  "has_pallet_bin": false,
  "has_tracking_system": true,
  "available_ways_of_loading": [
    "side",
    "top",
    "back"
  ],
  "_links": {
    "self": {
      "href": "https://offers.system.trans.eu/api/rest/v1/vehicles/397936884"
    },
    "offerer": {
      "id": 726481,
      "href": "https://companies.system.trans.eu/api/rest/v1/employees/726481"
    },
    "company": {
      "id": 324731,
      "href": "https://companies.system.trans.eu/api/rest/v1/companies/324731"
    },
    "contact_persons": {
      "ids": [
        726481
      ],
      "href": "https://companies.system.trans.eu/api/rest/v1/employees?filter=%7B%22id%22:%5B726481%5D%7D"
    },
    "truck_body": {
      "id": "curtainsider",
      "href": "https://offers.system.trans.eu/api/rest/v1/truck-bodies/curtainsider"
    }
  }
}
```

#### Add a vehicle offer

**Scopes**:

* offers.vehicles.manage

**Endpoint**
```
POST /vehicles
```

**Request body data**

| Field | Required |
|---|---|
| loading_place.address.country | yes |
| loading_place.address.postal_code | yes |
| loading_place.address.locality | no |
| loading_place.geo.latitude | yes, if we also add *loading_place.geo.longitude* |
| loading_place.geo.longitude | yes, if we also add *loading_place.geo.latitude* |
| loading_date | yes |
| unloading_place.address.country | yes |
| unloading_place.address.postal_code | yes |
| unloading_place.address.locality | no |
| unloading_place.geo.latitude | yes, if we also add *unloading_place.geo.longitude* |
| unloading_place.geo.longitude | yes, if we also add *unloading_place.geo.latitude* |
| unloading_date | yes |
| price | yes, if we also add *price_currency* |
| price_currency | yes, if we also add *price* |
| description | no |
| type | no, default: `public`
| cargo_space_capacity.value | yes |
| cargo_space_capacity.unit_code | yes |
| cargo_space_length.value | no  |
| cargo_space_length.unit_code | no |
| cargo_space_height.value | no |
| cargo_space_height.unit_code | no |
| cargo_space_volume.value | no |
| cargo_space_volume.unit_code | no |
| ltl_available | no |
| has_adr | no |
| has_lift | no |
| has_truck_crane | no |
| has_tir_cable | no |
| has_tir_carnet | no |
| has_pallet_bin | no |
| has_tracking_system | no |
| available_ways_of_loading | no |

**Response**

| Http status | Description |
|---|---|
| 201 | Vehicle offer has been created. Return Vehicle entity. |

**Example**
```http
POST /api/rest/v1/vehicles HTTP/1.1
Host: offers.system.trans.eu
Accept: application/hal+json
Content-Type: application/json
Authorization: Bearer {access_token}

{
  "loading_date": "2015-10-15T15:12:24+0000",
  "loading_place": {
      "address": {
          "country": "GB",
          "postal_code": "12345",
          "locality": "London"
      },
      "geo": {
          "latitude": 12.134,
          "longitude": 12.134
      }
  },
  "unloading_date": "2015-10-17T15:12:24+0000",
  "unloading_place": {
      "address": {
          "country": "PL",
          "postal_code": "50-340",
          "locality": "Warszawa"
      },
      "geo": {
          "latitude": 12.134,
          "longitude": 12.134
      }
  },
  "truck_body": {
      "id": "swap-body-system"
  },
  "description": "Important note: do not travel faster than a speed of light!",
  "cargo_space_capacity": {
      "value": 10,
      "unit_code": "TNE"
  },
  "cargo_space_length": {
      "value": 10,
      "unit_code": "MTR"
  },
  "cargo_space_height": {
      "value": 10,
      "unit_code": "MTR"
  },
  "cargo_space_volume": {
      "value": 10,
      "unit_code": "MTQ"
  },
  "ltl_available": true,
  "has_adr": false,
  "has_lift": false,
  "has_truck_crane": false,
  "has_tir_cable": false,
  "has_tir_carnet": false,
  "has_pallet_bin": false,
  "has_tracking_system": false,
  "available_ways_of_loading": ["top","side"]
}
```
```http
HTTP/1.1 201 Created
Content-Type: application/hal+json

{
  "id": 123456789,
  ...
}
```

#### Remove a vehicle offer

**Scopes**:

* offers.vehicles.manage

**Endpoint**
```
DELETE /vehicles/{id}
```

**Response**

| Http status | Description |
|---|---|
| 204 | Vehicle offer has been successfully removed. |
| 400 | You can only delete your vehicle offers. |
| 404 | Vehicle offer not found. |

**Example**

```http
DELETE /api/rest/v1/vehicles/123456789 HTTP/1.1
Host: offers.system.trans.eu
Authorization: Bearer {access_token}
```
```http
HTTP/1.1 204 No Content
```
## Enities

### Load entity

| Field | Value Type | Value Description |
|---|---|---|
| id | integer  | Unique identifier for a load offer. |
| creation_date | string | Date and time (ISO 8601) of load offer creation. |
| publication_date | string | Date and time (ISO 8601) when load offer will be published. |
| finish_date | string | Date and time (ISO 8601) when load offer will be finished. |
| loading_place.address.country | string | The loading place country code (ISO 3166-1 alpha-2). |
| loading_place.address.postal_code | string | Loading place postal code. Valid value should have min 1 and max 7 length and match `/^[\p{L}0-9][\p{L}0-9 .-]*$/`.  |
| loading_place.address.locality | string | Loading place locality. Valid value should have min 2 and max 40 length and match ```/^[\p{L}£\(\)\'][\p{L}0-9 .&`,:\(\)\/\'-£]*$/u```. |
| loading_place.geo.latitude | float | Loading place latitude coordinate in degrees. |
| loading_place.geo.longitude | float | Loading place longitude coordinate in degrees.  |
| loading_date | string | Date and time (ISO 8601) when load offer must be loaded. |
| unloading_place.address.country | string | The unloading place country code (ISO 3166-1 alpha-2). |
| unloading_place.address.postal_code | string | Unloading place postal code. Valid value should have min 1 and max 7 length and match `/^[\p{L}0-9][\p{L}0-9 .-]*$/`. |
| unloading_place.address.locality | string | Unloading place locality. Valid value should have min 2 and max 40 length and match ```/^[\p{L}£\(\)\'][\p{L}0-9 .&`,:\(\)\/\'-£]*$/u```. |
| unloading_place.geo.latitude | float | Unloading place latitude coordinate in degrees. |
| unloading_place.geo.longitude | float | Unloading place longitude coordinate in degrees. |
| unloading_date | string | Date and time (ISO 8601) when load offer must be unloaded. |
| price | float | Load offer price. Valid value should be between 0 and 999999.99.  |
| price_currency | string | Load offer price currency (ISO 4217). |
| description | string | Load offer description. Valid value should have min 1 and max 200 length. |
| type | string | Load offer visibility:  `public`, `cluster`, `private` |
| load_length.value | float | Length of load. Valid value should be between 0.01 and 999.99.  |
| load_length.unit_code | string | Load length measure unit. Only valid value is `MTR` (metre). |
| load_height.value | float | Height of load. Valid value should be between 0.01 and 999.99. |
| load_height.unit_code | string | Load height measure unit. Only valid value is `MTR` (metre). |
| load_volume.value | float | Volume of load. Valid value should be between 0.01 and 99999.99. |
| load_volume.unit_code | string | Load volume measure unit. Only valid value is `MTQ` (cubic metre).  |
| load_weight.value | float | Weight of load. Valid value should be between 0.01 and 999.99. |
| load_weight.unit_code | string | Load weight measure unit. Only valid value is `TNE` (metric tons).  |
| pallets.type | string | Type of pallets. Either `euro` or `other`. |
| pallets.dimensions | string | Dimensions of pallets. If type is set to euro, dimensions parameter is not evaluated and is auto configured to `120x80`. |
| pallets.amount | integer | Pallets amount. Valid value should be between 0 and 99999. |
| pallets.is_stackable | boolean | Specifies whether pallets is stackable. |
| pallets.is_exchangeable | boolean | Specifies whether pallets is exchangeable. |
| is_ltl | boolean | True means that load is less then available truck load and can be transferred with other goods. |
| is_lift_required | boolean | Whether truck lift will be required to handle load. |
| is_truck_crane_required | boolean | Specifies whether truck crane will be required to handle load. |
| is_tir_cable_required | boolean | Specifies whether tir cable will be required to handle load. |
| is_tracking_system_required | boolean | Specifies whether vehicle must have gps monitoring. |
| is_for_clearance | boolean | Specifies whether load will need clarence. |
| required_ways_of_loading | array | Specifies required method of loading onto the vehicle. One or more of: `top`, `back`, `side`. |
| required_adr_classes | array | Specifies required ADR classes to handle load. One or more  of: `1`, `2`, `3`, `4.1`, `4.2`, `4.3`, `5.1`, `5.2`, `6.1`, `6.2`, `7`, `8`, `9`. |

**Links**

| Link | Value Type | Value Description |
|---|---|---|
| offerer.id | integer | Identifier of employee who post load offer. |
| offerer.href | string | Contains URL to Employee entitiy. |
| company.id | integer | Identifier of employee's company who post load offer. |
| company.href | string | Contains URL to Company entitiy. |
| contact_persons.ids | array | List of employees identifiers. Give ability to assign one or more persons within offerer company as contact for the offer. By default offerer is listed as contact person. |
| contact_persons.href | object | Contains URL to Employees collection. |
| required_truck_body.id | string | Identifier of trcuk body. |
| required_truck_body.href | string | Contains URL to Truck Body entity. |
| type_of_load.id | string | Identifier of load type.  |
| type_of_load.href | string | Contains URL to Type Of Load entity. |

### Vehicle entity

| Field | Value Type | Value Description |
|---|---|---|
| id | integer  | Unique identifier for a vehicle offer. |
| creation_date | string | Date and time (ISO 8601) of vehicle offer creation. |
| publication_date | string | Date and time (ISO 8601) when vehicle offer will be published. |
| finish_date | string | Date and time (ISO 8601) when vehicle offer will be finished. |
| loading_place.address.country | string | The loading place country code (ISO 3166-1 alpha-2). |
| loading_place.address.postal_code | string | Loading place postal code. Valid value should have min 1 and max 7 length and match `/^[\p{L}0-9][\p{L}0-9 .-]*$/`.  |
| loading_place.address.locality | string | Loading place locality. Valid value should have min 2 and max 40 length and match ```/^[\p{L}£\(\)\'][\p{L}0-9 .&`,:\(\)\/\'-£]*$/u```. |
| loading_place.geo.latitude | float | Loading place latitude coordinate in degrees. |
| loading_place.geo.longitude | float | Loading place longitude coordinate in degrees.  |
| loading_date | string | Date and time (ISO 8601) when load offer must be loaded. |
| unloading_place.address.country | string | The unloading place country code (ISO 3166-1 alpha-2). |
| unloading_place.address.postal_code | string | Unloading place postal code. Valid value should have min 1 and max 7 length and match `/^[\p{L}0-9][\p{L}0-9 .-]*$/`. |
| unloading_place.address.locality | string | Unloading place locality. Valid value should have min 2 and max 40 length and match ```/^[\p{L}£\(\)\'][\p{L}0-9 .&`,:\(\)\/\'-£]*$/u```. |
| unloading_place.geo.latitude | float | Unloading place latitude coordinate in degrees. |
| unloading_place.geo.longitude | float | Unloading place longitude coordinate in degrees. |
| unloading_date | string | Date and time (ISO 8601) when load offer must be unloaded. |
| price | float | Vehicle offer price. Valid value should be between 0 and 999999.99.  |
| price_currency | string | Vehicle offer price currency (ISO 4217). |
| description | string | Vehicle offer description. Valid value should have min 1 and max 200 length. |
| type | string | Vehicle offer visibility: `public`, `cluster`, `private` |
| cargo_space_capacity.value | float |  Capacity of cargo space. Valid value should be between 0.01 and  9999.99 |
| cargo_space_capacity.unit_code | string | Cargo space capacity measure unit. Only valid value is `MTQ` (cubic metre). |
| cargo_space_length.value | float |  Length of cargo space. Valid value should be between 0.01 and  999.99  |
| cargo_space_length.unit_code | string | Cargo space length measure unit. Only valid value is `MTR` (metre).  |
| cargo_space_height.value | float |  Height of cargo space. Valid value should be between 0.01 and  999.99  |
| cargo_space_height.unit_code | string | Cargo space height measure unit. Only valid value is `MTR` (metre).  |
| cargo_space_volume.value | float |  Volume of cargo space. Valid value should be between 0.01 and  999.99  |
| cargo_space_volume.unit_code | string | Cargo space volume measure unit. Only valid value is `TNE` (metric tons).  |
| ltl_available | boolean | True means that truck is already loaded with other goods, but has some free capacity to handle additional load. |
| has_adr | boolean | Specifies whether vehicle has adr. |
| has_lift | boolean | Specifies whether vehicle has lift. |
| has_truck_crane | boolean | Specifies whether vehicle has truck crane. |
| has_tir_cable | boolean | Specifies whether vehicle has tir cable.  |
| has_tir_carnet | boolean | Specifies whether vehicle has tir carnet. |
| has_pallet_bin | boolean | Specifies whether vehicle has pallet bin. |
| has_tracking_system | boolean | Specifies whether vehicle has gps monitoring. |
| available_ways_of_loading | array | Specifies available method of loading onto the vehicle. One or more of: `top`, `back`, `side`. |

**Links**

| Link | Value Type | Value Description |
|---|---|---|
| offerer.id | integer | Identifier of employee who post vehicle offer. |
| offerer.href | string | Contains URL to Employee entitiy. |
| company.id | integer | Identifier of employee's company who post vehicle offer. |
| company.href | string | Contains URL to Company entitiy. |
| contact_persons.ids | array | List of employees identifiers. Give ability to assign one or more persons within offerer company as contact for the offer. By default offerer is listed as contact person. |
| contact_persons.href | object | Contains URL to Employees collection. |
| truck_body.id | string | Identifier of trcuk body. |
| truck_body.href | string | Contains URL to Truck Body entity. |

### Truck Body entity

| Field | Value Type | Value Description |
|---|---|---|
| id | string | Const identified truck body. |

Supported truck bodies:

* tent
* isotherm
* box-truck
* spacious
* other
* car-transporter
* double-trailer
* van
* mega
* coilmulde
* walking-floor
* low-suspension
* flatbed
* chemical-tanker
* food-tanker
* petroleum-tanker
* gas-tanker
* log-trailer
* oversized-cargo
* hook-lift
* container-20-40
* dump-truck
* koffer
* swap-body-system
* jumbo
* cooler
* curtainsider
* tanker
* silos
* removal-truck

### Type Of Load entity

| Field | Value Type | Value Description |
|---|---|---|
| id | string | Const identified type of load. |

Supported types of load:

* full-truck-standard
* full-truck-mega
* cubic
* bag
* item
* envelope
* box
* package
* cardboard
* timber
* roll
* roll2
* barrel
* other
