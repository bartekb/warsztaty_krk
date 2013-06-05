warsztaty_krk
=============

Szkoleniowa aplikacja na warsztaty 6 czerwca 2013 na Politechnice Krakowskiej

### Krok 1

    sudo apt-get install curl git-core
    curl -L get.rvm.io | bash -s stable
    source ~/.profile

### Krok 2

    type rvm | head -n 1
    rvm requirements
    rvm install 1.9.3

### Krok 3

    /bin/bash --login
    rvm use 1.9.3 --default
    gem install rails

### Krok 4

    rails new warsztaty
    cd warsztaty/
    ls -l

### Krok 5

    vim Gemfile

Gemfile << odkomentować    gem 'therubyracer', :platforms => :ruby

    bundle install


    rails s

otwieramy przeglądarkę na http://localhost:3000

Działa :)

### Krok 6

otwieramy drugą zakładkę terminala i wchodzimy do katalolgu aplikacji

    rails generate scaffold Author first_name:string last_name:string age:integer is_dead:boolean
    
    rake db:migrate

otwieramy przeglądarkę na http://localhost:3000/authors
otwieramy przeglądarkę na http://localhost:3000/authors.json

### Krok 7

poużywajmy konsoli do zabawy z interakcji z DB

w otwartej zakładce terminala

    rails c
    Author
    Author.all
    Author
    Author.create(:first_name => "Jaroslaw", :last_name => "Grzedowicz")

    @author = Author.new
    @author.first_name = "Stanislaw"
    @author.last_name = "Lem"
    @author.save
    Author.last
    @author = Author.find_by_last_name("Lem")
    @author.update_attributes :first_name => "Stas"
    @author.destroy
    exit

### Krok 8

dodajmy artukuły i powiążmy je z autorem

    rails generate scaffold Book title:string author:references

    rake db:migrate

otwieramy przeglądarkę na http://localhost:3000/books

    vim app/views/books/_form.html.erb

zmieniamy w lini 20 na   f.select(:author_id, Author.all.collect {|p| [ p.first_name, p.id ] })
próbujemy dodać teraz książkę, ale mamy błąd

    vim app/models/book.rb

zmieniamy >>  attr_accessible :title, :author_id

### Krok 9

działa :) teraz próbujemy wejść na widok książki ale autor jest niepoprawnie wyświetlony

    vim app/models/author.rb

dodajemy nową metodę wirtualną >>   

    def full_name
      "#{first_name} #{last_name}"
    end

    vim app/views/books/show.html.erb

zmieniamy w lini 10  >>   @book.author.full_name

    vim app/views/books/index.html.erb

zmieniamy w lini 15  >>   book.author.full_name

### Krok 10

ok, teraz dodamy nowe pole z dokładną datą wydania książki

    rails generate migration add_published_at_to_books published_at:datetime


    vim db/migrate/*_add_published_at_to_books.rb

    rake db:migrate

    vim app/models/book.rb

zmieniamy >>  attr_accessible :title, :author_id, :published_at

    vim app/views/books/_form.html.erb

dodajemy pole do edycji daty

    <div class="field">
        <%= f.label :published_at %><br />
        <%= f.date_select :published_at %>
    </div>

### Krok 11

dodanie gema odpowiedzialnego za paginację do projektu

odwiedzamy http://localhost:3000/authors
dodajemy ponad 10 nowych autorów 
odwiedzamy https://github.com/amatsuda/kaminari i czytamy dokumentację

    vim Gemfile
    
dodajemy  >>   gem 'kaminari'

    bundle install

zatrzymujemy nasz serwer CTRL+C w oknie gdzie jest uruchomiony

### Krok 12

    rails generate kaminari:config
    rails s
    vim app/models/author.rb

dodajemy co ile rekordów chcemy nową stronę, pod attr_accessible   >>   paginates_per(10)

    vim app/views/authors/index.html.erb

dodajemy wyświetlanie paginacji, na samym dole pliku dodajemy  >>  <%= paginate @authors %>

    vim app/controllers/authors_controller.rb

musimy powiedzieć kontrolerowi, że chcemy dokonywać podziału na strony   >>  linię 5 zmieniamy na @authors = Author.page(params[:page])
