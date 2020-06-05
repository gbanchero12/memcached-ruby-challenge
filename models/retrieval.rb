# frozen_string_literal: true

class Retrieval
  def initialize
    result
  end

  attr_reader :result

  attr_writer :result

  def to_s
    result.to_s
  end
end
