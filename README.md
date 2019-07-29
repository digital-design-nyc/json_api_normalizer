# JsonApiNormalizer
Normalize json api format to simple

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'json_api_normalizer'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install json_api_normalizer
```

## Usage
```ruby
require 'json'
require 'json_api_normalizer'

json = JSON.parse(File.read('articles.json'))
data = JsonApiNormalizer.parse(json)
puts JSON.pretty_generate(data) # =>
```

```json
{
  "id": "1",
  "title": "JSON API paints my bikeshed!",
  "author": {
    "id": "9",
    "first-name": "Dan",
    "last-name": "Gebhardt",
    "twitter": "dgeb"
  },
  "comments": [
    {
      "id": "5",
      "body": "First!",
      "author": {
        "id": "2",
        "first-name": "John",
        "last-name": "Travolta",
        "twitter": "johnt"
      }
    },
    {
      "id": "12",
      "body": "I like XML better",
      "author": {
        "id": "9",
        "first-name": "Dan",
        "last-name": "Gebhardt",
        "twitter": "dgeb"
      }
    }
  ]
}
```


## Contributing

* Fork the project.
* Add a breaking test for your change.
* Make the tests pass.
* Run `rubocop -a`
* Push your fork.
* Submit a pull request.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).