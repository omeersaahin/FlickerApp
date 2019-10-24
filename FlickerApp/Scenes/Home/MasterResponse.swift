import Foundation

struct MasterResponse:Decodable {
	var photos : Photos?
	var stat : String?
}
struct Photos : Decodable {
    var page: Int
    var pages:Int
    var total:Int
}

struct Photo:Decodable {
    var photo: PhotoDetail
    

}
struct PhotoDetail:Decodable {
    var id: String
}





