# frozen_string_literal: true

require 'rainbow'

# String.colorize to colorize output
class String
  def colorize(color)
    Rainbow(self).send(color)
  end
end
