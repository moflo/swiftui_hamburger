# SwiftUI Hamburger 🍔
SwiftUI implementation of a Hamburger menu

<img src="https://github.com/moflo/swiftui_hamburger/blob/master/Hamburger_Screen.png?raw=true" width=300 />

### Description
`BurgerMenuView` is a SwiftUI that presents subviews and a popup 'hamburger' menu.

`BurberMenuView` wraps the subviews with a dynamic menu and binds the `isShowing` and `currentPage` states.

This demo creates two sub-views (`page0` and `page1`) which, critially, need to be cast to `AnyView` type structs. The `Pages` View then dynamically presents the subviews, based on `currentPage` state.

This demo has two fixed menus, but can be easily extended to support multiple subviews and, a better menu icon.


### TODO

1. Refactor into a Swift Package
2. Add dynamic list of menu items, likely as a `stuct` input type