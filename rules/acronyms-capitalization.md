
Acronyms Capitalization
================

Severity: **Rule**

-

##### Description

Acronyms must be capitalized such that:
- All of its characters are UPPERCASE, unless:
  - The acronym goes at the very beginning of a variable (or non-static constant, or function) name, in which case, to preserve the [variables capitalization rule](variables-capitalization.md), it will use lowercase for all of its characters. 


-

##### Example
Good
```swift
func pathForURL(url: NSURL) -> String 
// First 'URL' appearance goes UPPERCASE. 
// Second appearance goes lowercase, since it's at the beggining of a non-static constant name.

func urlForPath(path: String) -> NSURL	
// 'URL' goes at the beggining of the function name, use lowercase.

let urlForConnections: NSURL 
// 'URL' goes at the beggining of a non-static constant name, use lowercase.

let baseURL: NSURL
// 'URL' isn't at the beggining of a non-static constant name, use UPPERCASE.

static let URL = NSURL(string: "http://www.google.com/")
// Particular scenario: URL can go all UPPERCASE in this case because it's about a static constant, which should start with Uppercase.
```

Bad
```swift
func pathForUrl(URL: NSURL) -> String 
// First appearance: Wrong. You should never see such camel case scenario ('Url').
// Seccond appearance: Wrong. Constants should start with Uppercase only if they are static.

func URLForPath(path: String) -> NSURL	
// 'URL' goes at the beggining of a function name, it should go lowercase.

let URLForConnections: NSURL 
// 'URL' goes at the beggining of a non-static constant name, it should go lowercase.

let baseUrl: NSURL
// Wrong. You should never see such camel case scenario ('Url').
```
-

##### Motivation
- Consistency.