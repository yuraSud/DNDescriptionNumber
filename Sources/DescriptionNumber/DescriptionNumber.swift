import Combine

public class DescriptionNumber {
    
    private let networkManager = NetworkManager()
   
    public init() {}
    
    public func fetchNumber(typeRequest: TypeRequest, _ inputedNumbers: String) -> AnyPublisher<NumberModel, Error> {
        let isMath = typeRequest == TypeRequest.random
        return networkManager.fetchNumber(inputedNumbers, type: NumberModel.self, mathRequest: isMath)
    }
    
    public func fetchRangeNumber(_ inputedNumbers: String) -> AnyPublisher<RangeNumbers, Error> {
        return networkManager.fetchNumber(inputedNumbers, type: RangeNumbers.self)
    }
}

