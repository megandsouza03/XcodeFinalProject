class SpeedTest: UIViewController, URLSessionDelegate, URLSessionDataDelegate {
    
    
    typealias speedTestCompletionHandler = (_ megabytesPerSecond: Double? , _ error: Error?) -> Void
    
    var speedTestCompletionBlock : speedTestCompletionHandler?
    var speedTest : Double?
    static var finalSpeed: Double?
    var startTime: CFAbsoluteTime!
    var stopTime: CFAbsoluteTime!
    var bytesReceived: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
    }
    
    func checkForSpeedTest() {
        
        print("Speed Test Called")
        testDownloadSpeedWithTimout(timeout: 1.0)  { (speed, error) in
            print("Download Speed:", speed ?? "NA")
            print("Speed Test Error:", error ?? "NA")
            self.speedTest = speed
            SpeedTest.finalSpeed = speed
            print(speed)
            print(SpeedTest.finalSpeed)
        }
    }
    
    func returnSpeedTestResult() -> Double {
        return SpeedTest.finalSpeed!
    }
    
    func testDownloadSpeedWithTimout(timeout: TimeInterval, withCompletionBlock: @escaping speedTestCompletionHandler) {
        
        guard let url = URL(string: "https://images.apple.com/v/imac-with-retina/a/images/overview/5k_image.jpg") else { return
            print("WTFF")
        }
        
        startTime = CFAbsoluteTimeGetCurrent()
        stopTime = startTime
        bytesReceived = 0
        
        speedTestCompletionBlock = withCompletionBlock
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForResource = timeout
        let session = URLSession.init(configuration: configuration, delegate: self, delegateQueue: nil)
        session.dataTask(with: url).resume()
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        bytesReceived! += data.count
        stopTime = CFAbsoluteTimeGetCurrent()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        let elapsed = stopTime - startTime
        
        if let aTempError = error as NSError?, aTempError.domain != NSURLErrorDomain && aTempError.code != NSURLErrorTimedOut && elapsed == 0  {
            speedTestCompletionBlock?(nil, error)
            return
        }
        
        let speed = elapsed != 0 ? Double(bytesReceived) / elapsed / 1024.0 / 1024.0 : -1
        speedTestCompletionBlock?(speed, nil)
        
    }
    
}

