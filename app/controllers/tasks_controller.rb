class TasksController < ApplicationController
  require 'yaml'
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

  def check_recent_tasks_from_user(user_id)
    file = 'config/user_tasks.yml'
    data = YAML::load_file(file)
    if data[user_id].count >= Task.count
      data[user_id] = []
      return data[user_id]
    end
    data[user_id]
  end

  def update_user_status(user_id, task_id)
    file = 'config/user_tasks.yml'
    data = YAML::load_file(file)
    data[user_id].push(task_id)
    if data[user_id].count >= Task.count
      data[user_id] = []
    end
    File.open(file, 'w') {|f| f.write data.to_yaml }
  end


  def tasks_to_user
    unless check_for_free_users.empty?
      check_for_free_users.each do |user_id|
       unless find_free_tasks.empty?
         potential_tasks = (find_free_tasks - check_recent_tasks_from_user(user_id))
         if potential_tasks.any?
           users_task = potential_tasks.first
           WorkingOnTask.create(user_id: user_id, task_id: users_task, start_time: calculate_time_from_interval('start', users_task), end_time: calculate_time_from_interval('end', users_task))
           update_user_status(user_id, users_task)
         else
           break
         end
       end
      end
    end
  end

  def calculate_time_from_interval(start_or_stop, task_id)
    case Task.find_by(id: task_id).interval
      when 'Every 2 Weeks'
        return Time.now if start_or_stop == 'start'
        return Time.now + 2.weeks if start_or_stop == 'end'
      when 'Every Day'
        return Time.now if start_or_stop == 'start'
        return Time.now + 1.days if start_or_stop == 'end'
      when 'Every Week'
        return Time.now if start_or_stop == 'start'
        return Time.now + 1.weeks if start_or_stop == 'end'
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
