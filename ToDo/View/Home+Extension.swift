//
//  Home+Extension.swift
//  ToDo
//
//  Created by Bhavesh Patel on 27/06/24.
//

import UIKit

extension Home {
    
    func changeCollectionLayout (selectedLayout : LayoutStyle) -> Void {
        selectedLayout == .compositional ? setupCompositionalLayoutCollectionView() : setupFlowLayoutCollectionView()     
    }
    
    func setupFlowLayoutCollectionView () -> Void {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in
            return self.flowLayout()
        }
        
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        
        self.collectionView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "CustomHeaderView")
    }
    
    func setupCompositionalLayoutCollectionView () -> Void {
        self.collectionView.register(UINib(nibName: "RegularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RegularCollectionCell")
        
        self.collectionView.register(UINib(nibName: "ToDoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ToDoCollectionCell")

        self.collectionView.register(UINib(nibName: "CompleteCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CompleteCollectionCell")

        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in
            
            switch sectionIndex {
            case 0 :
                return self.firstSectionLayout()
            case 1 :
                return self.secondSectionLayout()
            default:
                return self.thirdSectionLayout()
            }
            
        }
        
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        
        self.collectionView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "CustomHeaderView")
    }
    
    func firstSectionLayout () -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        
        return section
    }
    
    func secondSectionLayout () -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension: .fractionalHeight(0.23))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerItem]
        
        return section
    }
    
    func thirdSectionLayout () -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 50, trailing: 16)
        
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(55))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        headerItem.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [headerItem]
        
        return section
    }
    
    func flowLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 50, trailing: 16)
        
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(55))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        headerItem.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [headerItem]
        
        return section
    }
}
