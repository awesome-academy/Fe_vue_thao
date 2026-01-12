# frozen_string_literal: true

module Result
  class Success
    attr_reader :data

    def initialize(data = nil)
      @data = data
    end

    def success?
      true
    end

    def failure?
      false
    end
  end

  class Failure
    attr_reader :errors

    def initialize(errors = {})
      @errors = errors.is_a?(Hash) ? errors : { message: errors }
    end

    def success?
      false
    end

    def failure?
      true
    end
  end

  def self.success(data = nil)
    Success.new(data)
  end

  def self.failure(errors = {})
    Failure.new(errors)
  end
end
