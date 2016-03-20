# Build an ActionCable Chat Service

1. New App

    ```bash
    # new rails app
    rails _5.0.0.beta3_ new ac && cd ac
    # initialize Git
    git init && git add .
    # first commit
    git commit -am "initial commit"
    ```

2. Generate the Rooms Controller and Message Model

    ```bash
    rails g controller rooms show
    rails g model message content:text
    rails db:migrate
    # commit
    git add .
    git commit -am "Rooms Crontroller and Message Model"
    ```

    Add a test message:
    ```ruby
    Message.create content: 'hello world'
    ```

3. Update the routes to send root to rooms#show

    routes.rb:
    ```ruby
    root to: 'rooms#show'
    ```

4. Start the server and open the browser and show that the app is up
    
    ```bash
    rails server
    ```
    
    http://localhost:3000

5. Set up the controller method and message views

    rooms_controller.rb:
    ```
    def show
      @messages = Message.all
    end
    ```

    show.html.erb
    
    _message.html.erb
    
    ```bash
    git add .
    git commit -am "Add rooms/message views"
    ```

6. Pop open the browser again

   http://localhost:3000

7. Generate our ActionCable room channel with 'speak' action:
    ```bash
    rails g channel room speak
    ```
8. Uncomment App in *cable.coffee* and ActionCable mount in *routes.rb*

9. Implement received and speak in room.coffee

10. Implement speak in room_channel.rb
    ```ruby
    def speak(data)
       ActionCable.server.broadcast 'room_channel', data['message']
     end
    ```
    ```bash
    git add .
    git commit -am "ActionCable Enabled"
    ```

11. Restart Rails Server and Demo via JS console

12. Add form field and required JavaScript to send messages..

13. Remove <p> from room.coffee received method

14. Update channel 'speak' implementation to actually write to the db.

15. Generate Job to handle Broadcasts

    ```ruby
    rails g job BroadcastMessage
    ```

16. Add after_create_commit hook to send broadcast job.

    ```ruby
    after_create_commit { BroadcastMessageJob.perform_later self }
    ```
    
    ```bash
    git add .
    git commit -am "Fin"
    ```

17. Restart rails server and demo working ActionCable in browser.

18. Set up devise

    Add to the Gemfile:
    ```ruby
    gem 'devise', github: 'plataformatec/devise'
    ```
    
    Install Devise and Generate User Model
    ```bash
    bundle install
    rails g devise:install
    rails g devise User
    rails g migration AddUserToMessages user:references:index
    rails db:migrate
    git add .
    git commit -am "Devise and User Model"
    ```

19. Add belongs_to to Message Model:

    message.rb:
    ```ruby
    belongs_to :user
    ```
     
20. Update add devise before_action to controller:
  
    rooms_controller.rb:
    ```ruby
    before_action :authenticate_user!
    ```

21. Update v2 files
    
    application.html.erb
    _message.html.erb
    room.coffee
    rooms.coffee
    show.html.erb

22. Explain current_user, warden config. Add warden hooks:

    Populate:
    config/initializers/warden_hooks.rb
    connection.rb

23. Demonstrate in the browser. *RESTART SERVER*

24. v3 STYLE
