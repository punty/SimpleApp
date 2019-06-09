# SimpleApp
App architecture: MVVM + C (Using RxSwift)
## App Structure
- **Core**: It contains a collection of reusable components and interfaces (not necessary related to the Sample App). I didn't use Realm or Rx in this folder because I don't want to enforce this choices to the client who is using this API. The main components of this layer are: ServiceClientProtocol and PersistenceServiceProtocol plus some base App architecture class like Coordinator. In a real project this would be extracted in a separeted framework 
- **RealmPersistenceLayer**: Implement PersistenceServiceProtocol using Realm. Also this folder doesn't have any code related to the main app and it's intended to be used as a 'Plugin'. In other project I would create a CoreData plugin if needed. In real app also this folder would be a separate component
- **ServiceAdapters**: Rx wrappers around PersistenceServiceProtocol ServiceClientProtocol
