import XCTest
import Combine
@testable import DescriptionNumber

final class DescriptionNumberTests: XCTestCase {
   
    var descriptionNumber: DescriptionNumber?
    var cancellable = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        descriptionNumber = DescriptionNumber()
    }
    
    override func tearDown() {
        descriptionNumber = nil
        cancellable.removeAll()
        super.tearDown()
    }
    
    func testFetchDescriptionNumber() {
        
        let expectation = XCTestExpectation(description: "Fetch DescriptionNumber")
       
        descriptionNumber?.fetchNumber(typeRequest: .year, "4/23")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Expected successful fetch, but got error: \(error)")
                }
            }, receiveValue: { numberModel in
                let answerFromServer = numberModel.text ?? ""
                let firstWord = answerFromServer.prefix(5)
                XCTAssertNotNil(numberModel.text)
                XCTAssert(!answerFromServer.isEmpty)
                XCTAssertEqual(firstWord, "April")
                expectation.fulfill()
            })
            .store(in: &cancellable)

        wait(for: [expectation], timeout: 15.0)
    }
    
    func testFetchRangeNumbersViewModel() {
        
        let expectation = XCTestExpectation(description: "Fetch RangeNumber")

        descriptionNumber?.fetchRangeNumber("10..15")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Expected successful fetch, but got error: \(error)")
                }
            }, receiveValue: { value in
                XCTAssert( value.count > 2 )
                XCTAssertFalse(value.isEmpty)
                XCTAssertEqual(value.keys.count, 6)
                expectation.fulfill()
            })
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 5.0)
    }
}


