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
    
    private lazy var thumbNailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        
        return imageView
    }()
    
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
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        
        return label
    }()
    
    func setup(shop: Shop) {
        setupLayout()
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        thumbNailImageView.kf.setImage(with: shop.imageURL)
        titleLabel.text = shop.title.htmlToString
        lpriceLabel.text = shop.lprice.withComma + "원"
        brandLabel.text = shop.brand
        makerLabel.text = shop.maker
        mallNameLabel.text = shop.mallName
    }
}

private extension ShopListTableViewCell {
    func setupLayout() {
        [thumbNailImageView, titleLabel, lpriceLabel, hpriceLabel, mallNameLabel, makerLabel, brandLabel]
            .forEach { addSubview($0) }
        
        let superViewInset: CGFloat = 16.0
        
        thumbNailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(superViewInset)
            $0.top.equalToSuperview().inset(superViewInset)
            $0.width.equalTo(50)
            $0.height.equalTo(thumbNailImageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbNailImageView.snp.trailing).offset(superViewInset)
            $0.trailing.equalToSuperview().inset(superViewInset)
            $0.top.equalToSuperview().inset(superViewInset)
        }
        
        let verticalSpacing: CGFloat = 4.0
        
        lpriceLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing)
        }
        
        brandLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.top.equalTo(lpriceLabel.snp.bottom).offset(verticalSpacing)
            $0.bottom.equalToSuperview().inset(superViewInset)
        }
        
        makerLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(superViewInset * 3.0)
            $0.top.equalTo(brandLabel.snp.top)
            $0.bottom.equalToSuperview().inset(superViewInset)
        }
    }
}
