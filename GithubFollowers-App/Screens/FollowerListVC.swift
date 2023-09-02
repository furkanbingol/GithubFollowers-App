//
//  FollowerListVC.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 24.08.2023.
//

import UIKit

class FollowerListVC: UIViewController {
    
    // enums are 'Hashable' by default
    enum Section {
        case main
    }

    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var searchBarIsHidden = false
    
    var page = 1
    var hasMoreFollowers = true
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!      // DiffableDataSource: iOS13+
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: true)   // not use: (.isNavigationBarHidden = true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBarToggle(searchBarIsHidden)
    }
    
    
    // MARK: - Functions
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width                            = view.bounds.width
        let padding: CGFloat                 = 12         // left and right padding
        let minimumItemSpacing: CGFloat      = 10
        let availableWidth                   = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                        = availableWidth / 3
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)     // +40 = for label
        layout.minimumInteritemSpacing = minimumItemSpacing
        
        return layout
    }
    
    // for SearchController
    private func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.delegate                     = self
        searchController.searchBar.placeholder                  = "Search for a username"
        searchController.searchBar.autocapitalizationType       = .none
        searchController.searchBar.autocorrectionType           = .no
        navigationItem.hidesSearchBarWhenScrolling              = false
        
        navigationItem.searchController = searchController
    }
    
    private func searchBarToggle(_ searchBarIsHidden: Bool) {
        if searchBarIsHidden {
            navigationItem.hidesSearchBarWhenScrolling = true
        } else {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        
        // background thread (in closure)
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in     // [weak self]: avoid memory leak
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.isEmpty && self.followers.isEmpty {
                    DispatchQueue.main.async {
                        let message = "This user doesn't have any followers. Go follow them 🙂"
                        self.showEmptyStateView(with: message, in: self.view)
                        return
                    }
                }
                else if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers += followers
                self.updateData(followers: self.followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: itemIdentifier)      // itemIdentifier = follower
            return cell
        })
    }
    
    private func updateData(followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
}

extension FollowerListVC: UICollectionViewDelegate {
    
    // Fetch next 100 users
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
        
//    ## ANOTHER WAY TO DO PAGINATION (Good Solution) ##
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.item == followers.count - 1 {
//            guard hasMoreFollowers else { return }
//            page += 1
//            getFollowers(username: username, page: page)
//        }
//    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        searchBarIsHidden = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBarIsHidden = true
    }
    
}

// Search Controller Delegate
extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(followers: self.followers)
            return
        }
        
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(followers: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(followers: self.followers)
    }
    
}
