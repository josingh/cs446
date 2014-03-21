#!/usr/bin/ruby

require 'sinatra'
require 'data_mapper'
require 'sqlite3'
require 'rack'
require 'csv'
require_relative 'book'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/books.sqlite3.db")


get '/list' do
  @sort = "id"
  @books = Book.all
  erb :list
end

post '/list' do
  @post = params[:post]
  puts "JKLSDFJKL:DFJKLDSF #{@post[:sort]}"
  @sort = @post['sort']
  if @sort == "author"
    @books = Book.all(:order => :author)
  elsif @sort == "id"
    @books = Book.all(:order => :id)
  elsif @sort == "title"
    @books = Book.all(:order => :title)
  elsif @sort == "language"
    @books = Book.all(:order => :language)
  elsif @sort == "published"
    @books = Book.all(:order => :published)
  end
  erb :list
end

get '/form' do
  erb :form
end
