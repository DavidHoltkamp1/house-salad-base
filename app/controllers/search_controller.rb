class SearchController < ApplicationController
  def index
    # TODO: Add Faraday to make a GET request to https://api.propublica.org/congress/v1/members/house/co/current.json
    state = params[:state]
    conn = Faraday.new(url: "https://api.propublica.org") do |f|
      f.headers["X-API-KEY"] = ENV["PROPUBLICA_API_KEY"]
    end

    response = conn.get("/congress/v1/members/house/#{state}/current.json")

    json = JSON.parse(response.body, symbolize_names:true)
    @members = json[:results]
  end
end
