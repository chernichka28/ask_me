module UsersHelper
  def nickname_with_at(user)
    "@#{user.nickname}"
  end
end
