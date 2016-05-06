
Variables Capitalization
================

Severity: **Rule**

-

##### Description

Variables and constants names must be written using:

- `lowerCamelCase` for variables (i.e. `var`)
- `lowerCamelCase` for non-static constants (i.e. `let`)
- `PascalCase` for static constants (i.e. `static let`)

⚠️ Be aware of [acronyms](acronyms-capitalization.md).

-

##### Example
Good
```swift
let users: [User]
var selectedUser: User?
static let MaxNumberOfUsersAllowed = 100
```

Bad
```swift
let Users: [User] // NO
var SelectedUser: User? // NO
static let maxNumberOfUsersAllowed // NO!
static let MAX_NUMBER_OF_USERS_ALLOWED // NOOOOOO!!!!!!
```
-

##### Motivation
- Consistency.
- Readability: Variables or non-static constants are easier to be distinguished from static constants.