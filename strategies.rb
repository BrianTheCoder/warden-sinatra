Warden::Manager.serialize_into_session{|user| p "----------------";p user;p user.id; user.nil? ? nil : user.id }
Warden::Manager.serialize_from_session{|id| p "==============#{id}"; id.nil? ? nil : User.get(id) }

Warden::Strategies.add(:password) do
  def valid?
    p params.inspect
    p params['email']
    params["email"] || params["password"]
  end

  def authenticate!
    p params.inspect
    p params['email']
    u = User.authenticate(params["email"], params["password"])
    p u
    u.nil? ? fail!("Could not log in") : success!(u)
  end
end