class TestsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "tests"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
