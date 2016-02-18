IBAction Methods
================

Severity: **Rule**

-

##### Description

Any `@IBAction` method must:
- Include the sender object in its signature
- Have its sender object being the specific type (e.g. `UIButton`, `UITapGestureRecognizer`, etc) and not `AnyObject`
- Have its sender object being non-optional
- Never be called directly from your code

-

##### Example
Good
```swift
@IBAction func doSomething(sender: UIButton) {
    // It's clear that this method is going to be called from an action caused by a UIButton.
}

```

Bad
```swift
@IBAction func doSomething() {
    // This method may be called from somewhere else in your code...
    // Inconsistency. Confusion. Not good.
}
```
-

##### More complex example
Sometimes, there are scenarios where you need to perform the same action when pressing a button than when performing some action that's called from your code. In those cases, however, it's still good to separate concerns and encapsulate your action in a separated method, which will be called from both your `@IBAction` method and from somewhere else in your code.


Good
```swift
// MARK: - IBAction

@IBAction func doSomething(sender: UIButton) {
    self.performSomeAction()
}

// MARK: - Private

private func otherMethod() {
	self.performSomeAction()
}

private func performSomeAction() {
	// Perform the actual action
}

```

Bad
```swift
// MARK: - IBAction

@IBAction func doSomething() {
	// Not good that this method can be called from any other place which may have nothing to do with @IBAction
}

// MARK: - Private

private func otherMethod() {
	self.doSomething()	// bad
}

```

-

##### Motivation
- Expressivity.
- Separation of concerns.
- It avoids confusions.