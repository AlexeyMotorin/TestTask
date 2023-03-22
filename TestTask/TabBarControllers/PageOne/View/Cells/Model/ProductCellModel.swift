import Foundation

struct ProductCellModel {
    let category: String
    let name: String
    let price: Double
    let discount: Int?
    let imageURL: String
    let sellerImageURL: String = "Seller"
}
