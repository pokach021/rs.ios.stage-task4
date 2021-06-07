import Foundation

final class CallStation {
    var usersList = Set<User>()
    var callsList = [Call]()
}

extension CallStation: Station {
    func users() -> [User] {
        return Array(usersList)
    }
    
    func add(user: User) {
        usersList.insert(user)
    }
    
    func remove(user: User) {
        usersList.remove(user)
    }
    
    func execute(action: CallAction) -> CallID? {
        switch action {
        case .start(from: let from, to: let to):
            var call: Call
            if !users().contains(from) {
                return nil
            }
            
            
            if !users().contains(to) {
                
                call = Call(id: CallID(), incomingUser: to, outgoingUser: from, status: .ended(reason: .error))
                callsList.append(call)
                return call.id
            }
            if currentCall(user: to) != nil || currentCall(user: from) != nil {
                
                call = Call(id: CallID(), incomingUser: to, outgoingUser: from, status: .ended(reason: .userBusy))
                callsList.append(call)
                return call.id
            }
            
            call = Call(id: CallID(), incomingUser: to, outgoingUser: from, status: .calling)
            callsList.append(call)
            return call.id
            
        case .answer(from: let from):
            guard let currentCall = currentCall(user: from) else {
                return nil
            }
            if !users().contains(from) {
                refreshCallStatus(call: currentCall, callStatus: .ended(reason: .error))
                return nil
            }
            refreshCallStatus(call: currentCall, callStatus: .talk)
            
            return currentCall.id
            
        case .end(from: let from):
            guard let currentCall = currentCall(user: from) else {
                return nil
            }
            if currentCall.status == .calling {
                refreshCallStatus(call: currentCall, callStatus: .ended(reason: .cancel))
            } else {
                refreshCallStatus(call: currentCall, callStatus: .ended(reason: .end))
            }
            return currentCall.id
            
            
        }
    }
    
    func refreshCallStatus(call: Call, callStatus: CallStatus) {
        for (index, value) in callsList.enumerated() {
            if value.id == call.id {
                callsList.remove(at: index)
            }
            let newCall = Call(id: call.id, incomingUser: call.incomingUser, outgoingUser: call.outgoingUser, status: callStatus)
            callsList.append(newCall)
            
        }
    }
    
    func calls() -> [Call] {
        return callsList
    }
    
    func calls(user: User) -> [Call] {
        var result = [Call]()
        for call in callsList {
            if call.incomingUser == user || call.outgoingUser == user {
                result.append(call)
            }
        }
        return result
    }
    
    func call(id: CallID) -> Call? {
        for call in callsList {
            if call.id == id {
                return call
            }
        }
        return nil
    }
    
    func currentCall(user: User) -> Call? {
        for call in callsList {
            if (call.incomingUser == user || call.outgoingUser == user) &&
                (call.status == .calling || call.status == .talk) {
                return call
            }
        }
        return nil
    }
}
