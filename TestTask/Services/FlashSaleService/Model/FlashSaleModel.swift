import Foundation

struct FlashSaleModel: Decodable {
    let flashSale: [FlashSaleProduct]

    enum CodingKeys: String, CodingKey {
        case flashSale = "flash_sale"
    }
}

struct FlashSaleProduct: Decodable {
    let category, name: String
    let price: Double
    let discount: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case category, name, price, discount
        case imageURL = "image_url"
    }
}

