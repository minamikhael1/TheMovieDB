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

    init(viewModel: NowPlayingViewModel) {
         super.init(nibName: String(describing: NowPlayingViewController.self), bundle: nil)
         self.viewModel = viewModel
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
        navigationItem.titleView = UIImageView(image: UIImage(named: "tmdb"))
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        setUpTableView()
    }

    private func setUpTableView() {
        tableView.register(UINib(nibName: MovieCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MovieCell.cellIdentifier)
        tableView.register(UINib(nibName: LoadingCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: LoadingCell.cellIdentifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }

    private func showErrorAlert() {
        let alert = SingleButtonAlert(title: "Unknown Error", message: "please try again later.", action: AlertAction(buttonTitle: "OK", handler: {}))
        self.presentSingleButtonDialog(alert: alert)
    }

    //MARK:- Data binding
    private func bindViewModel() {
        viewModel?.nowPlayingList.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView?.reloadData()
            }
        }
        viewModel?.state.bind({[weak self] state in
            switch state {
            case .error(_):
                self?.showErrorAlert()
            case .loading, .finishedLoading:
                break
            }
        })
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension NowPlayingViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // 2nd section of infinite loading
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel?.nowPlayingList.value.count ?? 0
        } else if section == 1 {
            return 1 // For infinite loading cell
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.cellIdentifier) as? MovieCell else { return UITableViewCell() }
            let movie = viewModel?.nowPlayingList.value[indexPath.row]
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
//        viewModel?.didSelectItemAt(index: indexPath.row)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height) && viewModel?.state.value != .loading {
            viewModel?.fetchNowPlaying()
        }
    }
}

//MARK:- UISearchBarDelegate
extension NowPlayingViewController: UISearchBarDelegate {

}
