class App < Sinatra::Base
  get '/' do
    status 3271362
  end

  post '/keys' do
    cw = ChillyWilly.first_or_create(boogalooga: params[:key])
    cw.cooldown = params[:cooldown]
    cw.start_time = cw.get_current_timestamp
    cw.save
    status 201
  end

  get '/keys/:key' do
    cw = ChillyWilly.first(boogalooga: params[:key])
    if cw
      cw.to_json
    else
      status 404
    end
  end

  get '/keys/:key/expired' do
    cw = ChillyWilly.first(boogalooga: params[:key])
    if cw
      cw.is_expired?.to_json
    else
      status 404
    end
  end

end
