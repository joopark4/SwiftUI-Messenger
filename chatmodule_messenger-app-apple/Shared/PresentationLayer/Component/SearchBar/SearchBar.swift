//
//  SearchBar.swift
//  ChatModuleMessengerAppApple
//

import SwiftUI

/// SearchBar
///
/// Usage:
/// @ObservedObject var searchBar: SearchBar = SearchBar()
///
///   List {
///     content
///   }.add(searchBar)
///
///
class SearchBar: NSObject, ObservableObject {

    @Published var text: String = ""
    let searchController: UISearchController = UISearchController(searchResultsController: nil)

    override init() {
        super.init()
        // textfiled 선택했을때 아래 리스트가 스크롤 되는지 여부 스크롤 안되는게 true
        self.searchController.obscuresBackgroundDuringPresentation = false
        // textfield 선택했을때 상단의 네비게이션 타이틀이 사라지는지 여부
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchResultsUpdater = self
    }
}

extension SearchBar: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        // Publish search bar text changes.
        if let searchBarText = searchController.searchBar.text {
            self.text = searchBarText
        }
    }
}

struct SearchBarModifier: ViewModifier {

    let searchBar: SearchBar
    let hideSearchBarWenScroll: Bool

    func body(content: Content) -> some View {
        content
            .overlay(
                ViewControllerResolver { viewController in
                    viewController.navigationItem.hidesSearchBarWhenScrolling = hideSearchBarWenScroll
                    viewController.navigationItem.searchController = self.searchBar.searchController
                }
                .frame(width: 0, height: 0)
            )
    }
}

extension View {
    func add(_ searchBar: SearchBar, hideSearchBarWenScroll: Bool = true) -> some View {
        return self.modifier(SearchBarModifier(searchBar: searchBar, hideSearchBarWenScroll: hideSearchBarWenScroll))
    }
}
