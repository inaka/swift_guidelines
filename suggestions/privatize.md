# Privatize

Severity: **Suggestion**

-

##### Description

- Everything within a `class` or `struct` that is not intended to be used from the outside should be declared `private`.

##### Motivation

- Better code architecture thanks to achieved encapsulation.
- Clearness: Your classes end up exposing minimal and clear APIs; therefore, they become easier to use and understand for other developers.
- It helps tracking bugs, given that we gain a stronger separation of concerns.

