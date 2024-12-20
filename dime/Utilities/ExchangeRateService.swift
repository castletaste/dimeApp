import Foundation

struct ExchangeRateResponse: Codable {
    let result: String
    let conversion_rate: Double
}

class ExchangeRatesService {
    static let shared = ExchangeRatesService()

    private init() {}

    func convertCurrency(
        amount: Double, from: String, to: String,
        completion: @escaping (Result<Double, Error>) -> Void
    ) {
        let apiKey =
            UserDefaults(suiteName: "group.wtf.savva.dime")?.string(forKey: "exchangeRatesApiKey")
            ?? ""

        guard !apiKey.isEmpty else {
            completion(.failure(ExchangeRateError.noApiKey))
            return
        }

        let url = URL(string: "https://v6.exchangerate-api.com/v6/\(apiKey)/pair/\(from)/\(to)")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(ExchangeRateError.noData))
                return
            }

            do {
                let response = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
                let convertedAmount = amount * response.conversion_rate
                completion(.success(convertedAmount))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

enum ExchangeRateError: Error {
    case noApiKey
    case noData

    var localizedDescription: String {
        switch self {
        case .noApiKey:
            return "Exchange Rates API key is not set. Please set it in Settings."
        case .noData:
            return "No data received from Exchange Rates API."
        }
    }
}
