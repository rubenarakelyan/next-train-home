require 'csv'

class NationalRailData
  def self.get_stations_from_csv(csv_file_path)
    data = CSV.read(csv_file_path, headers: true)
    data.map do |station|
      {
        name: station[0],
        crs: station[1]
      }
    end
  end
end
