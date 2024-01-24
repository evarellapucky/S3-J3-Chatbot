require 'http'
require 'json'
require 'dotenv'

Dotenv.load

# création de la clé d'api et indication de l'url utilisée.
api_key = ENV["OPENAI_API_KEY"]
# ENV["OPENAI_API_KEY"]
url = "https://api.openai.com/v1/completions"

# un peu de json pour faire la demande d'autorisation d'utilisation à l'api OpenAI
headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

puts "bienvenue, que puis-je faire pour vous ? (taper 'exit' pour sortir)"
conversation_history = ""

loop do
  input = conversation_history + gets.chomp
  

data = {
  "model" => "gpt-3.5-turbo-instruct",
  "prompt" => input,
  "max_tokens" => 70,
  "temperature" => 5.0,
  "n" => "1"
}

response = HTTP.post(url, headers: headers, body: data.to_json)
response_body = JSON.parse(response.body.to_s)
response_string = response_body['choices'][0]['text'].strip
conversation_history = conversation_history + response_string

puts response_string
break if input.include?("exit")
end