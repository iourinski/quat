import jester, asyncdispatch, htmlgen

routes:
  get "/":
    #attachment "public/FF4D00-0.8.png"
    var str = ""
    for x in request.headers.pairs:
        str = str & x.key & ": " & x.value & "<br/>"
    resp repr(str)
runForever()
