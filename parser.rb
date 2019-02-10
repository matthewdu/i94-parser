#!/usr/bin/env ruby

require 'date'

class TravelDate
  attr_accessor :date, :type, :location

  # date: Date
  # type: String
  # location: String
  def initialize(date, type, location)
    @date = date

    @type =
      if (type == "Departure")
        :departure
      elsif (type == "Arrival")
        :arrival
      else
        raise "Unhandled travel type: [type=#{type}]"
      end

    @location = location
  end
end

# A stay is a period of time in the US
class Stay
  attr_accessor :arrival, :departure

  # arrival: TravelDate
  # departure: TravelDate
  def initialize(arrival, departure)
    @arrival = arrival
    @departure = departure
  end

  def year()
    arrival.date.year
  end

  def duration()
    # The duration is inclusive so add 1
    (departure.date - arrival.date + 1).to_i
  end

end

# Reads input from filename
# param filename: String
def read_travel_dates(filename)
  travel_dates = []
  File.open(filename) do |file|
    while (id = file.gets) do
      date = Date.parse(file.gets.chomp)
      type = file.gets.chomp
      location = file.gets.chomp
      travel_dates << TravelDate.new(date, type, location)

      # Formats
      # February 10, 2017 => "%B %d, %Y"
      # 02/10/2017 => "%m/%d/%Y"
      # puts date.strftime("%m/%d/%Y")
      # puts type
      # puts location
      # puts ""
    end
  end
  travel_dates
end

# From travel_dates, creates a list of Stay
# param travel_dates: Array[TravelDate]
# returns Array[Stay]
def create_stays(travel_dates)
  stays = []

  while !travel_dates.empty?
    arrival = travel_dates.shift

    departure = nil
    if travel_dates.empty?
      departure = TravelDate.new(Date.new(arrival.date.year, 12, 31), "Departure", "Fake")
    elsif travel_dates.first.date.year > arrival.date.year
      departure = TravelDate.new(Date.new(arrival.date.year, 12, 31), "Departure", "Fake")
      travel_dates.unshift(TravelDate.new(Date.new(arrival.date.year + 1, 1, 1), "Arrival", "Fake"))
    else
      departure = travel_dates.shift
    end

    stays << Stay.new(arrival, departure)
  end

  stays
end

def fixed_width_str(str, width)
  s_len = str.length
  if s_len > width
    return str[0...width]
  else
    return str + (" " * (width - s_len))
  end
end

def debug_stays(stays)
  # for fixed width fields
  field_length = 20
  stays.each do |stay|
    arrival_date = stay.arrival.date.strftime("%Y-%m-%d")
    departure_date = stay.departure.date.strftime("%Y-%m-%d")
    
    puts fixed_width_str(arrival_date, field_length) + fixed_width_str(departure_date, field_length)
    puts fixed_width_str(stay.arrival.type.to_s, field_length) + fixed_width_str(stay.departure.type.to_s, field_length) + "#{stay.duration} days"
    puts fixed_width_str(stay.arrival.location, field_length) + fixed_width_str(stay.departure.location, field_length)
    puts ""
  end
end

def get_year_duration(filename, debug)
  travel_dates = read_travel_dates(filename).reverse

  # Adds a fake arrival date at the beginning of the year, if the first travel date for the year is a departure
  if travel_dates.first.type == :departure
    first_departure = travel_dates.first
    fake_arrival = TravelDate.new(Date.new(first_departure.date.year, 1, 1), "Arrival", "Fake")
    travel_dates.unshift(fake_arrival)
  end

  stays = create_stays(travel_dates)
  debug_stays(stays) if debug

  # calculate number of days each year
  year_duration = Hash.new(0)
  stays.each do |stay|
    year_duration[stay.year] += stay.duration
  end
  year_duration
end
