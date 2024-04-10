require 'pry'
require 'dotenv'
require 'http'
require 'json'

Dotenv.load 

api_key = ENV["OPENAI_API_KEY"]
url = "https://api.openai.com/v1/completions"


headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

data = {
  "prompt" => "1 recette de cuisine complètement stupide",
  "max_tokens" => 100,
  "n" => 1,
  "stop" => ["."],
  "temperature" => 0.4,
  "model" => "gpt-3.5-turbo-instruct"
}

response = HTTP.post(url, headers: headers, body: data.to_json)
response_body = JSON.parse(response.body.to_s)
response_string = response_body['choices'][0]['text'].strip

puts "Voici 1 recette de cuisine aléatoire :"
puts response_string