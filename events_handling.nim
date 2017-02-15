import  
  hashes,
  jester,
  net, 
  pudgeclient, 
  strtabs,  
  times
type PudgeError*  = object of Exception

proc makeUid (ip, screen: string): int = 
  hash(ip & screen)

proc createPudgeKey (event: string, request: Request): string =  
  let 
    age = $(2524608000 - int(toSeconds(getTime()))) 
    url  = request.params.getOrDefault("u")
    screen =  request.params.getOrDefault("s")
    host = request.host
    uid = makeUid(request.ip, screen)
    
  return event & ":" & host & ":" &  age & ":" & $uid & ":" & url 
  
proc recordEvent* (event: string, request: Request, pudge: Socket): bool = 
  let 
    keyValue = createPudgeKey(event, request)
    referrer = request.params.getOrDefault("r")
    #pudge  = newClient("127.0.0.1", 11213)  
    res = pudge.set(keyValue , referrer)
  #pudge.quit()
  if res == false:
    raise newException(PudgeError, "can't write to pudge")
  return res  
  
proc demonstrateEvent*(event: string, request: Request, pudge: Socket): string = 
  let 
    keyValue = createPudgeKey(event, request)
    referrer = request.params.getOrDefault("r")
    #pudge  = newClient("127.0.0.1", 11213)  
 
  let res = pudge.set(keyValue , referrer)
  if res == false:
    #pudge.quit()
    raise newException(PudgeError,"can't write to pudge")
  #pudge.quit()
  return keyValue & ":" & pudge.get(keyValue)
   

