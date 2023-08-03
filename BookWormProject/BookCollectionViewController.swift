//
//  BookCollectionViewController.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit

private let reuseIdentifier = "Cell"

class BookCollectionViewController: UICollectionViewController {
    
    let searchBar = UISearchBar()
    
    
    var movieInfo = MovieInfo() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var searchList: [Movie]! {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    var color: [UIColor] = [.purple, .systemBrown, .orange, .darkGray, .blue, .systemRed, .systemIndigo, .systemTeal, .systemMint]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.placeholder = "영화를 검색해주세요"
        searchBar.showsCancelButton = true
        
        searchList = movieInfo.movie
        
        navigationItem.titleView = searchBar
        //title = "책장"
        
        let nib = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        setCollectionViewLayout()
        color.shuffle()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
    }
    
    
//
//    @IBAction func searchBarButtonClicked(_ sender: UIBarButtonItem) {
//
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: SearchViewController.identifier) as! SearchViewController
//
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//
//        present(nav, animated: true)
//
//
//    }
    
    
    func setCollectionViewLayout() {
        
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        
        collectionView.collectionViewLayout = layout //레이아웃 교체하려는 것으로 바꾸기
        
    }

   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
            return BookCollectionViewCell()
        }
        
        let movie = searchList[indexPath.row] //movieInfo.movie[indexPath.row]
        cell.configCell(movie: movie)
        cell.backgroundColor = color[indexPath.row]
        cell.layer.cornerRadius = 20
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
        
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        
        movieInfo.movie[sender.tag].like.toggle()
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: DetailViewController.identifier) as! DetailViewController
        
        vc.transition = .push
        vc.movieInfo = movieInfo.movie[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
        
    }

  

}


extension BookCollectionViewController: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchList.removeAll()
        for movie in movieInfo.movie {
            if movie.title.contains(searchBar.text!) {
                searchList.append(movie) //영화 객체를 담음
            }
        }
        //collectionView.reloadData()
        
    }
    

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchList = movieInfo.movie
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList.removeAll()
        
        for movie in movieInfo.movie {
            if movie.title.contains(searchBar.text!) {
                searchList.append(movie) //영화 객체를 담음
            }
        }
        
        if searchText.count == 0 {
            searchList.removeAll()
            searchList = movieInfo.movie
        }
        //collectionView.reloadData()
    }
    
}
