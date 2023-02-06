|       User       |        Label       |        Task       |
|:----------------:|:------------------:|:-----------------:|
| user_name:string | user_id:references | title:string      |
| email:string     | task_id:references | content:text      |
| password:string  | label_name:string  | deadline:datatime |
|                  |                    | priority:integer  |
|                  |                    | status:integer    |