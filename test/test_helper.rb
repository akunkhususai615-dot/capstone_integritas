
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)

    # Data pengujian dibuat langsung melalui model,
    # bukan menggunakan fixtures.
  end
end
