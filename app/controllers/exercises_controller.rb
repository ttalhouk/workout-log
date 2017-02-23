class ExercisesController < ApplicationController
  before_action :set_exercise, only:[:show,:edit,:update,:destroy]
  def index
    @exercises = current_user.exercises.where('workout_date > ?', 7.days.ago).order(workout_date: :desc)
    @friends = current_user.friends
  end

  def show
  end

  def new
    @exercise = current_user.exercises.new
  end
  def create
    @exercise = current_user.exercises.new(exercise_params)
    if @exercise.save
      flash[:notice] = 'Exercise has been created'
      redirect_to user_exercise_path(current_user, @exercise)
    else
      flash.now[:danger] = 'Exercise could not be created'
      render :new

    end


  end

  def edit

  end

  def update

    if @exercise.update(exercise_params)
      flash[:success] = 'Exercise has been updated'
      redirect_to user_exercise_path(current_user, @exercise)
    else
      flash.now[:danger] = 'Exercise could not be updated'
      render :edit
    end
  end
  def destroy

    if @exercise.delete
      flash[:success] = 'Exercise has been deleted'
    else
      flash[:danger] = 'Exercise could not be deleted'
    end
      redirect_to user_exercises_path(current_user)
  end

  private

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end
  def exercise_params
    params.require(:exercise).permit(:duration, :workout, :workout_date)
  end
end
