//
//  SearchViewController.swift
//  GithubSearch
//
//  Created by Excell on 15/07/2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = SearchViewModel()
    
    var searchResult: SearchDataType?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitle()
        setSearch()
        setTableView()
        setViewModel()
        
        // for demo
        self.viewModel.doSearch(txt: searchTextField.text ?? "")
    }
}

private extension SearchViewController {
    func setNavTitle() {
        self.navigationItem.title = "Search"
    }
    
    func setSearch() {
        // for demo, i just added a text
        searchTextField.text = "swift"
        searchTextField.delegate = self
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: SearchTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    func setViewModel() {
        viewModel.searchSuccess = { [weak self] model in
            guard let self = self else { return }
            
            
            self.searchResult = model
            self.tableView.reloadData()
        }
        
        viewModel.searchFailed = { [weak self] msg in
            guard let self = self else { return }
            
            self.showError(message: msg)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.doSearch(txt: searchTextField.text ?? "")
        view.endEditing(true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell {
            
            guard let result = searchResult else { return UITableViewCell() }
            
            cell.setLabel(model: result.items[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: searchResult?.items[indexPath.row].html_url ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
}

extension UIViewController {
    public func showError(title: String? = nil, message: String? = nil) {
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true)
    }
}
