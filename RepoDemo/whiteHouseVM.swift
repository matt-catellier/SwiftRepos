import Foundation

struct whiteHouseVM {
    var description:String?
    init(add:       NSDictionary) {
        // Reference JSON properties.
        // You could add more here.
        description = add["url_title"] as? String
    }
}
