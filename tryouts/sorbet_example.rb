# typed: true
# frozen_string_literal: true

class Calculator
  extend T::Sig

  sig { params(x: Integer, y: Integer).returns(Integer) }
  def add(x, y)
    x + y
  end
end

def main
  Calculator.new.add(1, 10)

  # `bundle exec srb tc` catches the type errors
  # Calculator.new.add("World", "hello")
end

# References: https://sorbet.org/
