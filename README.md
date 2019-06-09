# SimpleApp
App architecture: MVVM + C (Using RxSwift)
The main porposure of this demo is create a fully testable, reusable, and clean codebase, following SOLID principles. 
## App Structure
- **Core**: It contains a collection of reusable components and interfaces (not necessary related to the Sample App). I didn't use Realm or Rx in this folder because I don't want to enforce this choices to the client who is using this API. The main components of this layer are: ServiceClientProtocol and PersistenceServiceProtocol plus some base App architecture class like Coordinator. In a real project this would be extracted in a separeted framework 
- **RealmPersistenceLayer**: Implement PersistenceServiceProtocol using Realm. Also this folder doesn't have any code related to the main app and it's intended to be used as a 'Plugin'. In other project I would create a CoreData plugin if needed. In real app also this folder would be a separate component
- **ServiceAdapters**: Rx wrappers around PersistenceServiceProtocol ServiceClientProtocol
- **ApplicationServices**: Application specific classes. The main dependency graph is constructed here
- **Model**: Model classes
- **View**: View Controllers 
- **ViewModel**: View Models

## Tests
I included a tests with few test cases, I didn't write all the test case because this is a demo project

## Many details were ignored when creating this app:
- Localization
- Separate codebase into reusable framework tarteg
- iPad
- Very simple UI/UX

## Details
- Tested on XCode 10.2.1 
