//
//  SearchViewController.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher


class SearchViewController: UIViewController {
    
    static let identifier = "SearchViewController"
    
    
    @IBOutlet var tableView: UITableView!
    let searchBar = UISearchBar()
    
    var bookList: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 200
        
        navigationItem.titleView = searchBar
        searchBar.placeholder = "도서를 검색하세요."
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonClicked)
        )
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.identifier)
        //callRequest()
        
    }
    
    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    func callRequest(keyword: String){
        
        let query = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakaoKey)"]
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let searchList = json["documents"]
                for book in searchList.arrayValue {
                    var authorList = ""
                    for aut in book["authors"].arrayValue {
                        authorList += aut.stringValue
                    }
                    self.bookList.append(Book(title: book["title"].stringValue, author: authorList, poster: book["thumbnail"].stringValue, contents: book["contents"].stringValue))
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    

  
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
        
       
        cell.authorLabel.text = bookList[indexPath.row].author
        cell.bookImageView.kf.setImage(with: URL(string: bookList[indexPath.row].poster))
        cell.titleLabel.text = bookList[indexPath.row].title
        
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count == 0 {
            bookList.removeAll()
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text)
        
        guard let keyword = searchBar.text?.trimmingCharacters(in: .whitespaces) else {
            return
        }
        
        bookList.removeAll()
        callRequest(keyword: keyword)
        tableView.reloadData()
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        bookList.removeAll()
        tableView.reloadData()
        view.endEditing(true)
        
    }
    
    
    
}
