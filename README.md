# Watch Tower

[![codebeat badge][codebeat-badge]][codebeat] [![Coverage][codecov-badge]][codecov] [![Ruby][Github-Actions]][Github]

## About this project

This project is a control visitors system.

The resources are: Stores, Visitors and their Entrances and Exits into the system (Appointments).

It's a Rails application (API-only) to management the resources above by users athough roles as Admin or Employee.

## Technical Informations and dependencies

```code
* The Ruby language - version 2.7.0
* The Rails gem     - version 6.1.4
* RSpec Rails       - version 4.0.2
* Rubocop           - version 1.25.1
* cancancan         - version 3.3.0
* devise-jwt        - version 0.9.0
* PostgreSQL        - version 11.5
* Docker            - version 20.10.12
* Docker Compose    - version 2.2.3
```

## To use

Clone the project:

``` Shell
git clone git@github.com:marcelotoledo5000/watch-tower.git
cd watch-tower
```

### With Docker (better option)

``` Shell
script/setup    # => development bootstrap, preparing containers
script/server   # => starts server
script/console  # => starts console
script/test     # => running tests
```

#### Running without Docker (not recommended!)

If you prefer, you'll need to update `config/database.yml`:

``` Yaml
# host: db        # when using docker
host: localhost   # when using localhost
```

System dependencies:

* Install and configure the database: [Postgresql-10](https://www.postgresql.org/download/)

And then:

``` Shell
gem install bundler         # => install the last Bundler version
bundle install              # => install the project's gems
rails db:setup db:migrate   # => prepare the database
rails s                     # => starts server
rails c                     # => starts console
bundle exec rspec           # => to running tests
```

### To run app

To see the application in action, starts the rails server to able [http://localhost:3000/](http://localhost:3000.)

### Dockerfile

[Dockerfile is here](https://github.com/marcelotoledo5000/Dockerfiles)

### API Documentation

#### Authentication

To authenticate you need an email and password (minimum length: 8), so the system generates a Token (JWT) to be used in all API requests (except the public reports).

The request needs a JWT on the headers: Authorization type Bearer Token and your Token (it's received by response header after success login).

#### Domain

[http://localhost:3000/](http://localhost:3000)

Headers:

```code
{ 'Content-Type' => 'application/json' }
{ 'Authorization' => "Bearer 'your_token'" }
```

#### Endpoints

##### USERS

LOGIN / AUTHENTICATION

* Authenticate to get token:

Request:

``` Shell
curl -i \
--request POST 'localhost:3000/login' \
--header 'Content-Type: application/json' \
--data-raw '{
  "user": {
    "email": "admin@email.com",
    "password": "admin-password"
  }
}'
```

Response:

``` Shell
HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Referrer-Policy: strict-origin-when-cross-origin
Location: /
Content-Type: text/plain; charset=utf-8
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTg2OTE5MTkwLCJleHAiOjE1ODY5MTk0OTAsImp0aSI6ImYxZGI0YjBjLWE0NGItNDEyNy04NDhkLWRkMmRkMTMxNmE4NCJ9.YbmLajIh3JqRdgB1asAIO1cEDCLX-UdW-Zwvb5LydRM
ETag: W/"36a9e7f1c95b82ffb99743e0c5c4ce95"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: aa341847-69e8-40b7-bac3-dd38dfdd3af4
X-Runtime: 0.207616
Vary: Origin
Transfer-Encoding: chunked
```

```code
status: 200 Ok
```

LOGOUT

* Destroy user session:

Request:

``` Shell
curl -i \
--request DELETE 'localhost:3000/logout' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTg2OTE5MTkwLCJleHAiOjE1ODY5MTk0OTAsImp0aSI6ImYxZGI0YjBjLWE0NGItNDEyNy04NDhkLWRkMmRkMTMxNmE4NCJ9.YbmLajIh3JqRdgB1asAIO1cEDCLX-UdW-Zwvb5LydRM'
```

Response:

```code
status: 204 No Content
```

CREATE

```code
POST: http://DOMAIN/users
"http://localhost:3000/users"
Param: Body, JSON(application/json)
```

Request with token:

``` Shell
curl --request POST 'localhost:3000/users' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNTg2OTE5MTkwLCJleHAiOjE1ODY5MTk0OTAsImp0aSI6ImYxZGI0YjBjLWE0NGItNDEyNy04NDhkLWRkMmRkMTMxNmE4NCJ9.YbmLajIh3JqRdgB1asAIO1cEDCLX-UdW-Zwvb5LydRM' \
--data-raw '{
  "user": {
    "login": "newlogin",
    "email": "my@email.com",
    "name": "My Name",
    "password": "MyPassword",
    "role": "admin",
    "store_id": null
  }
}'
```

Response:

``` json
{
  "id":1,
  "login":"newlogin",
  "name":"My Name",
  "role":"admin",
  "store_id":null,
  "created_at":"2020-04-15T02:53:38.217Z",
  "updated_at":"2020-04-15T02:53:38.217Z",
  "email":"my@email.com"
}
```

```code
status: 201 Created
```

INDEX

```code
GET: http://DOMAIN/users
"http://localhost:3000/users"
```

Response:

``` json
[
  {
    "id": 1,
    "login": "noel_jaskolski",
    "name": "Feyd-Rautha Rabban",
    "role": "admin",
    "store_id": null,
    "created_at": "2020-04-14T02:27:36.606Z",
    "updated_at": "2020-04-14T02:27:36.606Z",
    "email": "admin@email.com"
  },
  {
    "id": 2,
    "login": "bonita_price",
    "name": "Ilban Richese",
    "role": "employee",
    "store_id": 1,
    "created_at": "2020-04-14T02:27:36.786Z",
    "updated_at": "2020-04-14T02:27:36.786Z",
    "email": "employee@email.com"
  },
  {
    "id":3,
    "login":"newlogin",
    "name":"My Name",
    "role":"admin",
    "store_id":null,
    "created_at":"2020-04-15T02:53:38.217Z",
    "updated_at":"2020-04-15T02:53:38.217Z",
    "email":"my@email.com"
  }
]
```

```code
status: 200 Ok
```

SHOW

```code
GET: http://DOMAIN/users/:id
"http://localhost:3000/users/1"
```

Response:

```json
{
  "id": 1,
  "login": "noel_jaskolski",
  "name": "Feyd-Rautha Rabban",
  "role": "admin",
  "store_id": null,
  "created_at": "2020-04-14T02:27:36.606Z",
  "updated_at": "2020-04-14T02:27:36.606Z",
  "email": "admin@email.com"
}
```

```code
status: 200 Ok
```

UPDATE

```code
PUT: http://DOMAIN/users/:id
"http://localhost:3000/users/1"
```

Request:

```json
{
  "user": {
    "email": "newuser@email.com",
    "password": "password123",
    "login": "NewLogin",
    "name": "New Name",
    "role": "employee",
    "store_id": 1
  }
}
```

Response:

```code
status: 204 No Content
```

##### STORES

CREATE

```code
POST: http://DOMAIN/stores
"http://localhost:3000/stores"
Param: Body, JSON(application/json)
```

```json
{
  "store": {
    "cnpj": "00111222000100",
    "name": "Maximus Store"
  }
}
```

Response:

```json
{
  "id": 1,
  "cnpj": "00111222000100",
  "name": "Maximus Store",
  "total_visitors": 0,
  "visitors": []
}
```

```code
status: 201 Created
```

SHOW

```code
GET: http://DOMAIN/stores/:id
"http://localhost:3000/stores/1"
```

Response:

```json
{
  "id": 1,
  "cnpj": "66671354000508",
  "name": "Schamberger-Morissette",
  "total_visitors": 0,
  "visitors": []
}
```

```code
status: 200 Ok
```

INDEX

```code
GET: http://DOMAIN/stores/
"http://localhost:3000/stores/"
```

Response:

```json
[
  {
    "id": 1,
    "cnpj": "66671354000508",
    "name": "Schamberger-Morissette",
    "total_visitors": 0,
    "visitors": []
  },
  {
    "id": 2,
    "cnpj": "68601222000608",
    "name": "Little, Zemlak and Howell",
    "total_visitors": 0,
    "visitors": []
  }
]
```

```code
status: 200 Ok
```

UPDATE

```code
PUT: http://DOMAIN/stores/:id
"http://localhost:3000/stores/1"
```

Request:

```json
{
  "name": "Schamberger-Morissette",
}
```

Response:

```code
status: 204 No Content
```

##### VISITORS

Actions:

Create, Index, Show, Update and Destroy

```json
{
  "visitor": {
    "cpf": "01234567890",
    "name": "Visitor Name",
    "profile_photo": "store.com/photo.jpg",
    "store_id": "1"
  }
}
```

##### APPOINTMENTS

Actions:

Create and Index

```json
{
  "appointment": {
    "visitor_id": "1",
    "store_id": "1",
    "kind": "check_in", # OR "check_out"
    "event_time": "2020-03-30T22:00:06"
  }
}
```

##### REPORTS

INDEX

```code
GET: http://DOMAIN/reports/
"http://localhost:3000/reports/"
```

Response:

```json
{
  "total_stores": 6,
  "stores": [
    {
      "id": 1,
      "cnpj": "66671354000508",
      "name": "Schamberger-Morissette",
      "total_visitors": 0,
      "visitors": []
    },
    {
      "id": 2,
      "cnpj": "68601222000608",
      "name": "Little, Zemlak and Howell",
      "total_visitors": 0,
      "visitors": []
    },
    {
      "id": 3,
      "cnpj": "43172694000319",
      "name": "Rempel, Rice and Rutherford",
      "total_visitors": 0,
      "visitors": []
    },
    {
      "id": 4,
      "cnpj": "06333039000883",
      "name": "Towne Inc",
      "total_visitors": 1,
      "visitors": [
        {
          "id": 1,
          "name": "Alia Atreides",
          "cpf": "06505239707",
          "profile_photo": "path/to/quam.jpg"
        }
      ]
    },
    {
      "id": 5,
      "cnpj": "83407139000939",
      "name": "Wiza and Sons",
      "total_visitors": 1,
      "visitors": [
        {
          "id": 2,
          "name": "Alia Atreides",
          "cpf": "03310228347",
          "profile_photo": "path/to/laudantium.jpg"
        }
      ]
    },
    {
      "id": 6,
      "cnpj": "92770151000902",
      "name": "Medhurst-Bosco",
      "total_visitors": 1,
      "visitors": [
        {
          "id": 3,
          "name": "Jessica Atreides",
          "cpf": "06985836801",
          "profile_photo": "path/to/sit.jpg"
        }
      ]
    }
  ]
}
```

```code
status: 200 Ok
```

### PENDING IDEAS

* Need to handle the format of the input data (cpf and cnpj)
* Fix some code smells and other issues reported by Code Climate

### STATUS CODE

[![wakatime badge][wakatime-badge]][wakatime]

[wakatime-badge]: https://wakatime.com/share/@MarceloToledo/c7218fea-f738-4d3e-ad0a-f750c222c766.png
[wakatime]: https://wakatime.com/

## Contributing

Watch Tower is open source, and we are grateful for
[everyone][contributors] who have contributed so far or want to start.

[codebeat-badge]: https://codebeat.co/badges/79b5a436-3241-4d15-b961-04c6fddc6001
[codebeat]: https://codebeat.co/projects/github-com-marcelotoledo5000-watch-tower-master

[codecov-badge]: https://codecov.io/gh/marcelotoledo5000/watch-tower/branch/master/graph/badge.svg
[codecov]: https://codecov.io/gh/marcelotoledo5000/watch-tower

[Github-Actions]: https://github.com/marcelotoledo5000/watch-tower/workflows/Ruby/badge.svg
[Github]: https://github.com/marcelotoledo5000/watch-tower/workflows/Ruby/badge.svg
