# SwiftUI Hamburger 🍔
SwiftUI implementation of a Hamburger menu

<img src="https://github.com/moflo/swiftui_hamburger/blob/master/Hamburger_Screen.png?raw=true" width=300 />

### Description
Create two sub-views which, critially, need to be cast to AnyView() structs
Pages View then dynamically presents the subviews, based on currentPage state
BurgerMenuView then wraps the pages with a dynamic menu and binds the isShowing and currentPage states


### TODO

1. Refactor into a Swift Package
2. Add dynamic list of menu items, likely as a `stuct` input type