# Multi language support

Trans Authorization Server authentication page and access grant page can be displayed in different languages.
To change displayed language you can use `locale` query param.

```
https://auth.system.trans.eu/oauth2/login?locale=pl-PL
```

If `locale` parameter is not set, browser language is detected (by Accept-Languages header), finally if it can not be detected, `en-GB` is set as default.

## Supported Locales

* cs-CZ (Český)
* da-DK (Danska)
* de-DE (Deutsch)
* en-GB (English)
* es-ES (Español)
* fr-FR (Français)
* it-IT (Italiano)
* lt-LT (Lietuvių)
* hu-HU (Magyar)
* nl-NL (Nederlands)
* no-NO (norsk)
* pl-PL (Polski)
* ro-RO (Română)
* sk-SK (Slovenský)
* fi-FI (Suomi)
* tr-TR (Türkçe)
* bg-BG (Български)
* ru-RU (Русский)
* uk-UA (Українська)
