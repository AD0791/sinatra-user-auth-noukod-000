class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  ## session
  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :home
  end

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do
    #binding.pry
    @user = User.create(params)
    session[:id] = @user.id
    #binding.pry
    #erb :'/users/home'
    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions/login' do
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    #binding.pry
    redirect '/users/home'
  end

  get '/sessions/logout' do
    #binding.pry
    session.clear
    #binding.pry
    redirect '/'
  end

  get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
