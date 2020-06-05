# TranslationIO::API

Wrapper for the translation.io rest API. This is a work in progress, we started with the endpoints we needed but expect that we can and contributers can continue to this base.
Check out the [the documentation](https://translation.io/docs/api) for their API and the documentation on this gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'translation_io-api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install translation_io-api

## Usage

### List Segments

```Ruby
client = TranslationIO::API::Segments.new(api_key: "my-api-key")
response = client.list("fr", tag: "needs review")

response.code
=> 200

response.success?
=> true

response.body
=> {
  "segments": [
    {
      "id": 2,
      "source_id": "b9d78193f955836a4ffd2ace3d06c725f605a8fdf142522908dc5605fce30f72",
      "target_language": "fr",
      "type": "source",
      "source": "Good afternoon",
      "target": "Bon après-midi",
      "tags": [
        "needs review"
      ]
    }
  ]
}

```

### Add a Tag

```Ruby
client = TranslationIO::API::Segments.new(api_key: "my-api-key")
response = client.add_tag(1, name: "needs review")

response.body
=> {
  "segment": {
    "id": 1,
    "source_id": "85af68954641ff0400756bc3b93de505680e621e834040a63732621e659c1d82",
    "target_language": "fr",
    "type": "source",
    "source": "Hello",
    "target": "Bonjour",
    "tags": ["need review"]
  }
}
```

### Remove a Tag

```Ruby
client = TranslationIO::API::Segments.new(api_key: "my-api-key")
response = client.remove_tag(1, name: "needs review")

response.body
=> {
  "segment": {
    "id": 1,
    "source_id": "85af68954641ff0400756bc3b93de505680e621e834040a63732621e659c1d82",
    "target_language": "fr",
    "type": "source",
    "source": "Hello",
    "target": "Bonjour"
  }
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rreinhardt9/translation_io-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/rreinhardt9/translation_io-api/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TranslationIO::API project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rreinhardt9/translation_io-api/blob/master/CODE_OF_CONDUCT.md).
