import Foundation

protocol EventType {
    var name: String { get }
}

protocol AnalyticEvent {
    associatedtype AnalyticType: EventType
    var type: AnalyticType { get }
    var parameters: [String: Any] { get }
}

extension AnalyticEvent {
    var name: String {
        return type.name
    }
}

struct ScreenViewEvent: AnalyticEvent {
    let type: ScreenViewEventType
    let parameters: [String: Any]
}

enum ScreenViewEventType: EventType {
    case home
    case profile
    case settings
    
    var name: String {
        switch self {
        case .home: return "Home"
        case .profile: return "Profile"
        case .settings: return "Settings"
        }
    }
}

struct UserActionEvent: AnalyticEvent {
    let type: UserActionEventType
    let parameters: [String: Any]
}

enum UserActionEventType: EventType {
    case tap
    case swipe
    
    var name: String {
        switch self {
        case .tap: return "Tap"
        case .swipe: return "Swipe"
        }
    }
}

protocol AnalyticsService {
    func logEvent<Event: AnalyticEvent>(_ event: Event)
}

class ConsoleAnalyticsService: AnalyticsService {
    private var loggedEvents: [String] = []
    
    func logEvent<Event: AnalyticEvent>(_ event: Event) {
        let eventName = event.name
        print(eventName)
        loggedEvents.append(eventName)
    }
}

// Example usage:
let analyticsService = ConsoleAnalyticsService()


// Log screen view event
let screenViewEvent = ScreenViewEvent(type: .home, parameters: ["source": "button"])
analyticsService.logEvent(screenViewEvent)

// Log user action event
let userActionEvent = UserActionEvent(type: .tap, parameters: ["button": "submit"])
analyticsService.logEvent(userActionEvent)
