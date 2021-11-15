# PexelsBrowser
Simple app using [Pexels](https://pexels.com) API written in Swift using SwiftUI

This app showcases how to implement simple APIs from providers like [Pexels](https://pexels.com)

**Note:** You must include your own API Key in a new File like this:

```swift 
extension Environment {
  struct APIKeys {
    static let pexels: (key: String, header: String) = ("YOUR_API_KEY_HERE", "Authorization")
  }
} 
```

API Reference can be found [here](https://www.pexels.com/api/documentation/)
