|       User       |        Label       |        Task       |
|:----------------:|:------------------:|:-----------------:|
| user_name:string | user_id:references | title:string      |
| email:string     | task_id:references | content:text      |
| password:string  | label_name:string  | deadline:datatime |
|                  |                    | priority:integer  |
|                  |                    | status:integer    |

<br>
<h1>Herokuデプロイ手順</h1>
- $heroku create
- $bundle lock --add-platform x86_64-linux
- $heroku stack:set heroku -20
- package.jsにnode.jsのバージョンを追記
- $git add
- $git commit
- git push heroku step2:master
- heroku run rails db:migrate