import Foundation

final class FlashSaleService {
    // MARK: - Singleton
    static let shared = FlashSaleService()
    private init() {}
    
    // MARK: - Static properties
    static let didChangeNotification = Notification.Name(rawValue: "FlashSaleServiceDidChange")
   
    // MARK: - Private enum
    private enum HttpMethods: String {
        case get = "GET"
    }
    
    // MARK: - Private properties
    private let urlSession = URLSession.shared
    
    //указатель на активную задачу, если задач нет, значение = nil. Значение присваивается до task.resume(), при успешном выполнении обнуляется
    private var task: URLSessionTask?
    private(set) var flashSaleProducts: [ProducCelltModel] = []
    
    private var flashSaleRequest: URLRequest? {
        let urlString = "https://run.mocky.io"
        guard let url = URL(string: urlString) else { return nil }
        let request = URLRequest.makeHTTPRequest(
            path: "/v3" + "/a9ceeb6e-416d-4352-bde6-2203416576ac",
            httpMethod: HttpMethods.get.rawValue,
            baseURL: url)
        return request
    }
    
    // MARK: - Public properties
    func fetchLatestProducts() {
        assert(Thread.isMainThread)
        task?.cancel()
        
        guard let request = flashSaleRequest else { return }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<FlashSaleModel, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let flashSaleModel):
                    flashSaleModel.flashSale.forEach { result in
                        let latestProduct = self.getProduct(from: result)
                        self.flashSaleProducts.append(latestProduct)
                    }
                    NotificationCenter.default.post(
                        name: FlashSaleService.didChangeNotification,
                        object: self,
                        userInfo: ["flashSaleProducts" : self.flashSaleProducts])
                case .failure(let error):
                    print(error)
                }
                self.task = nil
            }
        }
    
        self.task = task
        task.resume()
    }
    
    
    // MARK: - Private methods
    private func getProduct(from result: FlashSaleProduct) -> ProducCelltModel {
        let productCell = ProducCelltModel(
            category: result.category,
            name: result.name,
            price: Int(result.price),
            discount: result.discount,
            imageURL: result.imageURL
        )
        return productCell
    }
}

