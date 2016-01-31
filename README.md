# Rails mongoid.yml

This [wercker step](http://devcenter.wercker.com/docs/steps) generates a `config/mongoid.yml` rails project using [mongoid](http://mongoid.org).

[![wercker status](https://app.wercker.com/status/a13a02a4498626818945213803550089/s "wercker status")](https://app.wercker.com/project/bykey/a13a02a4498626818945213803550089)

## Example

```yml
box: ruby
services:
  - mongo
build:
  steps:
    - neveragny/mongoid5-rails-config-yml:
        db_name: my_app_test
```

## Options

- `db_name`
  (optinal, default: `mongo`)
  This option is not required. If set, it will name the database accordingly.

## Details

You should use this along with the mongo service.
Have a look at the [services documentation](http://devcenter.wercker.com/docs/services) for more information.

## License

MIT License (MIT)
