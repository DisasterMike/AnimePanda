# 📚 AnimePanda

AnimePanda is a site that allows a user to find new anime shows to watch and add them to a watchlist. The app utilizes ChatGPT and the MyAnimeList API to find filter recommendations based on the users inputed preferences and previously watched animes.
This app was created for a final project of our full-stack web developer boot camp at Le Wagon Tokyo.

<img width="291" alt="AnimePanda Home Page" src="https://github.com/user-attachments/assets/eda4c014-0a77-4a61-a5b5-aab803a8015f">
<br>
App home: <strong>https://www.animepanda.me/</strong>
   

## Getting Started
### Setup

Install gems
```
bundle install
```

### ENV Variables
Create `.env` file
```
touch .env
```
Inside `.env`, set these variables. For any APIs, see group Slack channel.
```
Please add MAL API Key (MyAnimeList.net).
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### Run a server
```
rails s
```

## Built With
- [Rails 7](https://guides.rubyonrails.org/) - Backend / Front-end
- [Stimulus JS](https://stimulus.hotwired.dev/) - Front-end JS
- [Heroku](https://heroku.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling
- [Figma](https://www.figma.com) — Prototyping

## Team Members
- [Michael Stump](https://www.linkedin.com/in/michael-stump-79695a324/)
- [Junichi Kinami](https://www.linkedin.com/in/junichikinami/)
- [Ramone Robertson](https://www.linkedin.com/in/ramone-robertson/)
- [Seisuke Fukuda](https://www.linkedin.com/in/seisuke-fukuda-902b3a314/)

