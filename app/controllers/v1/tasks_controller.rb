class V1::TasksController < V1::BaseController
	before_action :get_todo, only: [:index, :create]
	before_action :get_task, except: [:index, :create]
	
	def index
		render json: { data: @todo.tasks }
	end

	def create
		@task = @todo.tasks.build(task_params)
		if @task.save
			render json: { message: "A new task was successfully created", task: @task }
		else
			render json: { message: "Could not create a new task",
										errors: @task.errors.full_messages.join(',') },
										status: unprocessable_entity
		end
	end
	
	def show
		render json: { task: @task }
	end

	def update
		if @task.update_attributes(task_params)
			render json: { message: "Task updated successfully", task: @task }
		else
			render json: { message: "Could not update the task",
										errors: @task.errors.full_messages.join(',') },
										status: unprocessable_entity
		end
	end

	def destroy
		if @task.destroy
			render json: { message: "Task deleted successfully" }
		else
			render json: { message: "Could not delete the task",
										errors: @task.errors.full_messages.join(',') },
										status: unprocessable_entity
		end	
	end

	private
	
	def get_todo 
		@todo = Todo.find(params[:todo_id])
	end

	def get_task
		@task = Task.find(params[:id])
	end

	def task_params
  	params.require(:task).permit(:name, :done, :target_date, :completion_date)
  end

end
