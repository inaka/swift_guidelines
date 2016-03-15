# Privatize

Severity: **Rule**

-

##### Description

- Everything within a `class` or `struct` that is not intended to be used from the outside must be declared `private`.

-

#####Example

```swift
struct User {

    let name: String
    let email: String

    func save() {
        User.Defaults.setObject(self.dictionaryValue(), forKey: Keys.SavedUser)
        User.Defaults.synchronize()
    }

    static var savedUser: User? {
        guard let dictionary = User.Defaults.objectForKey(Keys.SavedUser) as? [String: AnyObject] else {
            return nil
        }
        return User(dictionary: dictionary)
    }

    // MARK: - Private

    private static let Defaults = NSUserDefaults.standardUserDefaults()

    private struct Keys {
        static let SavedUser = "saved_user"
        static let Name = "name"
        static let Email = "email"
    }

}

// MARK: - Conversion

private extension User {

    init(dictionary: [String: AnyObject]) {
        let name = dictionary[Keys.Name] as! String
        let email = dictionary[Keys.Email] as! String
        self.init(name: name, email: email)
    }

    func dictionaryValue() -> [String: AnyObject] {
        return [
            User.Keys.Name: self.name,
            User.Keys.Email: self.email
        ]
    }
}
```

Notice:

- The usage of a `private struct` to define a group of static strings that should only be known internally.
- The usage of a `private extension` to group relevant methods that are only used internally within the file.
- Observe how, by this way, `User` ends up exposing a concise API:
  - `init(name: String, email: String)`, the default implicit initializer as a consequence of being a `struct`.
  - `name` and `email` as read-only properties.
  - `save()` method for saving a user.
  - `savedUser` static variable to get the saved user.
  - That's all you can do with it. Anything else is internal, and not exposed to other classes.

-

##### Motivation

- More robust code architecture thanks to achieved encapsulation.
- Clearness: Your classes end up exposing minimal and clear APIs; therefore, they become easier to use and understand for other developers.
- It helps tracking bugs, given that we gain a stronger separation of concerns:
  - A public member can be accessed from outside the class, which for practical considerations means *potentially anywhere*. If something goes wrong with a public field, the culprit can be anywhere, and so in order to track down the bug, you may have to look at quite a lot of code.
  - A private member, by contrast, can only be accessed from inside the same class, so if something goes wrong with that, there is usually only one source file to look at. If you have a million lines of code in your project, but your classes are kept small, this can reduce your bug tracking effort by a factor of 1000.