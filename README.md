# Running the server

```shell
bundle install
./bin/rails db:setup
./bin/rails s
```

# Requests

> List all users
```shell
curl -i -XGET http://localhost:3000/users
```
```json
[{"id":1,"name":"Karey Donnelly","email":"ira_halvorson@example.com","date_of_birth":"1965-03-14","created_at":"2019-03-17T15:35:51.224Z","updated_at":"2019-03-17T15:35:51.224Z","state_id":{"id":1,"user_id":1,"number":"464-26-6355","state":"South Dakota","expiration_date":"2020-11-05","image":{"url":"/uploads/state_id/image/1/300x300.png","thumb":{"url":"/uploads/state_id/image/1/thumb_300x300.png"}},"created_at":"2019-03-17T15:35:51.886Z","updated_at":"2019-03-17T15:35:51.886Z"},"medical_recommendations":[{"id":1,"user_id":1,"number":"741-96-9857","issuer":"Medical Recommendation Issuer","state":"Tennessee","expiration_date":"2022-06-22","image":{"url":"/uploads/medical_recommendation/image/1/300x300.png","thumb":{"url":"/uploads/medical_recommendation/image/1/thumb_300x300.png"}},"created_at":"2019-03-17T15:35:52.549Z","updated_at":"2019-03-17T15:35:52.549Z"}]}]
```

> Return a specific user
```shell
curl -i -XGET http://localhost:3000/users/1
```
```json
{"id":1,"name":"Karey Donnelly","email":"ira_halvorson@example.com","date_of_birth":"1965-03-14","created_at":"2019-03-17T15:35:51.224Z","updated_at":"2019-03-17T15:35:51.224Z","state_id":{"id":1,"user_id":1,"number":"464-26-6355","state":"South Dakota","expiration_date":"2020-11-05","image":{"url":"/uploads/state_id/image/1/300x300.png","thumb":{"url":"/uploads/state_id/image/1/thumb_300x300.png"}},"created_at":"2019-03-17T15:35:51.886Z","updated_at":"2019-03-17T15:35:51.886Z"},"medical_recommendations":[{"id":1,"user_id":1,"number":"741-96-9857","issuer":"Medical Recommendation Issuer","state":"Tennessee","expiration_date":"2022-06-22","image":{"url":"/uploads/medical_recommendation/image/1/300x300.png","thumb":{"url":"/uploads/medical_recommendation/image/1/thumb_300x300.png"}},"created_at":"2019-03-17T15:35:52.549Z","updated_at":"2019-03-17T15:35:52.549Z"}]}
```

> Create a new user
```shell
curl -i -XPOST -d "name=Deirdre Koepp Jr.&email=molly@example.org&date_of_birth=1985-09-11" http://localhost:3000/users
```
```json
{"id":21,"name":"Deirdre Koepp Jr.","email":"molly@example.org","date_of_birth":"1985-09-11","created_at":"2019-03-17T15:37:53.452Z","updated_at":"2019-03-17T15:37:53.452Z","state_id":null,"medical_recommendations":[]}
```

> Update a user (adding StateID)
```shell
curl -i -XPATCH -d "state_id_attributes[number]=422-94-2421&state_id_attributes[state]=South Carolina&state_id_attributes[expiration_date]=2025-02-01&state_id_attributes[remote_image_url]=https://via.placeholder.com/150" http://localhost:3000/users/21
```

> Update a user (adding MedicalRecommendation)
```shell
curl -i -XPATCH -d "medical_recommendations_attributes[0][number]=770-94-7912&medical_recommendations_attributes[0][issuer]=Medical Recommendation Issuer&medical_recommendations_attributes[0][state]=Oklahoma&medical_recommendations_attributes[0][expiration_date]=2020-01-01&medical_recommendations_attributes[0][remote_image_url]=https://via.placeholder.com/150" http://localhost:3000/users/21
```

> StateId and MedicalRecommendation can be created while creating the User, in a single request:
```shell
curl -i -XPOST -d "name=Deirdre Koepp Jr.&email=molly@example.org&date_of_birth=1985-09-11&state_id_attributes[number]=422-94-2421&state_id_attributes[state]=South Carolina&state_id_attributes[expiration_date]=2025-02-01&state_id_attributes[remote_image_url]=https://via.placeholder.com/150&medical_recommendations_attributes[0][number]=770-94-7912&medical_recommendations_attributes[0][issuer]=Medical Recommendation Issuer&medical_recommendations_attributes[0][state]=Oklahoma&medical_recommendations_attributes[0][expiration_date]=2020-01-01&medical_recommendations_attributes[0][remote_image_url]=https://via.placeholder.com/150" http://localhost:3000/users
```
```json
{"id":22,"name":"Deirdre Koepp Jr.","email":"molly@example.org","date_of_birth":"1985-09-11","created_at":"2019-03-17T15:38:44.636Z","updated_at":"2019-03-17T15:38:44.636Z","state_id":{"id":22,"user_id":22,"number":"422-94-2421","state":"South Carolina","expiration_date":"2025-02-01","image":{"url":"/uploads/state_id/image/22/150.png","thumb":{"url":"/uploads/state_id/image/22/thumb_150.png"}},"created_at":"2019-03-17T15:38:44.639Z","updated_at":"2019-03-17T15:38:44.639Z"},"medical_recommendations":[{"id":22,"user_id":22,"number":"770-94-7912","issuer":"Medical Recommendation Issuer","state":"Oklahoma","expiration_date":"2020-01-01","image":{"url":"/uploads/medical_recommendation/image/22/150.png","thumb":{"url":"/uploads/medical_recommendation/image/22/thumb_150.png"}},"created_at":"2019-03-17T15:38:44.645Z","updated_at":"2019-03-17T15:38:44.645Z"}]}
```

> To delete an User's StateID
```shell
curl -XPATCH -d "state_id_attributes[id]=1&state_id_attributes[_destroy]=1" http://localhost:3000/users/1
```

> To delete an User's MedicalRecommendation
```shell
curl -XPATCH -d "medical_recommendations_attributes[0][id]=1&medical_recommendations_attributes[0][_destroy]=1" http://localhost:3000/users/1
```

> When retrieving an User with expired StateID
```shell
curl -i -XGET http://localhost:3000/users/2
```
```json
{"message":"State ID is expired"}
```

> When retrieving an User with expired MedicalRecommendations
```shell
curl -i -XGET http://localhost:3000/users/2
```
```json
{"message":"Medical Recommendation is expired"}
```

----

# Original Instructions

# Card
As a user I would like to be able use my medical recommendation and id for multiple orders. I would also like to be able to replace or delete my id and medical recommendation.

# Discussion
Create a service for a dispensary, that stores users, medical recommendations and IDs.

The Users service should allow a user to upload a State ID and medical recommendation metadata. The user should be able to update or delete the ID or Rec.

Store users name, email, and dob

Store the medical recommendation number, issuer, state, expiration date and path to the image.

Store the State ID number, state, expiration date and path to the image.

Store images in a local directory. (Bonus)

If the id or recommendation is expired return expired.

# Notes 
Use you normal git workflow except on the initial commit add an estimate of how long it will take to complete the exercise. 

For example git commit -m "Initial commit 3 hours" 

# Confirmation
API endpoint that returns a User, medical recommendation, and id.

If the id or recommendation are expired return expired.

Ability to delete or update rec and id.

Create a dev branch and a pull request to master

![Sample Rec](image2.gif)

# Bonus
Image uploads is a stretch goal

Deploy the application

Create a frontend
