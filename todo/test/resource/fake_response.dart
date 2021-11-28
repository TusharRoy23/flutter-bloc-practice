import 'package:repository_module/repository_module.dart';

User userResponse = User(
  accessToken:
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InR1c2hhckBnbS5jb20iLCJ1c2VyX2luZm8iOnsiaWQiOjI1LCJwZXROYW1lIjoiRG9nIiwicGhvdG8iOiJpbWFnZSAoMSkucG5nIiwibW9kaWZpZWRfcGhvdG8iOiJhMWU3NGY0ZC1hZDdmLTRlOTItYjZjMC0wMjZjYjEwYjYzM2EucG5nIiwiYWRkcmVzcyI6IlRhbmdhaWwifSwiaWF0IjoxNjM3MzE2OTY5LCJleHAiOjE2MzczMTc4Njl9.GXuhtzLRFsEBqt0TnV_YzmZNOcFaTTBSSVSjOj4XISs",
  refreshToken:
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InR1c2hhckBnbS5jb20iLCJ1c2VyX2luZm8iOnsiaWQiOjI1LCJwZXROYW1lIjoiRG9nIiwicGhvdG8iOiJpbWFnZSAoMSkucG5nIiwibW9kaWZpZWRfcGhvdG8iOiJhMWU3NGY0ZC1hZDdmLTRlOTItYjZjMC0wMjZjYjEwYjYzM2EucG5nIiwiYWRkcmVzcyI6IlRhbmdhaWwifSwiaWF0IjoxNjM3MzE2OTY5LCJleHAiOjE2MzczNDU3Njl9.vv1_pXjdDTc2_V68wq4Hw5zEN2yklnA17LpUJIMVMVo",
  address: "Tangail",
  petName: "Dog",
  photo: "image (1).png",
  userId: 25,
  username: "tushar@gm.com",
);

User userFakeResp = User(
  address: "Tangail",
  petName: "Dog",
  photo: "image (1).png",
  userId: 25,
  username: "tushar@gm.com",
);

const userResult = {
  "accessToken":
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InR1c2hhckBnbS5jb20iLCJ1c2VyX2luZm8iOnsiaWQiOjI1LCJwZXROYW1lIjoiRG9nIiwicGhvdG8iOiJpbWFnZSAoMSkucG5nIiwibW9kaWZpZWRfcGhvdG8iOiJhMWU3NGY0ZC1hZDdmLTRlOTItYjZjMC0wMjZjYjEwYjYzM2EucG5nIiwiYWRkcmVzcyI6IlRhbmdhaWwifSwiaWF0IjoxNjM3MzE2OTY5LCJleHAiOjE2MzczMTc4Njl9.GXuhtzLRFsEBqt0TnV_YzmZNOcFaTTBSSVSjOj4XISs",
  "refreshToken":
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InR1c2hhckBnbS5jb20iLCJ1c2VyX2luZm8iOnsiaWQiOjI1LCJwZXROYW1lIjoiRG9nIiwicGhvdG8iOiJpbWFnZSAoMSkucG5nIiwibW9kaWZpZWRfcGhvdG8iOiJhMWU3NGY0ZC1hZDdmLTRlOTItYjZjMC0wMjZjYjEwYjYzM2EucG5nIiwiYWRkcmVzcyI6IlRhbmdhaWwifSwiaWF0IjoxNjM3MzE2OTY5LCJleHAiOjE2MzczNDU3Njl9.vv1_pXjdDTc2_V68wq4Hw5zEN2yklnA17LpUJIMVMVo",
  "user": {
    "username": "tushar@gm.com",
    "user_info": {
      "id": 25,
      "petName": "Dog",
      "photo": "image (1).png",
      "modified_photo": "a1e74f4d-ad7f-4e92-b6c0-026cb10b633a.png",
      "address": "Tangail"
    }
  }
};
List<Todo> fakeTodoResponse = [
  Todo(
    id: 50,
    title: "updated title 3",
    description: "updated description",
    createdDate: "2021-05-07T14:47:54.247Z",
  ),
  Todo(
    id: 59,
    title: "new elastic updated title",
    description: "new elastic description",
    createdDate: "2021-05-10T05:48:32.893Z",
  ),
  Todo(
    id: 57,
    title: "elastic one update v4",
    description: "elastic description one update v4",
    createdDate: "2021-05-10T03:10:01.160Z",
  ),
];

Todo fakeNewTodo = Todo(
  title: 'fake one',
  description: 'fake description one',
);
