module UsersHelper
  def user_choose_new
    if action_name == 'new'
      confirm_users_path
    elsif action_name == 'edit'
      user_path
    end
  end
end