# Overview

Resources available in TransAPI are secured, which means that each request must be authorized.

To obtain authorization, end user must grant application permission to use his data.

In order to make this process as easy as possible, TransAPI supports [OAuth 2.0](http://oauth.net/2/) protocol.

Existing implementation supports [authorization code](grant-type/authorization-code.md) and [resource owner password credentials](grant-type/resource-owner-password-credentials.md) grant types.

## User authentication sources

User can authenticate in Trans Authorization Server using his [Trans](http://www.trans.eu/) or [TransPlace](https://transplace.eu/) credentials.

Authentication source is selected based on `source` parameter value.

Parameter can be located in:
* query string for **authorization code grant**,
* access token body for **resource owner password credentials grant**.

By default Trans Authorization Server assumes Trans as authentication source.

### Source parameter possible values

* `trans_account` - authenticate user using Trans credentials,
* `transplace` - authenticate user using TransPlace credentials.

## Client authentication in access token request

Each request for access token requires authentication using application credentials (client ID and client secret).

They can  be submited in 2 ways: authorization header or request body.

### Authorization header

Base 64 encoded string that contains the client ID and client secret key.

The field must have the format:

`Authorization: Basic <base64 encoded client_id:client_secret>`

### Request body

```
POST /oauth2/token HTTP/1.1
Host: auth.system.trans.eu
Content-Type: application/x-www-form-urlencoded

client_id=example_app_client_id
&client_secret=example_app_secret
```

## Errors

For authorization and token requests errors are supported as defined in [OAuth2 specification](https://tools.ietf.org/html/rfc6749).

Example:

```
HTTP/1.1 400 Bad request
Content-Type: application/json

{
  "error": "invalid_grant",
  "error_description": "Invalid username and password combination"
}
```

### Not unique username error

User can sign in using TransId or email.

If user provides not unique email as username `not_unique_username` error code is returned.

## Access token

Access token is a string that identifies user and can be used by the application to make TransAPI requests.

Due to security reasons access token lifetime is limited to **1 hour**.

After this time after that access token becomes invalid.

To obtain new `access token` you can use `refresh token`.

## Refresh token

`Refresh token` is a single use value with a lifetime of **60 days**.

Upon refreshing of `access token`, the `refresh token` is being discarded.

Application also receives different `refresh token` for next use.
