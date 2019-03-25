//
//  DashboardViewController.swift
//  Money*
//
//  Created by tran.duc.tan on 3/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit
import Firebase
import Then
import Reusable

final class DashboardViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var walletCollectionView: UICollectionView!
    @IBOutlet private var walletPageControl: UIPageControl!
    @IBOutlet private var addTransactionButton: UIButton!
    @IBOutlet private var reportButton: UIButton!
    @IBOutlet private var budgetButton: UIButton!
    @IBOutlet private var showAllTransactionsButton: UIButton!
    @IBOutlet private var transactionTableView: UITableView!
    
    // MARK: - Private properties
    private var user: User!
    private var wallets = [Wallet]()
    private var latestTransactions = [Transaction]()
    
    // MARK: - Private functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        registerCustomCells()
        addAuthorizationListener()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Identifier.segueFromDashboardToUserSetting:
            let userSettingViewController = segue.destination as? UserSettingViewController
            userSettingViewController?.user = user
        default:
            return
        }
    }
    
    private func configureSubviews() {
        addTransactionButton.makeRoundedAndShadowed()
        showAllTransactionsButton.makeRounded()
        reportButton.makeRoundedAndShadowed(cornerRadius: reportButton.frame.height / 2)
        budgetButton.makeRoundedAndShadowed(cornerRadius: budgetButton.frame.height / 2)
        
        [reportButton, budgetButton].forEach {
            $0?.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        
        walletCollectionView.do {
            $0.collectionViewLayout = CardFlowLayout()
            $0.dataSource = self
            $0.delegate = self
        }
        
        transactionTableView.do {
            $0.dataSource = self
            $0.delegate = self
        }
        
        walletPageControl.do {
            $0.numberOfPages = 0
            $0.currentPage = 0
        }
    }
    
    private func registerCustomCells() {
        walletCollectionView.register(cellType: WalletCollectionViewCell.self)
        transactionTableView.register(cellType: TransactionTableViewCell.self)
    }
    
    private func addAuthorizationListener() {
        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            guard let user = user else {
                self?.dismiss(animated: true, completion: nil)
                return
            }
            self?.user = User(auth: user)
        }
    }
    
    private func fetchData() {
        Firestore.firestore()
            .collection(user.email)
            .order(by: "name")
            .addSnapshotListener(includeMetadataChanges: true) { [weak self] (querySnapshot, _) in
                guard let self = self else { return }
                guard let snapshot = querySnapshot else {
                    self.presentErrorAlert(title: Constant.titleError, message: Constant.messageSnapshotError)
                    return
                }
                
                self.wallets = []
                for document in snapshot.documents {
                    if let model = Wallet(snapshot: document) {
                        self.wallets.append(model)
                    } else {
                        self.presentErrorAlert(title: Constant.titleError, message: Constant.messageDataError)
                    }
                }
                
                self.walletPageControl.numberOfPages = self.wallets.count
                self.walletCollectionView.reloadData()
                self.fetchTransactionData()
        }
    }
    
    private func fetchTransactionData() {
        wallets[walletPageControl.currentPage]
            .ref?
            .collection("transactions")
            .limit(to: Constant.transactionLastestNumRecords)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener(includeMetadataChanges: true) { [weak self] (querySnapshot, _) in
                guard let self = self else { return }
                guard let snapshot = querySnapshot else {
                    self.presentErrorAlert(title: Constant.titleError, message: Constant.messageSnapshotError)
                    return
                }
                
                self.latestTransactions = []
                for document in snapshot.documents {
                    if let model = Transaction(snapshot: document) {
                        self.latestTransactions.append(model)
                    } else {
                        self.presentErrorAlert(title: Constant.titleError, message: Constant.messageDataError)
                    }
                }
                
                self.transactionTableView.reloadData()
        }
    }
    
    // MARK: - IBActions
    @IBAction func handleUserButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: Identifier.segueFromDashboardToUserSetting, sender: nil)
    }
}

// MARK: - CollectionView Data Source
extension DashboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallets.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as WalletCollectionViewCell
        cell.configure(for: wallets[indexPath.item])
        return cell
    }
}

// MARK: - CollectionView Delegate
extension DashboardViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let midX = scrollView.bounds.midX
        let midY = scrollView.bounds.midY
        let point = CGPoint(x: midX, y: midY)
        
        guard let indexPath = walletCollectionView.indexPathForItem(at: point) else { return }
        
        walletPageControl.currentPage = indexPath.item
        fetchTransactionData()
    }
}

// MARK: - CollectionView Layout
extension DashboardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constant.walletCollectionCellWidth,
                      height: Constant.walletCollectionCellHeight)
    }
}

// MARK: - TableView Data Source
extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TransactionTableViewCell
        cell.configure(for: latestTransactions[indexPath.row])
        return cell
    }
}

// MARK: - TableView Delegate
extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.transactionCellHeight
    }
}
