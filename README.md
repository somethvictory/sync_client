# README

This is a sample Ruby app to sync the resident data to a [Rails web service](https://github.com/somethvictory/sync_assignment).

Note: This is a pure ruby app.

### Requirements

* Ruby > 2.3.x
* [Roo](https://github.com/roo-rb/roo) for parsing CSV.
* [Pry](https://github.com/pry/pry) for debugging.
* [Typhoeus](https://github.com/typhoeus/typhoeus) for sending data to the API.

### Setup

```
git clone git@github.com:somethvictory/sync_client.git
```

### Running

To run the app:

```
cd sync_client

ruby main.rb
```

NOTE: Make sure that you have your [Rails web service](https://github.com/somethvictory/sync_assignment) running in your local machine on port 3000.

### Spec

To run all specs in the project:

```
rspec
```
