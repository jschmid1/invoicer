class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    tasks_to_user unless Task.first.nil?
    @free_user =  check_for_free_users unless Task.first.nil?
    @current_tasks = show_current_tasks unless Task.first.nil?
    @free_tasks = find_free_tasks unless Task.first.nil?
    @tasks = Task.all.where(flat_id: current_user.flat_id)
    respond_with(@tasks)
  end

  def show
    respond_with(@task)
  end

  def new
    @task = Task.new
    respond_with(@task)
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.save
    respond_with(@task)
  end

  def update
    @task.update(task_params)
    respond_with(@task)
  end

  def destroy
    @task.destroy
    respond_with(@task)
  end

  def show_current_tasks
    WorkingOnTask.where("end_time >= ?", Time.now).where(user_id: User.where(flat_id: current_user.flat_id))
  end

  def check_for_free_users
    users_with_tasks = WorkingOnTask.where("end_time > ?", Time.now).where(user_id: User.where(flat_id: current_user.flat_id)).map(&:user_id)
    all_users = User.where(flat_id: current_user.flat_id).map(&:id)
    all_users - users_with_tasks
  end

  def find_free_tasks
    tasks = WorkingOnTask.where("end_time >= ?", Time.now).where(user_id: User.where(flat_id: current_user.flat_id)).map(&:task_id)
    all_tasks = Task.all.where(flat_id: current_user.flat_id).map(&:id)
    all_tasks - tasks
  end

  def tasks_to_user
    unless check_for_free_users.empty?
      check_for_free_users.each do |user_id|
        unless find_free_tasks.empty?
          if  already_did_this_shit(user_id).map(&:task_id).count >= Task.all.count
            WorkingOnTask.new(user_id: user_id, task_id: already_did_this_shit(user_id).map(&:task_id).first, start_time: calculate_time_from_interval('start', task_id), end_time: calculate_time_from_interval('end', task_id)).save
          else
            (find_free_tasks- already_did_this_shit(user_id).map(&:task_id)).each do |task_id|
              WorkingOnTask.new(user_id: user_id, task_id: task_id, start_time: calculate_time_from_interval('start', task_id), end_time: calculate_time_from_interval('end', task_id)).save
              break

            end
          end
        end
      end
    end
    # scopes... ZOMG
    # done button
    # calculate credits based on relation table
    # only give credit if done&&end_time

  end

  # The tasks that the specified user[(user_id)] has already done and should not do again.
  def already_did_this_shit(user_id)
    @ids =[]
    WorkingOnTask.where(user_id: user_id).order(:created_at).limit(Task.all.count).each do |task|
      if @ids.include?(task.task_id)

      else
        @ids.append(task.id) unless @ids.include?(user_id)
      end

    end
    # if @ids.count >= Task.all.count pick first of list
    #
    # end
    #get all tasks from user X
    #sort it by creation date
    #map task_ids until mapped_id already is in array.
    # subract mapped_ids from free_tasks.
  end

  def release_user
    # ? needed ?
    # ? needed ?
  end


  def calculate_time_from_interval(start_or_stop, task_id)
    case Task.find_by(id: task_id).interval
      when 'Every 2 Weeks'
        return Time.now if start_or_stop == 'start'
        return Time.now + 2.minutes if start_or_stop == 'end'
      # return Time.now + 2.weeks if start_or_stop == 'end'
      when 'Every Day'
        return Time.now if start_or_stop == 'start'
        return Time.now + 1.minutes if start_or_stop == 'end'
      # return Time.now + 1.days if start_or_stop == 'end'
      when 'Every Week'
        return Time.now if start_or_stop == 'start'
        # return Time.now + 1.weeks if start_or_stop == 'end'
        return Time.now + 1.minutes if start_or_stop == 'end'
      when 'Every 3 Weeks'
        return Time.now if start_or_stop == 'start'
        return Time.now + 3.weeks if start_or_stop == 'end'
      when 'Every 4 Weeks'
        return Time.now if start_or_stop == 'start'
        return Time.now + 4.weeks if start_or_stop == 'end'
      when 'Every Year'
        return Time.now if start_or_stop == 'start'
        return Time.now + 1.years if start_or_stop == 'end'
      else
        puts "Something went wrong"
    end
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :credit, :interval, :flat_id)
  end
end
