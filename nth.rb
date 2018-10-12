require 'sinatra'
require_relative 'lib/nr_data'
require_relative 'lib/nre_request'
require_relative 'lib/nre_response'

get '/' do
  stations = NationalRailData::get_stations_from_csv('data/station_codes.csv')
  erb :index, locals: { stations: stations }
end

get '/departures' do
  if params[:from_crs] && params[:to_crs]
    redirect "/from/#{params[:from_crs]}/to/#{params[:to_crs]}"
  else
    redirect '/'
  end
end

get '/from/:from_crs/to/:to_crs' do
  if params[:from_crs] == params[:to_crs]
    return erb :departures_same_station
  end

  departures = NationalRailEnquiries::get_departure_board(
    from: params[:from_crs],
    to: params[:to_crs],
  )
  data = NationalRailEnquiries::parse_get_departure_board_response(departures)

  if data[:departures].nil?
    return erb :departures_none, locals: { data: data }
  end

  erb :departures, locals: { data: data }
end
