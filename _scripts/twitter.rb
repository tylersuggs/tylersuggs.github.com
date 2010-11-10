require 'rubygems'
require 'json'
require 'open-uri'

SITE_URL = "http://livingroof.us/"
YOURLS_API = {
  "url" => "http://tysug.gs/yourls-api.php",
  "sig" => "23808a8d51"
}

def short_url(url)
  uri = URI.parse("#{YOURLS_API_URL}?signature=#{YOURLS_API_SIG}&action=shorturl&url=#{url}&format=json")
  json = JSON.parse(uri.open.read)

  return false unless json.has_key? 'shorturl'
  
  json['shorturl']
end