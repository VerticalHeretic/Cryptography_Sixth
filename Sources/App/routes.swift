import Vapor

func routes(_ app: Application) throws {

    //MARK: Controllers
    let blockchainController = BlockchainController()
    let websiteController = WebsiteController()
    
    //MARK: Routes registration
    try app.register(collection: blockchainController)
    try app.register(collection: websiteController)
}
