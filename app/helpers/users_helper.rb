module UsersHelper
  def nickname_with_at(current_user)
    "@#{current_user.nickname}"
  end
end
