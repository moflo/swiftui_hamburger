//
//  ContentView.swift
//  SingleView
//
//  Created by moflo on 6/18/19.
//  Copyright © 2019 moflo. All rights reserved.
//

import SwiftUI
import UIKit

// UIActivityIndicator
/// Demonstrating the use of UIKit elements within a SwiftUI View
struct ActivityIndicator: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style

    func makeUIView(context _: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context _: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}

// MenuView Displays a Popover / Slide-in menu
/// Menu selections are fixed in this demo, need to be refactored to a variable
struct MenuView: View {
    @Binding var isShowing: Bool
    @Binding var currentPage: Int
    var items: [String] = ["One", "Two"]

    var body: some View {
        GeometryReader { _ in

            VStack(alignment: .leading, spacing: 10.0) {
                /// Iterate over all menu items, display a button which wraps a HStack
                /// Not able to perform enumerated() iteration during build, so have to pass
                /// Item as String to changePage() method
                ForEach(self.items.identified(by: \.self)) { item in
                    Button(action: { self.changePage(page: item) }) {
                        HStack {
                            Image(systemName: "house").font(.title).foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3, opacity: 0.8))
                            Text("\(item)").font(.title).padding(.leading, 10.0)
                        }
                    }
                }
                ActivityIndicator(style: .large).padding(.top, 88.0)
            }
            .padding([.top, .leading], 50.0)
        }
    }

    /// ChangePage method, updates current page state and isShowing to hide menu
    func changePage(page: String = "") {
        let page_index: Int = items.firstIndex(of: page) ?? 0
        currentPage = page_index
        isShowing.toggle()
    }
}

// A HamburgerMenu created as a top-level View with Content subviews rendered as-is
/// Menu will render all subViews (ie., content() ) and handle menu presentation and animation
struct BurgerMenuView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    @Binding var currentPage: Int
    var menuText: String = "🍔"
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            AnyView(ZStack(alignment: .leading) {
                if !self.isShowing {
                    self.content()
                }
                if self.isShowing {
                    self.content()
                        .disabled(true)
                        .blur(radius: 3)
                }

                VStack {
                    MenuView(isShowing: self.$isShowing, currentPage: self.$currentPage)
                        .animation(.basic(duration: 0.33, curve: .easeInOut))
                        .background(Color.secondary.colorInvert())
                        .foregroundColor(Color.primary)
                        .cornerRadius(20)
                        .padding(.top, 44)
                        .padding(.trailing, 88)
                        .offset(x: !self.isShowing ? -geometry.size.width : 0.0, y: 0.0)
                }

                Button(action: { self.isShowing.toggle() }) {
                    if self.menuText.count == 0 {
                        Image(systemName: "a.circle")
                            .resizable()
                            .frame(width: 40.0, height: 40.0)
                    } else {
                        Text("\(self.menuText)")
                            .font(.largeTitle)
                    }
                }.position(x: 20, y: 10)
            })
        }
    }
}

// Pages View to select current page
/// This could be refactored into the top level
struct Pages: View {
    @Binding var currentPage: Int
    var pageArray: [AnyView]

    var body: AnyView {
        return pageArray[currentPage]
    }
}

// Top Level View
/// Create two sub-views which, critially, need to be cast to AnyView() structs
/// Pages View then dynamically presents the subviews, based on currentPage state
/// BurgerMenuView then wraps the pages with a dynamic menu and binds the isShowing and currentPage states
struct ContentView: View {
    @State var isShowing: Bool = false
    @State var currentPage: Int = 0

    let page0 = AnyView(
        NavigationView {
            VStack {
                Text("Page Menu").color(.black)

                List(["1", "2", "3", "4", "5"].identified(by: \.self)) { row in
                    Text(row)
                }.navigationBarTitle(Text("A Page"), displayMode: .large)
            }
        }
    )

    let page1 = AnyView(
        NavigationView {
            VStack {
                Text("Another Page Menu").color(.black)

                List(["A", "B", "C", "D", "E"].identified(by: \.self)) { row in
                    Text(row)
                }.navigationBarTitle(Text("A Second Page"), displayMode: .large)
            }
        }
    )

    var body: some View {
        let pageArray: [AnyView] = [page0, page1]

        return BurgerMenuView(isShowing: $isShowing, currentPage: self.$currentPage) {
            Pages(currentPage: self.$currentPage, pageArray: pageArray)
        }
    }
}

#if DEBUG
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
#endif
