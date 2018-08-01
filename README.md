### README

# Scavengr - Rails Frontend

### Table Of Contents
- [Versions/Prerequisites](#versions/prerequisites)
- [Setup](#setup)
- [Elasticsearch](#elasticsearch)
- [The Test Suite](#the-test-suite)
- [Contributions](#contributions)
- [Authors](#authors)

### Versions/Prerequisites

The prerequisites for this application are:
- Rails 5
- Ruby 2.4+
- npm 5.6
- Elasticsearch
- Python3 and pip3

### Setup
- Clone this repository:
```
git clone git@github.com:anon0mys/scavengr_rails_frontend.git
```
- CD into the directory and run the following setup commands
```
bundle install
npm install
bundle exec figaro install
```
- Run the server to make sure setup was successful
```
rails s
```
- In config/application.yml set the following environment variables:

  ```yml
  test:
    BASE_URL: 'http://localhost:8080'

  development:
    BASE_URL: 'http://localhost:8080'

  production:
    BASE_URL: 'URL OF YOUR DEPLOYED APP HERE'
  ```
- Setup the [Django Backend](https://github.com/agpiermarini/scavengr_django_backend)
- Setup [Elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/6.3/_installation.html)

### Elasticsearch
- This project uses elasticsearch as the docstore for location data. To set up a basic elasticsearch instance, follow the [official getting started documentation](https://www.elastic.co/guide/en/elasticsearch/reference/6.3/_installation.html).
- Once elasticsearch is installed and started, run the rake setup task:

  ```
  rake elasticsearch:index_setup
  ```
- If you ever need to reset the cluster and clear all the data, you can run:
_*WARNING This will delete all of the data in your elasticsearch stores*_

  ```
  rake elasticsearch:index_reset
  ```

### To Run the App Locally
- Ensure the Django app is set up and that the database and migrations have run
- Start your Django server on a port other than 3000:
  ```
  python3 manage.py runserver PORT
  ```
- Start your Rails server:
  ```
  rails s
  ```

### The Test Suite
- The test suite is written in RSpec. To run the suite, you must have a python server running and connected to a test database.
  ```
  python3 manage.py runserver PORT
  ```
- Once the python app is running, run the full test suite with:

  ```
  rspec
  ```

### Contributions
Scavengr is open source and welcomes contributions. If you would like to contribute, please follow this workflow:
- Select an [Issue](https://github.com/anon0mys/scavengr_rails_frontend/issues) that you are interested in and get approval from one of the repository owners
- Ensure you have installed the appropriate [Versions/Prerequisites](#versions-prerequisites)
- Fork, then clone the repository
- Follow the [Setup](#setup) instructions
- Make your desired changes and accompanying tests
- Open a PR to the anon0mys/scavengr_rails_frontend repository
- An app administrator will conduct code review and contact you with requested changes, or to confirm your contribution has been merged

### Authors
- [Evan Wheeler](https://github.com/anon0mys)
- [Andrew Piermarini](https://github.com/agpiermarini)
