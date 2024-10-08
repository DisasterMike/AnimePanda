require "openai"

class OpenaiService
  attr_reader :client, :prompt

  def initialize
    @client = OpenAI::Client.new
  end

  def recommend_anime(prompt)
    animes = Anime.all.select(:id, :title, :rating, :rank, :popularity).to_json
    response = client.chat(
      parameters: {
          model: "gpt-4o-mini", # Required.
          messages: [
            {role: "system", content: "You are the AnimePanda. Your recommendations based on the user's seen anime data. If the user does not have the seen anime data, recommend anime based on your suggestions. Always respond in JSON format. You will always recommend five animes from the following JSON #{animes}. "},
            {role: "user", content: prompt }], # Required.
          temperature: 1,
          stream: false,
					max_tokens: 150,
          response_format: { type: "json_object" } # might want to check this
      })
    # you might want to inspect the response and see what the api is giving you
    return response.dig("choices", 0, "message")
  end


  def home_chat
    response = client.chat(
      parameters: {
          model: "gpt-4o-mini", # Required.
          messages: [
            {role: "system", content: "You are the AnimePanda. You are an anime expert and concierge for an anime recommendations website. When the user goes the homepage send a welcome message in a funny and quirky way."},
            {role: "user", content: "I just got to the homepage. Send me a welcome message. Keep it short and less than 10 words" }], # Required.
          temperature: 1.5,
          stream: false,
					max_tokens: 150,
      })
    # you might want to inspect the response and see what the api is giving you
    return response.dig("choices", 0, "message", "content")
  end

  def show_chat(anime)
    response = client.chat(
      parameters: {
          model: "gpt-4o-mini", # Required.
          messages: [
            {role: "system", content: "You are the AnimePanda. Can you recommend an anime that is similar to #{anime}"},
            {role: "user", content: "Recommend me an anime. Keep it short and less than 23 words" }], # Required.
          temperature: 1.5,
          stream: false,
					max_tokens: 150,
      })
    # you might want to inspect the response and see what the api is giving you
    return response.dig("choices", 0, "message", "content")
  end

  def reco_chat(seen, recos)
    response = client.chat(
      parameters: {
          model: "gpt-4o-mini", # Required.
          messages: [
            {role: "system", content: "You are the AnimePanda. You are an anime expert and concierge for an anime recommendations website.
                                      You recommended the animes below.
                                      #{recos}
                                      It was based on the user's watched anime list below.
                                      #{seen}
                                      Follow the format below.
                                      I recommended these based on your interest in action, fantasy, and suspense in titles like Jujutsu Kaisen and Death Note. Explore brilliant storylines in epic worlds!"},
            {role: "user", content: "I just got your anime recommendations. Tell me why recommended this based on my watched anime list then briefly introduce the anime recommendations. Keep it short and less than 23 words" }], # Required.
          temperature: 1.5,
          stream: false,
					max_tokens: 150,
      })
    # you might want to inspect the response and see what the api is giving you
    return response.dig("choices", 0, "message", "content")
  end

  def per_reco_chat(seen, anime)
    response = client.chat(
      parameters: {
          model: "gpt-4o-mini", # Required.
          messages: [
            {role: "system", content: "You are the AnimePanda. You are an anime expert and concierge for an anime recommendations website.
                                      You recommended the anime below.
                                      #{anime.title}
                                      It was based on the user's watched anime list below.
                                      #{seen}
                                      Follow the format below.
                                      I recommended Frieren: Beyond Journey's End due to your taste for fantasy and character depth seen in shows like Mushoku Tensei. It explores the emotional journey of a mage after heroics end."},
            {role: "user", content: "I just got your anime recommendations. Tell me why you recommended this based on my watched anime list then briefly introduce the anime recommendation. Keep it short and less than 23 words" }], # Required.
          temperature: 1.5,
          stream: false,
					max_tokens: 150,
      })
    # you might want to inspect the response and see what the api is giving you
    return response.dig("choices", 0, "message", "content")
  end

  def watchlist_chat(watchlist)
    response = client.chat(
      parameters: {
          model: "gpt-4o-mini", # Required.
          messages: [
            {role: "system", content: "You are the AnimePanda. You are an anime expert and concierge for an anime recommendations website.
                                      The user's watchlist is below
                                      #{watchlist}
                                      The user is checking their watchlist.
                                      If the user's watchlist is empty, tell them it's empty and recommend an anime to add in their watchlist.
                                      Be quirky and funny."},
            {role: "user", content: "I am checking my watchlist. Ask me if I already watched a specific anime on my watchlist and what did I think of it. If I don't have anything in my watchlist, recommend me a random anime. Keep it short and less than 23 words" }], # Required.
          temperature: 1.5,
          stream: false,
					max_tokens: 150,
      })
    # you might want to inspect the response and see what the api is giving you
    return response.dig("choices", 0, "message", "content")
  end

  def extract_json(input_string)
    # Define a regular expression to match JSON block
    json_pattern = /```json\n(.*)\n```/m

    # Find the JSON block in the input string
    match = input_string.match(json_pattern)

    # Extract the JSON part if matched
    json_string = match[1] if match

    # Parse the JSON string
    JSON.parse(json_string) if json_string
  rescue JSON::ParserError => e
    puts "Failed to parse JSON: #{e.message}"
    nil
  end

end
