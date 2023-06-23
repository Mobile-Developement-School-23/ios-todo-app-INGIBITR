

import Foundation

protocol DateService {
    func getDate(from string: String) -> Date?
    func getString(from date: Date) -> String
    func getNextDay() -> Date?
}
