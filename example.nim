import 
  asyncdispatch, 
  events_handling, 
  hashes, 
  htmlgen, 
  jester, 
  pudgeclient
let pudge = newClient()

routes:
  get "/":
    #[try: 
      var str = recordEvent("HITS", request, pudge)  
    except PudgeError:
      resp Http500, "Can't record"  
    ]#
    resp Http200, "OK"
      
  get "/test":
    
    #let pudge  = newClient("127.0.0.1", 11213)  
    var str = ""
    try:
      str = demonstrateEvent("HITS", request, pudge)      
    except PudgeError:
      resp Http500, "can't record"
    resp $str

runForever()
