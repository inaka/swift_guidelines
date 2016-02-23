# Prototype your Storyboards

Severity: **Suggestion**

-

##### Description

- Prototype your Storyboards (and .xib files) as much as possible.
- Here are some advices you might want to apply to your Storyboards to accomplish that:
  - Avoid UI elements with empty values; rather have them set with example values.
  - Prefer real examples instead of generic ones:
    - `John Appleseed` reads way better than `User Name`, since the former is closer to a real use case.
    - `john@appleseed.com` rather than `Email Address`.
  - When it comes to numeric values, try to choose values that are not extreme cases:
    - Favorites: `3 people`  rather than `0 people`.
    - Progress bar: `45% completed` rather than `0% completed` or `100% completed`.
    - Time left: `15 seconds` rather than `0 seconds`.
  - Use `IBInspectable` and `IBDesignable` when you find a proper oportunity. You will find good instructions in [this blogpost](http://nshipster.com/ibinspectable-ibdesignable/).
  - Whenever possible, perform style operations directly in your Storyboard and not via code (e.g.  `font`, `textColor`, `backgroundColor`, and the like).

-

##### Motivation

- User Interface elements in Storyboards being as closest as possible to what they will look like at runtime makes them easier to read, understand and maintain.
- Smaller codebase, since lots of unnecessary lines of code are avoided.
- It prevents `UIViewController` classes from having noisy lines of code that distract their purpose and make them harder to read and maintain.
- More robust and consistent project design caused by all developers following the same standards.