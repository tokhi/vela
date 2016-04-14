# Vela

Vela is a simple light gem which clone a table records from mysql to postgresql and vice versa. This gem is helpful when you want to have the same table records in a different db.

However this gem is also enable to clone the records of a table to another table even if the destination table has a different name and columns name.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vela'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vela

## Usage
to clone data from `Mysql` to `Postgresql` (change the src and destination arguments based on your db settings )

```ruby
	v = Vela::DB.new
	v.src_connection(user: 'root', password: 'pass', host: '127.0.0.1', database: 'testdb', adapter: 'mysql')
	v.dst_connection(user: 'user', password: 'pass', host: '127.0.0.1', database: 'testpdb', adapter: 'postgresql')
	v.dbsync("src_tbl", "dst_tbl")  # destination table should already been exist

	# if your destination tables' columns are different than the source table (e.g; clonse `col1` data to m_col1 column):
	v.dbsync("src_tbl", "dst_tbl", {"col1" => "m_col1", "col2" => "m_col2"})  # you can add as much as column as you want

```


to clone data from `Postgresql` to `Mysql` (change the src and destination arguments based on your db settings )

```ruby
	v = Vela::DB.new
	v.src_connection(user: 'user', password: 'pass', host: '127.0.0.1', database: 'testpdb', adapter: 'postgresql')
	v.dst_connection(user: 'root', password: 'pass', host: '127.0.0.1', database: 'testdb', adapter: 'mysql')
	v.dbsync("src_tbl", "dst_tbl")  # destination table should already been exist

	# if your destination tables' columns are different than the source table (e.g; clonse `col1` data to m_col1 column):
	v.dbsync("src_tbl", "dst_tbl", {"col1" => "m_col1", "col2" => "m_col2"})  # you can add as much as column as you want

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/vela.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

