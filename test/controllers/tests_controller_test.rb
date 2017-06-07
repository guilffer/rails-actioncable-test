require 'test_helper'

class TestsControllerTest < ActionDispatch::IntegrationTest
  25.times do |i|
    test "the truth #{i}" do
      if i == 17
        raise StandardError, :hey
      end
      sleep 0.5
      assert true
    end
  end
end
