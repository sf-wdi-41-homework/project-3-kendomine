class ProfilesController < ApplicationController
  before_action :profile_params_id, only: [:update, :edit, :destroy]
  before_action :authentication


  def index
    if current_user.profile
      @profile = current_user.profile
      @conversion= @profile.height * 30.48
      @height = @conversion * 6.25 
      @weight = @profile.weight * 0.45359237
      @age = 5 * @profile.age
      @fage = 5 * @profile.age - 165
      @bmr = 10 * @weight + @height - @age + 5 - 400
      @fbmr = 10 * @weight + @height -@fage 




      if @profile.gender == "Male"
        @tdee = @bmr * @profile.activity
        @bulk = @tdee + 500
        @cut = @tdee - 500
        @bprotein = @bulk * 0.30 / 4
        @bcarbs = @bulk * 0.40 / 4
        @bfat = @bulk * 0.30 / 9
        @cprotein = @cut * 0.40 / 4
        @ccarbs = @cut * 0.30 / 4
        @cfat = @cut * 0.30 / 9



      else

        @tdee = @fbmr * @profile.activity
        @bulk = @tdee + 500
        @cut = @tdee - 500
        @bprotein = @bulk * 0.30 / 4
        @bcarbs = @bulk * 0.40 / 4
        @bfat = @bulk * 0.30 / 9
        @cprotein = @cut * 0.40 / 4
        @ccarbs = @cut * 0.30 / 4
        @cfat = @cut * 0.30 / 9
      end
    else
      redirect_to new_profile_path
    end
  end

  def new
    if current_user.profile
      redirect_to my_profile_path
    end
  end

  def edit
    
  end

    def create
    @profile = Profile.new(profile_params)
    if current_user.profile = @profile
      flash[:success] = "You have created your profile"
      redirect_to my_profile_path
    else
      flash[:error] = @profile.errors.full_messages[0]
      redirect_to new_profile_path
    end
  end

  def update
    if @profile.update(profile_params)
      flash[:success] = "Successfully updated profile!"
      redirect_to my_profile_path
    else
      flash[:error] = @profile.errors.full_messages[0]
      redirect_to profile_path
    end
  end
end


