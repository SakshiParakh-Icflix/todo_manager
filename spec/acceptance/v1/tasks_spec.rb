require 'acceptance_helper'

resource "Task" do
  let(:user) { create(:user) }
	let(:device) { create :device, user: user }
  let(:todo) { create :todo, user: user }
	let(:todo_id) { todo.id }
  let(:task) { create :task, todo: todo }
	let(:id) { task.id }
  before do
    header 'Accept', 'application/version=1+json'
    header 'Content-Type', 'application/json'
    header 'X-API-KEY', device.api_key
		header 'Authorization', device.auth_token
  end

  get "todos/:todo_id/tasks" do
    parameter :todo_id, "Todo ID", required: true
		example_request"List tasks" do
			expect(JSON.parse(response_body)["data"]).to eq(JSON.parse(todo.tasks.to_json))
      expect(status).to eq(200)
    end
  end

	post "todos/:todo_id/tasks" do
		with_options scope: :task do
      parameter :name, "Name of the item or task", required: true
      parameter :done, "Status of the task"
      parameter :target_date, "Target date of completion of the task"
      parameter :completion_date, "Actual date of completion of the task"
    end

    let(:name) {'Buy Apples'}
		let(:done) { false }
    let(:raw_post) { params.to_json }

    example_request"Create a Task" do
      explanation "Create a task or item in a todo folder"
      expect(status).to eq(200)
    end
	end
	
	put "todos/:todo_id/tasks/:id" do
		with_options scope: :task do
      parameter :name, "Name of the item or task", required: true
      parameter :done, "Status of the task"
      parameter :target_date, "Target date of completion of the task"
      parameter :completion_date, "Actual date of completion of the task"
    end
		parameter :todo_id, "Todo ID", required: true
		parameter :id, "Task ID", required: true

    let(:name) {'Buy Oranges'}
		let(:done) { true }
    let(:raw_post) { params.to_json }

    example_request"Update a Task" do
      explanation "update a particular task or item"
      expect(status).to eq(200)
    end
	end

	get "/todos/:todo_id/tasks/:id" do
		parameter :todo_id, "Todo ID", required: true
		parameter :id, "Task ID", required: true

    example_request"Show Task" do
      explanation "show a particular todo"
      expect(status).to eq(200)
    end
		
	end
	
	delete "/todos/:todo_id/tasks/:id" do
		parameter :todo_id, "Todo ID", required: true
		parameter :id, "Task ID", required: true
    
		example_request"Delete Task" do
      explanation "delete task in a todo"
      expect(status).to eq(200)
    end
	end
	
end
