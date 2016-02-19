# Optionals

Severity: **Rule**

-

##### Description

Variables should be declared with their proper optionality following the rules described [here](http://inaka.net/blog/2015/12/18/dealing-with-optionals-in-view-controllers/).

-

##### Example

Good

``` swift
@IBOutlet weak var titleLabel: UILabel!

self.titleLabel.text = "Something"

// If `titleLabel` is `nil`, app will crash at runtime, making it obvious that the developer is forgetting to hook it up in the Interface Builder.
```

Bad

``` swift
@IBOutlet weak var titleLabel: UILabel?

if let label = self.titleLabel {
	label.text = "Something"
}

// Conceptually wrong. Developer may forget to hook `titleLabel` in Interface Builder and that mistake could easily make it to a production stage without being noticed.
```

-

##### Motivation

- It helps catch bugs earlier in the development stage.
- Variables meaning and their intentions are clearer.