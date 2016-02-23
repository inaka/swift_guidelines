# Avoid flags

Severity: **Suggestion**

-

##### Description

- Avoid creating flags whenever possible. 
- Use computed properties instead.

-

##### Example

A very common scenario: 

Let's suppose you have a specific screen that can be accessed through multiple UI flows, and you need to know whether the navigation came from a specific place or from somewhere else.

You need to add some code in the corresponding `UIViewController` to know whether or not the navigation came from here or there, to perform different actions on each case.

Good

```swift
// In the UIViewController you need to distinguish where the navigation comes from

private var comesFromSignUpFlow: Bool {
    guard let navigationController = self.navigationController else {
        return false
    }
    return navigationController.containsViewControllerOfKind(SignUpViewController)
    }	// It's automatically calculated! You don't need to worry to maintain this property. Also, it's private.
```

Bad

```swift
// In the UIViewController you need to distinguish where the navigation comes from

var comesFromSignUpFlow = false	// Can't make it private. Bad.

// In SignUpViewController
yourOtherViewController.comesFromSignUpFlow = true	// You need to maintain it from the outside. Bad.
```

-

##### Motivation

- Flags need to be maintained, which usually causes bugs due to the fact that soon or later you, or most likely other developer, will forget to set that flag to its proper value (`true` or `false`) somewhere in the codebase when adding new code or maintaining existent code.