//
//  HomeViewController.swift
//  Course App
//
//  Created by macbook on 17.05.2024.
//
import UIKit
import Combine
import SwiftUI
// swiftlint:disable force_cast
final class CategoriesViewController: UIViewController {
    private lazy var categoriesCollectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    // MARK: DataSource
    private lazy var dataProvider = MockDataProvider()
    typealias DataSource = UICollectionViewDiffableDataSource<SectionData, Joke>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionData, Joke>
    private lazy var dataSource = makeDataSource()
    private lazy var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        title = "Categories"
    }
}
// MARK: - UICollectionViewDataSource
private extension CategoriesViewController {
    func readData() {
        dataProvider.$data.sink { [weak self] data in
            print(data)
            self?.applySnapshot(data: data, animatingDifferences: true)
        }
        .store(in: &cancellables)
    }
    func applySnapshot(data: [SectionData], animatingDifferences: Bool = true) {
        guard dataSource.snapshot().numberOfSections == 0 else {
            let snapshot = dataSource.snapshot()
            dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
            return
        }
        var snapshot = Snapshot()
        snapshot.appendSections(data)
        data.forEach { section in
            snapshot.appendItems(section.jokes, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: categoriesCollectionView) { collectionView, indexPath, _ in
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let horizontalCell: HorizontalScrollingCollectionViewCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(
                    describing: HorizontalScrollingCollectionViewCell.self)
                , for: indexPath) as! HorizontalScrollingCollectionViewCell
            horizontalCell.images = section.jokes.map { $0.image }
            return horizontalCell
        }
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            // Vytvoříme vlastní UICollectionReusableView
               let headerView = collectionView.dequeueReusableSupplementaryView(
                   ofKind: kind,
                   withReuseIdentifier: "SectionHeader",
                   for: indexPath)
               // Přidáme SwiftUI view do obsahu hlavičky
               let hostingController = UIHostingController(rootView: SectionHeaderView(title: section.title))
               headerView.addSubview(hostingController.view)
               hostingController.view.translatesAutoresizingMaskIntoConstraints = false
               return headerView
        }
        return dataSource
    }
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indextPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 3.4)
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
}

// MARK: - UICollectionViewDelegate
extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("I have tapped \(indexPath)")
    }
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("will display \(indexPath)")
    }
}

// MARK: - UI setup
private extension CategoriesViewController {
    func setup() {
        setupCollectionView()
        readData()
    }
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = false
        categoriesCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        categoriesCollectionView.backgroundColor = .bg
        categoriesCollectionView.showsVerticalScrollIndicator = false
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = dataSource
                categoriesCollectionView.register(
            HorizontalScrollingCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: HorizontalScrollingCollectionViewCell.self))
        categoriesCollectionView.register(UICollectionReusableView.self,
                                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                          withReuseIdentifier: "SectionHeader")

        view.addSubview(categoriesCollectionView)
    }
}
