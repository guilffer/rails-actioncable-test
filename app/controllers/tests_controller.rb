class TestsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @dump = `rake`
  end

  def cable
    Thread.new do
      dump = `rake`
      ActionCable.server.broadcast "tests", message: dump
    end
    @dump = "..."
  end

  def cable_threads
    test_thread = Thread.new do
      `echo \"# Starting\" > log/conductor.log`
      sleep(2)
      `echo \"$ rake\" >> log/conductor.log`
      sleep(2)
      `rake >> log/conductor.log`
      sleep(2)
      dump = simple_format(`cat log/conductor.log`)
      ActionCable.server.broadcast "tests", message: dump
    end

    Thread.new do
      sleep(1)
      while test_thread.alive?
        dump = simple_format(`cat log/conductor.log`)
        ActionCable.server.broadcast "tests", message: dump
        sleep(0.3)
      end
    end
  end

  def job
    Thread.new { TestsMonitorJob.new.perform }
  end
end
