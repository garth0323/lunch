module GroupsHelper

  def invite_accepted? group, user
    Membership.where(group: group, user: user).first.accepted
  end

  def complete_invite group
    group.restaurant && group.appointment
  end

end