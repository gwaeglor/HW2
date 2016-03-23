Resque::Server.use(Rack::Auth::Basic) do |user, password|
  user == "abc"
  password == "abc"
end