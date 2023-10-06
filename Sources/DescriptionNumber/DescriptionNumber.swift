
import Combine

@available(macOS 10.15, *)
public class DescriptionNumber {
    
    @Published var oneNumberDescription = NumberModel()
    @Published var rangeNumbersDescription: [String:String] = [:]
    
    private let networkManager = NetworkManager()
    private var cancellable: Set<AnyCancellable> = []
    
    public init() {}
    
    public func fetchNumber(typeRequest: TypeRequest, _ inputedNumbers: String) -> AnyPublisher<NumberModel, Error> {
         let isMath = typeRequest == TypeRequest.random
            
       return networkManager.fetchNumber(inputedNumbers, type: NumberModel.self, mathRequest: isMath)
    }
    
    public func fetchRangeNumber(_ inputedNumbers: String, completionError: @escaping (Error)->()) {
        networkManager.fetchNumber(inputedNumbers, type: RangeNumbers.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    completionError(error)
                case .finished: break
                }
            }, receiveValue: { value in
                self.rangeNumbersDescription = value
            })
            .store(in: &cancellable)
    }
}

