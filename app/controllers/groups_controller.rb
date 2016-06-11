class GroupsController < ApplicationController
  before_filter :authenticate_user!
  before_action :find_group, except: [:create, :new, :index]

  def index
    @groups = current_user.groups.time_and_place.page(params[:page]).per(10)
  end

  def new
    @group = Group.new
  end

  def show

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

  end

  def update
    ids = group_params[:user_ids].reject &:blank?
    ids.each do |id|
      user = User.find id
      @group.memberships.create(user: user)
    end
    Membership.where(group: @group, user: current_user).first.update!(accepted: true)
    redirect_via_turbolinks_to restaurant_group_path(@group)
  end

  def restaurant
    @all_upvoted = @group.all_upvoted_no_downvotes
    @one_upvoted = @group.one_upvoted_no_downvotes
    @no_veto = @group.no_downvotes
  end

  def choose_restaurant
    restaurant = Restaurant.find params[:restaurant]
    @group.update restaurant: restaurant
    @group.users.each do |user|
      Membership.where(group: @group, user: user).first.update!(accepted: false) unless user == current_user
      InviteMailer.invite_email(user, @group).deliver_now! unless user == current_user
    end
    redirect_via_turbolinks_to group_path(@group)
  end

  def accept_invitation
    Membership.where(group: @group, user: current_user).first.update!(accepted: true)
    redirect_via_turbolinks_to group_path(@group)
  end

  private

  def group_params
    params.require(:group).permit(:appointment, :user_ids => [])
  end

  def find_group
    @group = Group.find params[:id]
  end

end