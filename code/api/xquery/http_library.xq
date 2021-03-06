(: Steve Baskauf 2018-11-28 CC0 :)

xquery version "3.1";

(: performs generic HTTP GET :)
declare function local:httpGet
  ( $uri as xs:string ,
    $acceptMime as xs:string )  
   as item()+
    
{
  let $mimeType :=
    if ($acceptMime = '')
    then '*.*'
    else $acceptMime
  
  let $request := <http:request href='{$uri}' method='get'><http:header name='Accept' value='{$mimeType}'/></http:request>
  let $responseXml := http:send-request($request)
  let $statusCode := string($responseXml[1]/@status)
  let $responseBody := $responseXml[2]
  return ($statusCode, $responseBody)
};

local:httpGet('http://api.gbif.org/v1/occurrence/search?recordedBy=William%20A.%20Haber','application/json')
