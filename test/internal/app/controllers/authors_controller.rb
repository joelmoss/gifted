class AuthorsController < ActionController::Base
  def index
    @authors = if Author.respond_to?(:scoped)
                 # ActiveRecord 3.x
                 if params[:variable_type] == 'array'
                   Author.all
                 elsif params[:variable_type] == 'proxy'
                   RelationProxy.new(Author.scoped)
                 else
                   Author.scoped
                 end
               elsif params[:variable_type] == 'array'
                 # ActiveRecord 4.x
                 Author.all.to_a
               elsif params[:variable_type] == 'proxy'
                 RelationProxy.new(Author.all)
               else
                 Author.all
               end
  end

  def show
    @author = Author.find params[:id]
  end
end

# Proxy for ActiveRecord::Relation
class RelationProxy < BasicObject
  attr_accessor :ar_relation

  def initialize(ar_relation)
    @ar_relation = ar_relation
  end

  def method_missing(method, *args, &block)
    @ar_relation.public_send(method, *args, &block)
  end
end
