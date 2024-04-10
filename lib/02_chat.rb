require 'pry'
require 'dotenv'
require 'http'
require 'json'

Dotenv.load 

api_key = ENV["OPENAI_API_KEY"]


conversation_history = []
# binding.pry

def converse_with_ai(api_key, conversation_history)
  url = "https://api.openai.com/v1/completions"
  
  headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{api_key}"
  }
  
  loop do
    prompt = gets.chomp
    
    #puts prompt
    break if prompt == "stfu"
    
    conversation_history << prompt
    data = {
      "prompt" => conversation_history,
      "max_tokens" => 100,
      "temperature" => 0.5,
      "model" => "gpt-3.5-turbo-instruct"
    }
    
    response = HTTP.post(url, headers: headers, body: data.to_json)
    response_body = JSON.parse(response.body.to_s)
    response_string = response_body['choices'][0]['text'].strip
    
    conversation_history << response_string
    puts response_string
  end
end

converse_with_ai(api_key, conversation_history)