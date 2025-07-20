class TeamTasksController < ApplicationController
  before_action :set_team_task, only: %i[ show update destroy ]

  # GET /team_tasks
  def index
    @team_tasks = TeamTask.all

    render json: @team_tasks
  end

  # GET /team_tasks/1
  def show
    render json: @team_task
  end

  # POST /team_tasks
    def create
    task = TeamTask.new(team_task_params)

    if task.save
      render json: { message: "Tarefa criada com sucesso!", task: task }, status: :created
    else
      render json: {
        message: "Falha ao criar a tarefa: campos obrigatórios ausentes ou inválidos.",
        errors: format_errors(task.errors)
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /team_tasks/1
  def update
    if @team_task.update(team_task_params)
      render json: { message: "Tarefa atualizada com sucesso.", data: @team_task }, status: :ok
    else
      render json: {
        message: "Falha ao atualizar a tarefa: campos obrigatórios ausentes ou inválidos.",
        errors: format_errors(@team_task.errors)
      }, status: :unprocessable_entity
    end
  end

  # DELETE /team_tasks/1
  def destroy
    if @team_task.destroy
    render json: { message: "Tarefa deletada com sucesso!" }, status: :ok
  else
    render json: { error: "Não foi possível deletar a tarefa." }, status: :unprocessable_entity
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_task
      @team_task = TeamTask.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def team_task_params
      params.expect(team_task: [ :title, :description, :status, :assigned_to, :due_date ])
    end
end

  def format_errors(errors)
    errors.messages.map do |field, messages|
      {
        field: field,
        messages: messages
      }
    end
  end