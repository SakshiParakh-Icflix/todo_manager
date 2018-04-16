class V1::TodosController < V1::BaseController
	before_action :get_user
	before_action :get_todo, only: [:update, :list_tasks, :destroy]	
	
	def index
		render json: { data: @user.todos }
	end

	def create
		@todo = @user.todos.build(todo_params)
		if @todo.save
			render json: { message: "A new todo was successfully created", todo: @todo }
		else
			render json: { message: "Could not create a new todo",
										errors: @todo.errors.full_messages.join(',') },
										status: unprocessable_entity
		end
	end
	
	def update
		if @todo.update_attributes(todo_params)
			render json: { message: "Todo updated successfully", todo: @todo }
		else
			render json: { message: "Could not update the todo",
										errors: @todo.errors.full_messages.join(',') },
										status: unprocessable_entity
		end
	end

	def list_tasks
		render json: { tasks: @todo.tasks }
	end

	def destroy
		if @todo.destroy
			render json: { message: "Todo deleted successfully" }
		else
			render json: { message: "Could not delete the todo",
										errors: @todo.errors.full_messages.join(',') },
										status: unprocessable_entity
		end
	end

	private

	def get_user
		@user = @current_user
	end
	
	def get_todo 
		@todo = Todo.find(params[:id])
	end

	def todo_params
  	params.require(:todo).permit(:title)
  end

end
