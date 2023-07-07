# TodoList


간단한 TodoList 제작  


| 종류     | 기술              |
| -------- | ----------------- |
| Client   | Flutter           |
| Server   | Spring Boot       |
| Database | MySQL / workbench |

제작기간 2023/07/05 ~

## 서버 요청, 응답

### createTodo

요청  
- URL : `/todo`
- Method : `POST`
- Header :  
        Content-Type: `application/json`
- Body : `(예시)`
  ```json
    {
    "id" : 0,
    "title" : "New todo",
    "content" : "you can do it",
    "isChecked" : false
    }
  ```

응답
- status : `201 created`
- body : `TodoDTO`


### readTodo

요청  
- URL : `/todo/{id}`
- Method : `GET`
- Header : `없음`
- Body : `없음`

응답
- status : `200 OK`
- body : `TodoDTO`  
  ```json
    {
    "id" : 0,
    "title" : "New todo",
    "content" : "you can do it",
    "isChecked" : false
    }
  ```


### readAllTodo

요청  
- URL : `/todo`
- Method : `GET`
- Header : `없음`
- Body : `없음`

응답
- status : `200 OK`
- body : `TodoDTO`  
  ```json
  [
    {
    "id" : 0,
    "title" : "New todo",
    "content" : "you can do it",
    "isChecked" : false
    }
    {
    "id" : 1,
    "title" : "New todo",
    "content" : "you can do it",
    "isChecked" : false
    }
    ]
  ```


### updateTodo

요청  
- URL : `/todo`
- Method : `PUT`
- Header :  
  Content-Type: `application/json`
- Body : `(예시)`
    ```json
    {
    "id" : 0,
    "title" : "update todo",
    "content" : "update!!",
    "isChecked" : true
    }
  ```

응답
- status : `200 OK`
- body : `TodoDTO`  
  ```json
    {
    "id" : 0,
    "title" : "update todo",
    "content" : "update!!",
    "isChecked" : true
    }
  ```


### deleteTodo

요청  
- URL : `/todo/{id}`
- Method : `DELETE`
- Header : `없음`
- Body : `없음`

응답
- status : `200 OK`
- body : `없음`




