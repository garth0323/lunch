class GroupsController < ApplicationController

  def new
    @group = Group.new
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
    group_params[:user_ids].each do |id|
      @group.memberships.create(user_id: id)
    end
    redirect_via_turbolinks_to restaurant_group_path(@group)
  end

  def restaurant
    @group = Group.find params[:id]

  end

  private

  def group_params
    params.require(:group).permit(:appointment, :user_ids => [])
  end

end