class LessonsController < ApplicationController

  before_action :check_enrollment

  def show
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def check_enrollment
    if !current_user.enrolled_in?(current_lesson.section.course)
      flash[:error] = 'You must enroll in the course before you can view the lessons'
      redirect_to course_path(current_lesson.section.course)
    end
  end
end
