require_relative "parser"
require "test/unit"

class TestParse < Test::Unit::TestCase

  def test_simple
    year_duration = get_year_duration("tests/arrival_then_departure.txt")

    assert_equal(year_duration, {2019 => 6})
  end

  def test_only_arrival
    year_duration = get_year_duration("tests/only_arrival.txt")

    assert_equal(year_duration, {2019 => 365})
  end

  def test_only_departure
    year_duration = get_year_duration("tests/only_departure.txt")

    assert_equal(year_duration, {2019 => 5})
  end

  def test_arrival_and_departure_in_two_years
    year_duration = get_year_duration("tests/test_arrival_and_departure_in_two_years_1.txt")

    assert_equal(year_duration, {2018 => 2, 2019 => 2})


    year_duration = get_year_duration("tests/test_arrival_and_departure_in_two_years_2.txt")

    assert_equal(year_duration, {2018 => 2, 2019 => 365, 2020 => 2})
  end

  def test_complex
    year_duration = get_year_duration("tests/complex.txt")

    assert_equal(year_duration, {2015=>108, 2016=>47, 2017=>163, 2018=>311, 2019=>10})
  end
end
