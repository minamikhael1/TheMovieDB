//
//  NowPlayingViewController.swift
//  TheMovieDB
//
//  Created by Mina Mikhael on 27.05.20.
//  Copyright © 2020 MoviesDB. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    //MARK:- Variables
    private var viewModel: NowPlayingViewModel?
    private var searchViewModel: SearchViewModel?
    private var searchWaitTimer: Timer?
    private var searchMode = false

    init(viewModel: NowPlayingViewModel, searchViewModel: SearchViewModel) {
        super.init(nibName: String(describing: NowPlayingViewController.self), bundle: nil)
        self.viewModel = viewModel
        self.searchViewModel = searchViewModel
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    //MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        viewModel?.fetchNowPlaying()
    }

    //MARK:- Helpers
    private func setupView() {
        setupNavigation()
        setUpTableView()
    }

    private func setupNavigation() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "tmdb"))
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setUpTableView() {
        tableView.register(UINib(nibName: MovieCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MovieCell.cellIdentifier)
        tableView.register(UINib(nibName: LoadingCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: LoadingCell.cellIdentifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }

    //MARK:- Data binding
    private func bindViewModel() {
        viewModel?.nowPlayingList.bind {[weak self] _ in
            DispatchQueue.main.async {
                self?.tableView?.reloadData()
            }
        }
        viewModel?.state.bind({[weak self] state in
            switch state {
            case .error(let error):
                self?.presentNetworkError(error: error)
            case .loading, .finishedLoading:
                break
            }
        })

        searchViewModel?.searchResult.bind {[weak self] _ in
            DispatchQueue.main.async {
                self?.tableView?.reloadData()
            }
        }

        searchViewModel?.state.bind({[weak self] state in
            switch state {
            case .error(let error):
                self?.presentNetworkError(error: error)
            case .loading, .finishedLoading:
                break
            }
        })
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension NowPlayingViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        if searchMode {
            guard let searchVM = searchViewModel else { return 2 }
            return searchVM.currentPage > searchVM.totalPages ? 1 : 2 // 2nd section for search of infinite scrolling while total pages not reached
        } else {
            guard let viewModel = viewModel else { return 2 }
            return viewModel.currentPage > viewModel.totalPages ? 1 : 2 // 2nd section for now playing of infinite scrolling while total pages not reached
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if searchMode {
                return searchViewModel?.searchResult.value.count ?? 0
            } else {
                return viewModel?.nowPlayingList.value.count ?? 0
            }
        } else if section == 1 {
            return 1 // For infinite loading cell
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.cellIdentifier) as? MovieCell else { return UITableViewCell() }
            var movie: Movie?
            if searchMode {
                movie = searchViewModel?.searchResult.value[indexPath.row]
            } else {
                movie = viewModel?.nowPlayingList.value[indexPath.row]
            }
            cell.movie = movie
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.cellIdentifier) as? LoadingCell else { return UITableViewCell() }
            cell.activityIndicator.startAnimating()
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 55 //Loading Cell height
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var movie: Movie?
        if searchMode {
            movie = searchViewModel?.searchResult.value[indexPath.row]
        } else {
            movie = viewModel?.nowPlayingList.value[indexPath.row]
        }
        guard let theMovie = movie else { return }
        MovieDetailCoordinator(navigationController: self.navigationController ?? UINavigationController(), movie: theMovie).show()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height) && viewModel?.state.value != .loading {
            if searchMode {
                guard let searchText = searchBar.text else { return }
                searchViewModel?.search(query: searchText)
            } else {
                viewModel?.fetchNowPlaying()
            }
        }
    }
}

//MARK:- UISearchBarDelegate
extension NowPlayingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text?.isEmpty == true {
            stopSearchTimer()
            searchMode = false
        } else {
            searchMode = true
            startSearchTimer()
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == nil || searchBar.text?.isEmpty == true {
            resetSearch()
        }
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        resetSearch()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - Search Related
extension NowPlayingViewController {
    private func stopSearchTimer() {
        searchWaitTimer?.invalidate()
        searchWaitTimer = nil
    }

    private func startSearchTimer() {
        stopSearchTimer()
        searchWaitTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: {[weak self] _ in
            self?.performSearch()
        })
    }

    private func performSearch() {
        guard let searchText = searchBar.text else { return }
        stopSearchTimer()
        searchViewModel?.search(query: searchText)
    }

    private func resetSearch() {
        searchMode = false
        searchViewModel?.resetSearch()
    }
}
