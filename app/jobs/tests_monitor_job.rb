class TestsMonitorJob < ApplicationJob
  include ActionView::Helpers::TextHelper
  queue_as :default

  def perform(*args)
    sleep(2)
    thread = Thread.new do
      `echo \"# Starting\" > log/conductor.log`
      sleep(2)
      `echo \"$ rake\" >> log/conductor.log`
      sleep(2)
      `rake >> log/conductor.log`
      sleep(2)
      dump = simple_format(`cat log/conductor.log`)
      ActionCable.server.broadcast "tests", message: dump
    end

    sleep(1)
    while thread.alive?
      dump = simple_format(`cat log/conductor.log`)
      ActionCable.server.broadcast "tests", message: dump
      sleep(0.3)
    end
  end

end
