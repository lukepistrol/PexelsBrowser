# PexelsBrowser
<p>
    <img src="https://img.shields.io/badge/Swift-5.5.1-ff69b4.svg" />
    <img src="https://img.shields.io/badge/iOS-15+-brightgreen.svg" />
    <img src="https://img.shields.io/badge/macOS-12+-brightgreen.svg" />
    <a href="https://twitter.com/lukeeep_">
        <img src="https://img.shields.io/badge/Contact-@lukeeep_-lightgrey.svg?style=flat" alt="Twitter: @lukeeep_" />
    </a>
</p>

Simple app using [Pexels](https://pexels.com) API written in Swift using SwiftUI

![Pexels Browser Preview](https://github.com/lukepistrol/PexelsBrowser/blob/master/Resources/PexelsBrowserApp.jpg "Pexels Browser")

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

**Feel free to check out my other projects on my [website](https://lukaspistrol.com) **
