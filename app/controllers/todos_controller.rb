class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy, :complete, :incomplete]

  respond_to :html

  def index
    @todo = Todo.new
    @user_ids  = User.where(flat_id: current_user.flat_id).map {|x| x.id}
    @items_not_done = Todo.where(user_id: @user_ids).where(done: false).paginate(page: params[:page], per_page: 5)
    @items_done = Todo.where(user_id: @user_ids).where(done: true)
    respond_with(@todos)
  end

  def show
    respond_with(@todo)
  end

  def new
    @todo = Todo.new
    respond_with(@todo)
  end


  def complete
    @todo = Todo.find(params[:id])
    if @todo.update_attribute(:done, true)
      redirect_to todos_path
      flash[:success] = 'Marked as Complete'

    else
      redirect_to new_todo_path
    end
  end


  def incomplete
    @todo = Todo.find(params[:id])
    if @todo.update_attribute(:done, false)
      redirect_to todos_path
      flash[:success] = 'Marked as Incomplete'
    else
      redirect_to new_todo_path
    end
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.done = false
    @todo.save
    flash[:success] = 'Todo was successfully created.' if @todo.save
    redirect_to todos_path
  end

  def update
    @todo.update(todo_params)
    respond_with(@todo)
  end

  def destroy
    @todo.destroy
    respond_with(@todo)
  end

  private
    def set_todo
      @todo = Todo.find(params[:id])
    end

    def todo_params
      params.require(:todo).permit(:task, :done, :user_id)
    end
end
