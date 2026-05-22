class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all
  end

  def completed
    @tasks = Task.completed
    render :index
  end

  def due_this_week
    @tasks = Task.due_this_week
    render :index
  end

  def pending_sorted
    @tasks = Task.where(completed: [ false, nil ]).order(:due_date)
    render :index
  end

  def closest_three
    @tasks = Task.where("due_date >= ?", Date.current).order(:due_date).limit(3)
    render :index
  end

  def high_priority_tasks
    @tasks = Task.high_priority
    render :index
  end

  def search
    @tasks = Task.where("title LIKE ?", "%#{params[:query]}%")
    render :index
  end

  def show
    @attachments = Attachment.where(task_id: @task.id)

    @attachment = Attachment.new(task_id: @task.id)
  end
  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        if params[:attachment] && params[:attachment][:filename].present? && params[:attachment][:url].present?
          Attachment.create(
            filename: params[:attachment][:filename],
            url: params[:attachment][:url],
            task_id: @task.id
          )
        end

        format.html { redirect_to @task, notice: "Завдання успішно створено." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        if params[:attachment] && params[:attachment][:filename].present? && params[:attachment][:url].present?
          Attachment.create(
            filename: params[:attachment][:filename],
            url: params[:attachment][:url],
            task_id: @task.id
          )
        end

        format.html { redirect_to @task, notice: "Завдання успішно оновлено." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "Task was successfully destroyed."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :category, :priority, :due_date, :estimated_hours, :completed, :notes)
  end
end
