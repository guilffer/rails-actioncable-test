# README

› rails new

› rails db:migrate

› rails g controller tests

- Update test/controller/tests_controller_test.rb to add expensive tests

› rails g channel tests

- create actions tests#index and tests#cable

- start action cable on routes.rb

- add `stream_from "tests"` to TestsChannel#subscribed

- add to tests_controller.rb#cable
```
Thread.new do
  dump = `rake`
  ActionCable.server.broadcast "tests", message: dump
end
```

- add `document.getElementById("dump").innerHTML = data['message']` to js/channels/tests.coffee

------ job

- create actions tests#job

› rails g job tests_monitor

- move thread to job

