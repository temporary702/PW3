//
//  WishStoringViewController.swift
//  eapakhomovPW2
//
//  Created by Home on 05.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = []
    private let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        defaults.array(forKey: Constants.wishesKey) as? [String]
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId,
                                                 for: indexPath)
        
        guard let wishCell = cell as? WrittenWishCell else { return cell }
        
        wishCell.configure(with: wishArray[indexPath.row])
            
        return wishCell
    }

    
    private func configureTable() {
        view.addSubview(table)
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.backgroundColor = .red
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
    }
}
// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return wishArray.count
    }
    
    func CellForRowAt(indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            return AddWishCell()
        }
        else {
            return WrittenWishCell()
        }
    }
}

final class WrittenWishCell: UITableViewCell {
    static let reuseId: String = "WrittenWishCell"
    
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
    }
    
    private let wishLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        let wrap: UIView = UIView()
        addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        wrap.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        wrap.addSubview(wishLabel)
        
        wishLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        wishLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

final class AddWishCell : UITableViewCell {

}
