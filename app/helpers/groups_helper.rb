module GroupsHelper

  def invite_accepted? group, user
    Membership.where(group: group, user: user).first.accepted
  end

end