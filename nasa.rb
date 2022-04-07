# ¿Qué tenemos que saber para enfrentarnos a esta prueba?
# Consumo de una API Rest con autenticación sencilla.
# Crear métodos que reciban parámetros.
# Iterar resultados dentro de un hash y un arreglo.
# Filtrar resultados dentro de un hash y un arreglo.
# Guardar los resultados dentro de un archivo.
#https://api.nasa.gov/planetary/apod?api_key=erGF4i2ibHmmR1woZSgzZpHLA9D3ND6M1ab9NA39
#erGF4i2ibHmmR1woZSgzZpHLA9D3ND6M1ab9NA39
require "uri"
require "net/http"
require "json"

def request(url)

url = URI(url)

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Get.new(url)

response = https.request(request)
results = JSON.parse(response.read_body)
end

data = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=erGF4i2ibHmmR1woZSgzZpHLA9D3ND6M1ab9NA39")
    data = data["photos"][0..9]

photos = data.map do |photo|
    photo["img_src"]
end

html = ""
html += "<html>\n"
html += "<head>\n"
html += "<body>\n"
html += "<ul>\n"
photos.each do |photo|
html += "<li><img src= '#{photo}'></li>\n"

end 
html += "</ul>\n"
html += "</body>\n"
html += "</html>\n"
File.write('index.html', html)
