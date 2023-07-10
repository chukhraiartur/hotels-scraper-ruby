require 'httpx'
require 'geocoder'
require 'json'

def get_location_boundaries(location)
  results = Geocoder.search(location)
  if results.any?
    bounding_box = results.first.boundingbox
    return {
      south: bounding_box[0],
      north: bounding_box[1],
      west: bounding_box[2],
      east: bounding_box[3]
    }
  else
    return nil
  end
end

location = "Austin, TX"
boundaries = get_location_boundaries(location)
pages = 1


data = []

pages.times do |page|
  params = {
    'searchQueryState'=> "{'pagination':{'currentPage':#{page+1}},'usersSearchTerm':'#{location}','mapBounds':{'west':#{boundaries[:west]},'east':#{boundaries[:east]},'south':#{boundaries[:south]},'north':#{boundaries[:north]}},'isMapVisible':true,'filterState':{'sortSelection':{'value':'globalrelevanceex'},'isAllHomes':{'value':true}},'isListVisible':true}",
    'wants'=>"{'cat1':['listResults','mapResults'],'cat2':['total']}"
  }
  
  headers = {
    'authority'=> 'www.zillow.com',
    'accept'=> '*/*',
    'accept-language'=> 'en,en-US;q=0.9,ru-RU;q=0.8,ru;q=0.7,uk-UA;q=0.6,uk;q=0.5,ko;q=0.4',
    'cookie'=> 'x-amz-continuous-deployment-state=AYABeBPCyxh%2FtV3ndFiEopuLkc8APgACAAFEAB1kM2Jsa2Q0azB3azlvai5jbG91ZGZyb250Lm5ldAABRwAVRzA3MjU1NjcyMVRZRFY4RDcyVlpWAAEAAkNEABpDb29raWUAAACAAAAADH1mcJyxe8LBDsaTsQAwWkWY1YE9Vg9QiAAAGbVDZ9XK4A1EbU+k9W%2FzfpIovzqXO2A7LGb1jBYlxZBDE1duAgAAAAAMAAQAAAAAAAAAAAAAAAAAAEWXwdx0JRTVvFy9Fr+KCdP%2F%2F%2F%2F%2FAAAAAQAAAAAAAAAAAAAAAQAAAAxTIiwcs8H4sMMz2PjKDnBXAiDZncZHw3PvYn8e; zguid=24|%24a56b338d-f92c-4ccb-b334-4efdd580e802; zgsession=1|453f6061-fc42-4794-8e2f-914e4e169400; _ga=GA1.2.2013362999.1688071091; _gid=GA1.2.1787365664.1688071091; zjs_anonymous_id=%22a56b338d-f92c-4ccb-b334-4efdd580e802%22; zjs_user_id=null; zg_anonymous_id=%2283081c88-9703-45ab-a6db-799d78b7e407%22; _gcl_au=1.1.516648724.1688071092; DoubleClickSession=true; pxcts=ddb7627c-16bc-11ee-a1e9-6f7572656f52; _pxvid=ddb752fe-16bc-11ee-a1e9-2a066192d200; __pdst=7a49834828314a2ebfd0b660c0fb222e; _pin_unauth=dWlkPU5UaGtaR05tWTJVdE5XRmhNUzAwT1RWa0xXSmxaR1l0TXpoa09UZGhPV001TjJWbA; _clck=c3ci6d|2|fcw|0|1275; JSESSIONID=3400DD8FDEF2FFA9B20C093B2A581BE8; x-amz-continuous-deployment-state=AYABeMcLXeldtbA8bNa5vkeWrTkAPgACAAFEAB1kM2Jsa2Q0azB3azlvai5jbG91ZGZyb250Lm5ldAABRwAVRzA3MjU1NjcyMVRZRFY4RDcyVlpWAAEAAkNEABpDb29raWUAAACAAAAADGvcZ0Zfdec7sns5BgAwNFzier7Cill+0Hk6LdsvJEoyN%2Fw%2FDLdoTA8arr8qk0aWLN89DWBgLPpN+Wx7jqTKAgAAAAAMAAQAAAAAAAAAAAAAAAAAAML%2Fssyv96SOptpqDtseInz%2F%2F%2F%2F%2FAAAAAQAAAAAAAAAAAAAAAQAAAAwEzzVCrFjrkpcgWtTaP8YQEfEHYAdLZXxcjVHw; _pxff_cc=U2FtZVNpdGU9TGF4Ow==; _pxff_cfp=1; _pxff_bsco=1; _hp2_id.1215457233=%7B%22userId%22%3A%224125304492904772%22%2C%22pageviewId%22%3A%222223880998980043%22%2C%22sessionId%22%3A%225897267740547279%22%2C%22identity%22%3Anull%2C%22trackerVersion%22%3A%224.0%22%7D; _hp2_ses_props.1215457233=%7B%22r%22%3A%22https%3A%2F%2Fwww.zillow.com%2Flondon-on%2F2_p%2F%3FsearchQueryState%3D%257B%2522pagination%2522%253A%257B%2522currentPage%2522%253A2%257D%252C%2522usersSearchTerm%2522%253A%2522London%252C%2520ON%2522%252C%2522mapBounds%2522%253A%257B%2522west%2522%253A-81.51838768457031%252C%2522east%2522%253A-80.97868431542969%252C%2522south%2522%253A42.7909887922104%252C%2522north%2522%253A43.10661985271723%257D%252C%2522mapZoom%2522%253A11%252C%2522regionSelection%2522%253A%255B%257B%2522regionId%2522%253A792613%252C%2522regionType%2522%253A6%257D%255D%252C%2522isMapVisible%2522%253Atrue%252C%2522filterState%2522%253A%257B%2522ah%2522%253A%257B%2522value%2522%253Atrue%257D%252C%2522sort%2522%253A%257B%2522value%2522%253A%2522globalrelevanceex%2522%257D%257D%252C%2522isListVisible%2522%253Atrue%257D%22%2C%22ts%22%3A1688123533895%2C%22d%22%3A%22www.zillow.com%22%2C%22h%22%3A%22%2F%22%7D; _px3=c5b3ac419054f6f095664d7e758e736b799504321b2844671c17264ed96fad12:cSXMjSo6Mshwiq+yeOFxMbGeKte4OHnKWUhi8wsUqSSgo4XP8ESYZ1yXe9SwHqBIOuoZRtaV/HlQx9VrDx4uHQ==:1000:pKed4yq90EQ9JrOnZznfWCJHGXTGn+D4vri4AoJRHYzCn4vu/CmgmI2A7Y53/bJ+Dh8MLT+vdFv05cG6B3neX5j8zJJ6b1YOGiO2JgSYLH/ZKMvaKQkl7BM/6oameWvt/oGp57kqTBJm+4LASEc1Pkvk28CScARnVS7+CsuX6YhVJGY2HnUV+8XRASh5J9m0crwTYffTw0dDAvOVBcSKCg==; _uetsid=dd71a85016bc11ee9ad2adfbfc7dcdb3; _uetvid=dd71d5a016bc11eeaabbd795150295d6; _derived_epik=dj0yJnU9UHhFQTBqSVc5SmhLcFJlTmxiUlhZNmJOaVdZTlVpMWYmbj1DcjJIQWxPT0I4LVlIanU0eTZqbVJBJm09MSZ0PUFBQUFBR1NldUtrJnJtPTEmcnQ9QUFBQUFHU2V1S2smc3A9Mg; _clsk=5p6typ|1688123559817|8|0|y.clarity.ms/collect; _gat=1; AWSALB=Elz+8VAnzm3jugxL5zRjRD0w4Uk58RBZ/S/OLxB/6ibrXgLIY16YcKLGLAZA+59o7CrbMjJw4jh29JiDI+0RxEfKMCCtXtfyQCOy1ZD8xO29q2TPmlt/lOeiEQwR; AWSALBCORS=Elz+8VAnzm3jugxL5zRjRD0w4Uk58RBZ/S/OLxB/6ibrXgLIY16YcKLGLAZA+59o7CrbMjJw4jh29JiDI+0RxEfKMCCtXtfyQCOy1ZD8xO29q2TPmlt/lOeiEQwR; search=6|1690715577944%7Crect%3D43.01782395358609%252C-80.70883263085938%252C42.88011229371325%252C-81.78823936914063%26rid%3D792613%26disp%3Dmap%26mdm%3Dauto%26p%3D1%26z%3D1%26listPriceActive%3D1%26fs%3D1%26fr%3D0%26mmm%3D0%26rs%3D0%26ah%3D0%26singlestory%3D0%26housing-connector%3D0%26abo%3D0%26garage%3D0%26pool%3D0%26ac%3D0%26waterfront%3D0%26finished%3D0%26unfinished%3D0%26cityview%3D0%26mountainview%3D0%26parkview%3D0%26waterview%3D0%26hoadata%3D1%26zillow-owned%3D0%263dhome%3D0%26featuredMultiFamilyBuilding%3D0%26commuteMode%3Ddriving%26commuteTimeOfDay%3Dnow%09%09792613%09%09%09%09%09%09',
    'sec-ch-ua'=> '"Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"',
    'sec-ch-ua-mobile'=> '?0',
    'sec-ch-ua-platform'=> '"Windows"',
    'sec-fetch-dest'=> 'empty',
    'sec-fetch-mode'=> 'cors',
    'sec-fetch-site'=> 'same-origin',
    'user-agent'=> 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
  }

  response = HTTPX.get(
    "https://www.zillow.com/search/GetSearchPageState.htm",
    params: params,
    headers: headers
  )
  
  json_object = JSON.parse(response.body)
  results = json_object['cat1']['searchResults']['listResults'] 

  break if results.empty?
  # results.each do |result|
  #   data << {
  #     'price'=> result['price'],
  #     'address'=> result['address'],
  #   }
  # end
  data.concat(results)
end

puts JSON.pretty_generate(data)
puts data.length
