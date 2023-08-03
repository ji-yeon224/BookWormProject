//
//  DetailViewController.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"

    var movieInfo: Movie!
    var transition: Transition = .present
    
    @IBOutlet var backView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseInfoLabel: UILabel!
    @IBOutlet var overviewTextView: UITextView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var posterImageView: UIImageView!
    
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var memoTitleLabel: UILabel!
    
    
    var transitionState: String!
    let textViewPlaceholder = "영화에 대한 메모를 입력해보세요!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movieInfo else {
            return
        }
        
        backView.backgroundColor = .systemGray6
        backView.layer.opacity = 80
        
        title = movieInfo.title
        titleLabel.text = movieInfo.title
        posterImageView.image = UIImage(named: movieInfo.title)
        releaseInfoLabel.text = "\(movieInfo.releaseDate) | \(movieInfo.runtime)분"
        
        overviewTextView.text = movieInfo.overview
        overviewTextView.font = .systemFont(ofSize: 15)
        overviewTextView.isEditable = false
        overviewTextView.backgroundColor = .clear
        
        changeLikeButton(like: movieInfo.like)
        
        memoTextView.delegate = self
        memoTextView.isEditable = true
        memoTextView.text = textViewPlaceholder
        memoTextView.textColor = .darkGray
       
        //present로 넘어 온 경우에만 바 버튼 생성하여 dismiss
        if transition == .present {
            addNavBarButton()
        }
    }
    
    
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        movieInfo.like.toggle()
        changeLikeButton(like: movieInfo.like)
    }
    
    func changeLikeButton(like: Bool){
        if like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
    func addNavBarButton(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButton))
    }
    
    @objc func closeButton() {
        dismiss(animated: true)
    }
    
}


extension DetailViewController : UITextViewDelegate {
    
    
   
    //편집이 시작될 때(커서가 시작될 때)
    //placdholder와 textview의 글자가 같다면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textViewPlaceholder == memoTextView.text {
            memoTextView.text = nil
            memoTextView.textColor = .black
        }
    }
    
    
    //편집이 끝날 때(커서가 없어지는 순간)
    //사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자 보이게 설정!
    func textViewDidEndEditing(_ textView: UITextView) {
        if memoTextView.text.isEmpty {
            memoTextView.text = textViewPlaceholder
            memoTextView.textColor = .darkGray
        }
        view.endEditing(true)
    }
  
    
    
    
    
}
