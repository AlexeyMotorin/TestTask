import Foundation

final class LatestService {
    // MARK: - Singleton
    static let shared = LatestService()
    private init() {}
    
    // MARK: - Static properties
    static let didChangeNotification = Notification.Name(rawValue: "LatestServiceDidChange")
   
    // MARK: - Private enum
    private enum HttpMethods: String {
        case get = "GET"
    }
    
    // MARK: - Private properties
    private let urlSession = URLSession.shared
    
    //указатель на активную задачу, если задач нет, значение = nil. Значение присваивается до task.resume(), при успешном выполнении обнуляется
    private var task: URLSessionTask?
    private(set) var latests: [ProductCellModel] = []
    
    // MARK: - Public properties
    func fetchLatestProducts() {
        assert(Thread.isMainThread)
        task?.cancel()
        
        guard let request = latestRequest else { return }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<LatestModel, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let latestModel):
                    latestModel.latest.forEach { result in
                        let latestProduct = self.getProduct(from: result)
                        self.latests.append(latestProduct)
                    }
                    NotificationCenter.default.post(
                        name: LatestService.didChangeNotification,
                        object: self,
                        userInfo: ["latests" : self.latests])
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
    private var latestRequest: URLRequest? {
        let urlString = "https://run.mocky.io"
        guard let url = URL(string: urlString) else { return nil}
        
        let request = URLRequest.makeHTTPRequest(
            path: "/v3" + "/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7",
            httpMethod: HttpMethods.get.rawValue,
            baseURL: url)
        return request
    }
    
    private func getProduct(from result: Latest) -> ProductCellModel {
        let latest = ProductCellModel(
            category: result.category,
            name: result.name,
            price: result.price,
            discount: nil,
            imageURL: result.imageURL
        )
        return latest
    }
}

