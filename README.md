# README

# Parking Lot

### Project

#### Dependencies

- Docker 18.09
- Docker-compose 1.23

#### How to run

[Install documentation](INSTALL.md)

#### Running the tests

```
docker-compose run web bundle exec rspec
```

### Api Documentation

#### Summary

- Parkings
  - [history](#history)
  - [create](#create)
  - [pay](#pay)
  - [out](#out)

#### Docs

##### History
###### Show parkings
**_([Voltar](#summary))_**

```
# GET /parking/:plate
```

Sample:

```
curl -X GET http://0.0.0.0:3000/parking/AAA-9999
```

Example Response:

```
HTTP 200 OK
data: [
  {
    id: 1,
    type: 'parking',
    attributes: {
      plate: 'AAA-9999',
      paid: false,
      left: false,
      time: '10 minutes'
    }
  },
  {
    id: 27,
    type: 'parking',
    attributes: {
      plate: 'AAA-9999',
      paid: true,
      left: true,
      time: '74 minutes'
    }
  }
]
```

##### Create
**_([Voltar](#summary))_**

```
# POST /parking
```

Sample:

```
curl -X POST http://0.0.0.0:3000/parking \
-d 'plate: AAA-9999'

```

Example Response:

```
HTTP 201 CREATED

data:
{
  id: 1,
  type: 'parking',
  attributes: {
    plate: 'AAA-9999',
    paid: false,
    left: false,
    time: '10 minutes'
  }
}
```

##### Pay
**_([Voltar](#summary))_**

```
# PUT /parking/:id/pay
```

Sample:

```
curl -X PUT http://0.0.0.0:3000/parking/1/pay
```

Example Response:

```
HTTP 200 OK

data:
{
  id: 1,
  type: 'parking',
  attributes: {
    plate: 'AAA-9999',
    paid: true,
    left: false,
    time: '10 minutes'
  }
}
```

##### Out
**_([Voltar](#summary))_**

```
# PUT /parking/:id/out
```

Sample:

```
curl -X PUT http://0.0.0.0:3000/parking/1/out
```

Example Response:

```
HTTP 200 OK

data:
{
  id: 1,
  type: 'parking',
  attributes: {
    plate: 'AAA-9999',
    paid: true,
    left: true,
    time: '10 minutes'
  }
}
```

