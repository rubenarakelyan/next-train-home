class NationalRailEnquiries
  def self.parse_get_departure_board_response(response)
    root = response[:envelope][:body][:get_dep_board_with_details_response][:get_station_board_result]
    from_location = root[:location_name]
    to_location = root[:filter_location_name]
    departures = root.dig(:train_services, :service)

    {
      from_location: from_location,
      to_location: to_location,
      departures: departures,
    }
  end
end
