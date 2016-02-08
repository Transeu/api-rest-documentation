# Resource Owner Password Credentials Grant (2-legged authorization)

>**Important note**: To utilize this authentication flow your application must have `password` grant type admitted.

For more general information please refer to [Authoziation overview](../overview.md)

## Access token request

### Example

```
POST /oauth2/token
Host: auth.system.trans.eu
Content-Type: application/x-www-form-urlencoded

grant_type=password
&username=jan.kowalski@trans.eu
&password=abc123
&scope=offers.loads.manage
&client_id=example_app_client_id
&client_secret=example_app_client_secret
```

### Request parameters

| Name | Required | Type |  Description |
|---|---|---|---|
| grant_type | yes | string | Must be set to `password`. |
| username | yes | string | User Trans or Transplace login. |
| password | yes | string | User password. |
| scope | no |  string | Space separated list of scopes that application would like to access. |
| client_id | no| string | Application client_id obtained during registration. Only required when `Authorization` header is not sent. |
| client_secret | no | string | Application client_secret obtained during registration. Only required when `Authorization` header is not sent. |

### Header parameters

| Name | Required | Value |
|---|---|---|
| Authorization | yes | Base 64 encoded string that contains the client_id and client_secret keys. The field must have the format: `Authorization: Basic <base64 encoded client_id:client_secret>`.  |
| Content-Type | yes |  application/x-www-form-urlencoded. |

## Access token response

### Example

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "access_token": "59d9aa9b15cd59a61fc52014792efb6caa82373b",
  "expires_in": 3600,
  "token_type": "Bearer",
  "scope": "offers.loads.manage",
  "refresh_token": "d52d1d998d6533a3be8e7f26f904be513287938b"
}
```

### Response parameters

| Name | Description |
|---|---|
| access_token | Access token to use by application for authorization. |
| expires_in | Time in seconds until token expires. |
| token_type | Type `Bearer` is returned as defined in [rfc6749](http://tools.ietf.org/html/rfc6750). |
| scope | Space separated list of scopes that access token has access to. |
| refresh_token | Single serving token that can be used to extend lifetime of access token. |

### Custom error codes

| Name | Description |
|---|---|
| not_unique_username | If user enter not unique email as username. |
