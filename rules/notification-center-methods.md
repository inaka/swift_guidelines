NSNotificationCenter Methods
============================

Severity: **Rule**

-

##### Description

When assigning a method to `NSNotificationCenter`, it must:
- Include the notification object in its signature
- Never be called directly from your code

-

##### Example
Good
```swift
NSNotificationCenter.defaultCenter().addObserver(self, selector: "methodCalledFromNotification:", name: NotificationExampleName, object: nil)

// MARK: - NSNotification

func methodCalledFromNotification(notification: NSNotification) {
    // It's clear that this method is going to be called from a notification.
}
```

Bad
```swift
NSNotificationCenter.defaultCenter().addObserver(self, selector: "method", name: NotificationExampleName, object: nil)

// MARK: - NSNotification

func method() {
    // You can't ensure whether this method is going to be called from a notification or somewhere else...
}

```

-

##### Motivation
- Separation of concerns. You can easily separate out which methods are expected to be called by notification center and which are not.
- It avoids confusions.
- It prevents runtime crashes that may be caused by removing a method that you might think is not being used, but it's actually being called by notification center at runtime.
- By appending an `NSNotification` object to the method signature, you won't be able to call it from your code, because you won't have a notification object to pass in.