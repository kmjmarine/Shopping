//
//  ShopListTableViewCell.swift
//  Shopping
//
//  Created by kmjmarine on 2022/06/01.
//

import UIKit
import SnapKit
import Kingfisher

final class ShopListTableViewCell: UITableViewCell {
    static let identifier = "ShopListTableViewCell"
    
//    private lazy var imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        imageView.backgroundColor = .secondarySystemBackground
//        
//        return imageView
//    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        
        return label
    }()
    
    private lazy var lpriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = .systemRed
        
        return label
    }()
    
    private lazy var hpriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = .systemRed
        
        return label
    }()
    
    private lazy var mallNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        
        return label
    }()
    
    private lazy var makerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        
        return label
    }()
    
    private lazy var brandLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        
        return label
    }()
    
    func setup(shop: Shop) {
        setupLayout()
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        titleLabel.text = shop.title.htmlToString
    }
}

private extension ShopListTableViewCell {
    func setupLayout() {
        [titleLabel, lpriceLabel, hpriceLabel, mallNameLabel, makerLabel, brandLabel]
            .forEach { addSubview($0) }
        
        let superViewInset: CGFloat = 16.0
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(superViewInset)
            $0.trailing.equalToSuperview().inset(superViewInset)
            $0.top.equalToSuperview().inset(superViewInset)
        }
    }
}
