# Common API REST standards

## Requests

### Accept media types

All request to TransAPI must contain proper `Accept` header, as it's based on [Json HAL](http://stateless.co/hal_specification.html).

As HAL language is used, proper `Accept` header is as follows:
```
Accept: application/hal+json
```

#### JSON Hypertext Application Language (HAL)

HAL is a generic media type with which Web APIs can be developed and exposed
as series of links. Clients of these APIs can select links by their link
relation type and traverse them in order to progress through the application.

For more in-depth HAL standard specification see [draft-kelly-json-hal-07](https://tools.ietf.org/html/draft-kelly-json-hal-07).

### Content-Type

For `POST`/`PUT`/`PATCH` request methods, content should be well-formed JSON.

Also proper `Content-Type` header is required:

```
Content-Type: application/json
```

### Collection filtering

TransAPI uses JSON filter syntax, there are few reasons why JSON was appointed to standard:

* easy to implement in any programing language,
* easily creates nested structure,
* short,
* human-readable.

Operators examples:

* filter out elements meeting range criteria
    > `{ field: { $gt: value1, $lt: value2 } }`

* filter out elements present in given array:
    > `{ field: { $in: [<value1>, <value2>, ... <valueN> ] } }`

TransAPI has adopted MongoDB filtering syntax. More information regarding filters can be found in [MongoDB filtering documentation](http://docs.mongodb.org/manual/reference/method/db.collection.find/).

**IMPORTANT**: TransAPI uses only embedded filter notation. Filters also don't filter by exact matches of entity fields.

Example of load collection filter by unloading location:

`/loads?filter={"unloading_place":{"address":{"country":"PL"}}}`.

### Collection sorting

To sort collection in TransAPI, request must contain `sort` param in query string.

TransAPI has adopted MongoDB sorting syntax. More information regarding sorting can be found in [MongoDB sorting documentation](http://docs.mongodb.org/manual/reference/method/cursor.sort/).

Example of ascending sort vehicles by loading country:

`/vehicles?sort={"loading_place.address.country":-1}}}`


### Read specified fields from resource

To read specified fields from resource and embedded resources use `fields` parameter. It can be used only for GET method.
TransAPI has adopted MongoDB projection syntax. More information regarding sorting can be found in [MongoDB projection documentation](http://docs.mongodb.org/manual/tutorial/project-fields-from-query-results/).

Example of including only load id:

`/loads/123456789?fields={"id":1}}}`

## Data formats

#### Date time

Timestamps are returned in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format as Coordinated Universal Time (UTC) with zero offset:

`YYYY-MM-DDTHH:MM:SS+00:00`

#### Date

Date format is documented in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601)

#### Country

Country format is documented in [ISO_3166-1](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)

#### Boolean

Boolean values must be passed as boolean `true`/`false`. Do not use strings (`"true"/"false"`) or numbers (`0`/`1`).

#### Numeric fields

Numeric fields must be passed as integers or floats, not strings. Example:

```
{
  "id": 123,
  "name": "Product",
  "price": 123.23
}
```

#### Fields without value

Field without defined value should be passed as `null` and are returned as `null`. Avoid empty strings (`""`), `0` or false. Example:

```
{
  "id": 123,
  "name": "John",
  "telephone": null
}
```

## Response

### Error responses

For error responses TransAPI uses format documented in [API Problem documentation](https://tools.ietf.org/html/draft-nottingham-http-problem-07).

```
HTTP/1.1 403 Forbidden
Content-Type: application/problem+json

{
    "type": "http://api-problem.domain.com/some-url.html",
    "title": "Forbidden",
    "status": 403,
    "detail": "some detail"
}
```

API Problem may contain following fields:

* type: URL to documentation page. If not presented, its value is assumed to be "about:blank",
* title: A short summary of the problem type. It does not change between occurrences of the problem,
* status: HTTP status code, same as in header,
* detail: More detailed explanation specific to given occurrence of the problem.

Response may also contain custom fields.

**IMPORTANT** Problem details are not a debugging tool for the underlying implementation; rather, they are a way to expose general information about the HTTP interface itself.

#### Validation errors

Example of filter validation error response:

```
HTTP/1.1 422 Unprocessable Entity
Content-Type: application/problem+json

{
    "detail": "Failed Filter Parameter Validation",
    "status": 422,
    "title": "Invalid Filter Parameter",
    "type": "http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html",
    "validation_messages": {
        "message": {
            "isEmpty": "Value is required and can't be empty"
        },
        "name": {
            "regexNotMatch": "Invalid name supplied."
        }
    }
}
```

## HTTP Status Codes

### [201 Created](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.2.2)

After creating new entity.

### [204 No Content](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.2.5)

After deleting entity.

### [403 Forbidden](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.4)

The request was a legal request, but the server is refusing to respond to it.

### [404 Not Found](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.5)

When trying to get not existing entity.

### [405 Method Not Allowed](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.6)

A request was made to a resource with request method not supported by that resource.

### [409 Conflict](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.4.10)

When trying to POST/PUT/PATCH entity and given value already exists.

### [422 Unprocessable Entity](https://tools.ietf.org/html/rfc4918#section-11.2)

The request was well-formed but server was unable to process it due to semantic errors.
