//
//  HorizontalCollectionViewCell.swift
//  Course App
//
//  Created by macbook on 19.05.2024.
//
import SwiftUI
import UIKit

final class HorizontalScrollingCollectionViewCell: UICollectionViewCell {
    // MARK: UI items
    private lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout())
    var images: [UIImage?] = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SETUP UI
private extension HorizontalScrollingCollectionViewCell {
    func setupUI() {
        setupCollectionView()
        addSubviews()
        setupConstraints()
    }

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing =  5
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviews() {
        addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension HorizontalScrollingCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // let cell = collectionView.dequeueReusableCell(for: indexPath) as ImageCollectionViewCell
        // cell.imageView.image = images[indexPath.item]
        // return cell
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.contentConfiguration = UIHostingConfiguration {
            Image(uiImage: images[indexPath.row] ?? UIImage())
                .resizableBordered(cornerRadius: 10)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HorizontalScrollingCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

// MARK: - UICollectionViewDelegate
extension HorizontalScrollingCollectionViewCell: UICollectionViewDelegate {
}

extension UICollectionViewCell: ReusableIdentifier {
}
