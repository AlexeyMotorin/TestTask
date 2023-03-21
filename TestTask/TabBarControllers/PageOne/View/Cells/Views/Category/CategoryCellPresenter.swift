import UIKit

protocol CategoryCellPresenterProtocol: AnyObject {
    var cellView: CategoryTableViewCellProtocol? { get set }
}


final class CategoryCellPresenter: NSObject {
    weak var cellView: CategoryTableViewCellProtocol?
   
    var categoryCell: [CategoryProductModel] = [
        CategoryProductModel(nameCategory: "Phones", imageString: "Phones"),
        CategoryProductModel(nameCategory: "Headphones", imageString: "Headphones"),
        CategoryProductModel(nameCategory: "Games", imageString: "Games"),
        CategoryProductModel(nameCategory: "Cars", imageString: "Cars"),
        CategoryProductModel(nameCategory: "Furniture", imageString: "Furniture"),
        CategoryProductModel(nameCategory: "Kids", imageString: "Kids"),
    ]
}

extension CategoryCellPresenter: CategoryCellPresenterProtocol {}

extension CategoryCellPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as? CategoryCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let cellModel = categoryCell[indexPath.row]
        cell.configure(with: cellModel)
            
        return cell
    }
}

extension CategoryCellPresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Выбрана категория \(categoryCell[indexPath.row].nameCategory)")
    }
}

extension CategoryCellPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 20) / 7
        return CGSize(width: width, height: width + 30)
    }
}
