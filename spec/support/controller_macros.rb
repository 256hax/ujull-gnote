module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user         = FactoryBot.create(:user)
      #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end

  def logout_user
    before(:each) do
      sign_out :user
    end
  end

  def login_another_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:another_user]
      another_user         = FactoryBot.create(:another_user)
      #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in another_user
    end
  end

  def logout_another_user
    before(:each) do
      sign_out :another_user
    end
  end
end
