### README

# Scavengr - Rails Frontend

### Table Of Contents
- [Versions/Prerequisites](#versions-prerequisites)
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
- [Elasticsearch]()
-

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
- Set figaro for environment variables
```

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

### The Test Suite
- The test suite is written in Ginkgo. To run the test suite, from the root project folder run:
```
ginkgo -r -v
```

### Endpoints
- Documentation for all endpoints is here:
[Endpoint Explanation](https://github.com/anon0mys/qs_golang/blob/master/endpoint.md)

### Contributions
Scavengr is open source and welcomes contributions. If you would like to contribute please follow this workflow:
- Select an [Issue](https://github.com/anon0mys/scavengr_rails_frontend/issues) that you are interested in and get approval from one of the repository owners
- Ensure you have installed the appropriate [Versions/Prerequisites](#versions-prerequisites)
- Fork, then clone the repository
- Follow the [Setup](#setup) instructions
- Make your desired changes and accompanying tests
- Open a PR to the anon0mys/qs_golang repository
- An app administrator will conduct code review and contact you once the fix is accepted or rejected

### Authors
- [Evan Wheeler](https://github.com/anon0mys)
- [Andrew Piermarini](https://github.com/agpiermarini)
