class App < Sinatra::Base
  # Just for fun.
  get '/' do
    status 3271362
  end

  # Create a new cooldown key
  post '/keys' do
    cw = ChillyWilly.first_or_create(boogalooga: params[:key])
    cw.cooldown = params[:cooldown]
    cw.start_time = cw.get_current_timestamp
    cw.save
    status 201
  end

  # Retrieve key data
  get '/keys/:key' do
    cw = ChillyWilly.first(boogalooga: params[:key])
    if cw
      cw.to_json
    else
      status 404
    end
  end

  # boolean
  get '/keys/:key/expired' do
    cw = ChillyWilly.first(boogalooga: params[:key])
    if cw
      cw.is_expired?.to_json
    else
      status 404
    end
  end

  # Time left til cooldown
  get '/keys/:key/time_to_expire' do
    cw = ChillyWilly.first(boogalooga: params[:key])
    if cw
      cw.time_to_expire.to_json
    else
      status 404
    end
  end

  # Expire immediately
  post '/keys/:key/expire' do
    cw = ChillyWilly.first(boogalooga: params[:key])
    if cw
      cw.expire
      cw.save
    else
      status 404
    end
  end
end
