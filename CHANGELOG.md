# Changelog

## 1.5.0

- Add support for URLs without port number. The `port` parameter in `XtreamCode.initialize()` is now optional, allowing you to connect to Xtream Codes servers that don't require a port number in the URL. This is particularly useful for servers using standard HTTP/HTTPS ports (80/443) or when the port is already included in the base URL.
- Improve stability in parsing lists
- Improve Documentation

## 1.4.1

Bump dependencies

## 1.4.0

Fix an issue with parsing vod items that are incomplete
Fix an issue with initializing a new session using _init

## 1.3.6

Bump dependencies to support latest versions

## 1.3.5

Fix an issue with correctly parsing VOD Info

## 1.3.3

Fix issue with assets

## 1.3.2

Minor stability changes for parsing JSON

## 1.3.0

Integrate the option to download the complete EPG by using the XMLTV endpoint.
This is much more efficient and faster then iterating thorugh each channel and using the existing endpoints

Also improved the stability in parsing existing endpoints to prevent cast issues if empty lists are returned as null instead of []

## 1.2.1

Export XtreamCodeClient to fix #6

## 1.2.0

Fixing a crucial issue with the API

## 1.1.0

### Breaking Stabilize Parsers

This includes breaking type changes on some APIs

With those changes dynamic parsing is introduced to handle the non standardized api from XTreamCode Api's

Also added extensive test coverage

## 1.0.3

- Fix an issues with url

## 1.0.2

- Improvements to the EPG methods
- Fixed a bug when retrieving the stream url  

## 1.0.1

- fix streamUrl

## 1.0.0

- Initial Release 🎉
