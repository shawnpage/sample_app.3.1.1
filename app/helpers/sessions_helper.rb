module SessionsHelper
  
  def sign_in(user)
    session[:current_user_id] = user.id
    self.current_user = User.find(session[:current_user_id])
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= session[:current_user_id] &&
      User.find_by_id(session[:current_user_id])
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    @current_user = session[:current_user_id] = nil
  end

  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end

end
