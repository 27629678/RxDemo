import Foundation
import PlaygroundSupport

public func delay(_ interval: TimeInterval, action: @escaping () -> Void)
{
    let delayTime = DispatchTime.now() + DispatchTimeInterval.seconds(Int(interval))
    DispatchQueue.main.asyncAfter(deadline: delayTime) { action() }
}

public func runInfinite()
{
    PlaygroundPage.current.needsIndefiniteExecution = true;
}

public func stopRunInfinite()
{
    PlaygroundPage.current.needsIndefiniteExecution = false;
}

public func stopRun()
{
    PlaygroundPage.current.finishExecution()
}

public func run(_ until: TimeInterval)
{
    run(until, action: {})
}

public func run(_ until: TimeInterval, action: @escaping () -> Void)
{
    runInfinite()
    delay(until) { 
        action()
        stopRun()
    }
}

public func run(_ description: String, action: () -> Void)
{
    run(description, duration: 0, action: action)
}

public func run(_ description: String, duration: Int, action: () -> Void)
{
    if description.characters.count > 0 {
        print("\n\n========\ttesting\t" + description + "\t========\n")
    }
    
    action()
    
    if duration < 1 {
        return
    }
    
    runInfinite()
    delay(TimeInterval(duration)) {
        stopRun()
    }
}
