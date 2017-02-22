class ExercisesController < ApplicationController
  def index
    @exercises = current_user.exercises.where('workout_date > ?', 7.days.ago).order(workout_date: :desc)
  end

  def show
    @exercise = Exercise.find(params[:id])
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
    @exercise = Exercise.find(params[:id])
  end

  def update
    @exercise = Exercise.find(params[:id])
    if @exercise.update(exercise_params)
      flash[:success] = 'Exercise has been updated'
      redirect_to user_exercise_path(current_user, @exercise)
    else
      flash.now[:danger] = 'Exercise could not be updated'
      render :edit
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:duration, :workout, :workout_date)
  end
end
