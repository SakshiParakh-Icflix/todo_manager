require 'acceptance_helper'

resource "Todo" do
  let(:user) { create(:user) }
	let(:device) { create :device, user: user }
  let(:todo) { create :todo, user: user }
	let(:id) { todo.id }
  before do
    header 'Accept', 'application/version=1+json'
    header 'Content-Type', 'application/json'
    header 'X-API-KEY', device.api_key
		header 'Authorization', device.auth_token
  end

  get "/todos" do
    before do
      ['Paris Tour', 'Amsterdam Tour', 'Grocery Shopping'].each do |i|
        Todo.create(title: i, user_id: user.id)
      end
    end
    example_request"Todos for a paritcular user" do
			expect(JSON.parse(response_body)["data"]).to eq(JSON.parse(user.todos.to_json))
      expect(status).to eq(200)
    end
  end

	post "/todos" do
		with_options scope: :todo do
      parameter :title, "Title of the todo", required: true
    end

    let(:title) {'Paris Tour'}
    let(:raw_post) { params.to_json }

    example_request"Create a Todo" do
      explanation "Create a main todo folder for which you can add multiple tasks or items"
      expect(status).to eq(200)
    end
	end
	
	put "/todos/:id" do
		with_options scope: :todo do
      parameter :title, "Title of the todo", required: true
    end
		parameter :id, "Todo ID", required: true

    let(:title) {'Paris Tour'}
    let(:raw_post) { params.to_json }

    example_request"Update a Todo" do
      explanation "update a particular todo"
      expect(status).to eq(200)
    end
	end

	get "/todos/:id/list_tasks" do
		before do 
      ['plan itinerary', 'book tickets', 'make reservations'].each do |i|
        Task.create(name: i, done: false, target_date: DateTime.tomorrow, completion_date: nil, todo_id: todo.id)
      end	
		end
		parameter :id, "Todo ID", required: true

    example_request"Todo Tasks" do
      explanation "get all the items in a todo"
      expect(status).to eq(200)
    end
		
	end
	
	delete "/todos/:id" do
		before do 
      ['plan itinerary', 'book tickets', 'make reservations'].each do |i|
        Task.create(name: i, done: false, target_date: DateTime.tomorrow, completion_date: nil, todo_id: todo.id)
      end	
		end
		parameter :id, "Todo ID", required: true
    
		example_request"Delete Todo" do
      explanation "delete todo and all its tasks"
      expect(status).to eq(200)
    end
	end
	
end
