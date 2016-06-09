class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def show
    @group = Group.find params[:id]
  end

  def create
    ActiveRecord::Base.transaction do
      @group = Group.create! group_params
      @group.memberships.create(user: current_user)
    end
    if @group.appointment.present?
      redirect_via_turbolinks_to edit_group_path(@group)
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def edit
    @group = Group.find params[:id]
  end

  def update
    @group = Group.find params[:id]
    ids = group_params[:user_ids].reject &:blank?
    ids.each do |id|
      user = User.find id
      @group.memberships.create(user: user)
    end
    byebug
    Membership.where(group: @group, user: current_user).first.update!(accepted: true)
    redirect_via_turbolinks_to restaurant_group_path(@group)
  end

  def restaurant
    @group = Group.find params[:id]
    @all_upvoted = @group.all_upvoted_no_downvotes
    @one_upvoted = @group.one_upvoted_no_downvotes
    @no_veto = @group.no_downvotes
  end

  def choose_restaurant
    @group = Group.find params[:id]
    restaurant = Restaurant.find params[:restaurant]
    @group.update restaurant: restaurant
    @group.users.each do |user|
      InviteMailer.invite_email(user, @group).deliver! unless user == current_user
    end
    redirect_via_turbolinks_to group_path(@group)
  end

  def accept_invitation
    @group = Group.find params[:id]
    Membership.where(group: @group, user: current_user).first.update!(accepted: true)
    redirect_via_turbolinks_to group_path(@group)
  end

  private

  def group_params
    params.require(:group).permit(:appointment, :user_ids => [])
  end

end