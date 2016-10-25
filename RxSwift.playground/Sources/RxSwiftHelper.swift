import Foundation
import PlaygroundSupport

public func run(_ description: String, action: () -> Void)
{
    print("========\ttesting\t" + description + "\t========\n")
    action()
}

private func delay(_ interval: TimeInterval, action: @escaping () -> Void)
{
    let delayTime = DispatchTime.now() + DispatchTimeInterval.seconds(Int(interval))
    DispatchQueue.main.asyncAfter(deadline: delayTime) { action() }
}

public func runInfinite()
{
    PlaygroundPage.current.needsIndefiniteExecution = true;
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
