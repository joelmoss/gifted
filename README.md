# Gifted

Simple, powerful, and explicit decorators for Ruby on Rails, inspired (and forked) from [ActiveDecorator](https://github.com/amatsuda/active_decorator). It has the following goals:

1. Fast and efficient.
2. Implicit decorators.
3. Explicit decoration.

## Features

Gifted has an almost identical feature set to ActiveDecorator...

1. Automatically mixes decorator module into corresponding model only when:
   1. Passing a model or collection of models or an instance of ActiveRecord::Relation from controllers to views
   2. rendering partials with models (using `:collection` or `:object` or `:locals` explicitly or implicitly)
   3. fetching already decorated Active Record model object's association
2. the decorator module runs in the model's context. So, you can directly call any attributes or methods in the decorator module
3. since decorators are considered as sort of helpers, you can also call any ActionView's helper methods such as `content_tag` or `link_to`

But with the following differences...

1. Decorator methods are name-spaced to a single `gift` method. This avoids confusion and collision.
2. Decorators are mixed into SimpleDelegator classes, which themselves delegate to the decorated object.
2. Decorator Views allow you to create child decorators.
3. Only works with Rails.

## Installation

Gifted requires Rails >= 5.

Add this line to your application's Gemfile:

```ruby
gem 'gifted'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gifted

## Usage

Create your Decorators into `/app/decorators` for each model you want decorated, and define methods. For example, a model `User`, can have a decorator `UserDecorator`:

* Model
```ruby
class User < ActiveRecord::Base
  # first_name:string last_name:string
end
```

* Controller
```ruby
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
end
```

* Decorator
```ruby
# I can call any method from the decorated object, and because I am mixed into SimpleDelegator, I
# can access the decorated object directly at __getobj__.
module UserDecorator
  # This is a Decorator View, and can be access by passing the name of the view (:admin) to `#gift`.
  module AdminDecorator
    def full_name
      "#{first_name} #{last_initial} (administrator)"
    end
  end

  def full_name
    "#{first_name} #{last_initial}"
  end

  def first_name
    first_name.titleize
  end

  def last_initial
    last_name[0]
  end
end
```

* View
```erb
<!-- @user here is auto-decorated in between the controller and the view -->

<!-- @user.gift.full_name will use the method #full_name from the decorator. -->
<p><%= @user.gift.full_name %></p>

<!--
  @user.gift.last_name will use the method #last_name from the model, because @user.gift delegates
  to the model.
-->
<p><%= @user.gift.last_name %></p>

<!--
  Calling gift with a symbol as an argument, will decorate the object with a Decorator view.
  So @user.gift(:admin).last_name will use the method #full_name from UserDecorator::AdminDecorator.
-->
<p><%= @user.gift(:admin).full_name %></p>

<!-- @user.last_name will use the method #last_name from the model. -->
<p><%= @user.last_name %></p>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joelmoss/gifted.

## Thanks!

This gem is hugely inspired by and (in parts) copied from [ActiveDecorator](https://github.com/amatsuda/active_decorator).