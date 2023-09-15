//
//  UserInfoVC.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 2.09.2023.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController {

    weak var delegate: UserInfoVCDelegate?
    
    // MARK: - Properties
    private let headerView  = UIView()
    private let itemViewOne = UIView()
    private let itemViewTwo = UIView()
    private let dateLabel   = GFBodyLabel(textAlignment: .center)
    
    private let scrollView  = UIScrollView()
    private let contentView = UIView()
    
    private var itemViews   = [UIView]()       // include all views except scrollView
    
    var username: String!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        configureNavigationBar()
        layoutUI()
        getUserInfo()
    }
    
    
    // MARK: - Functions
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    
    private func configureNavigationBar() {
        if #available(iOS 15, *) {
            navigationController?.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()
        }
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    @objc private func doneButtonTapped() {
        dismiss(animated: true)
    }

    
    private func configureScrollView() {
        view.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints    = false
        contentView.translatesAutoresizingMaskIntoConstraints   = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // For ContentView, we add also these constraints
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)     // hard code
        ])
    }
    
    
    private func getUserInfo() {
        // background thread (in closure)
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    private func configureUIElements(with user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        let followerItemVC = GFFollowerItemVC(user: user)
        repoItemVC.delegate = self
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
    }
    
    // Adding ChildVC to ContainerView in a ViewController
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    private func layoutUI() {
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        for itemView in itemViews {
            contentView.addSubview(itemView)         // not view.addSubview() --> contentView.addSubview() (for SCROLLVIEW)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension UserInfoVC: GFRepoItemVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(alertTitle: "Invalid URL",
                                       message: "The url attached to this user is invalid",
                                       buttonTitle: "Ok")
            return
        }
        
        presentSafariViewController(with: url)     // in UIViewController+Ext
    }
}

extension UserInfoVC: GFFollowerItemVCDelegate {
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(alertTitle: "No followers",
                                       message: "This user has no followers. What a shame 😞",
                                       buttonTitle: "Ok")
            return
        }
        delegate?.didRequestFollowers(for: user.login)
        dismiss(animated: true)
    }
}
