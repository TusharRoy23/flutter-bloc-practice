import 'package:meta_api/src/model/token.dart';
import 'package:meta_api/src/model/user.dart';
import 'package:meta_api/src/model/user_info.dart';

const loginData = """{
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
}""";

const loginResult = {
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

User userResult = User(
  token: Token(
    accessToken:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InR1c2hhckBnbS5jb20iLCJ1c2VyX2luZm8iOnsiaWQiOjI1LCJwZXROYW1lIjoiRG9nIiwicGhvdG8iOiJpbWFnZSAoMSkucG5nIiwibW9kaWZpZWRfcGhvdG8iOiJhMWU3NGY0ZC1hZDdmLTRlOTItYjZjMC0wMjZjYjEwYjYzM2EucG5nIiwiYWRkcmVzcyI6IlRhbmdhaWwifSwiaWF0IjoxNjM3MzE2OTY5LCJleHAiOjE2MzczMTc4Njl9.GXuhtzLRFsEBqt0TnV_YzmZNOcFaTTBSSVSjOj4XISs',
    refreshToken:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InR1c2hhckBnbS5jb20iLCJ1c2VyX2luZm8iOnsiaWQiOjI1LCJwZXROYW1lIjoiRG9nIiwicGhvdG8iOiJpbWFnZSAoMSkucG5nIiwibW9kaWZpZWRfcGhvdG8iOiJhMWU3NGY0ZC1hZDdmLTRlOTItYjZjMC0wMjZjYjEwYjYzM2EucG5nIiwiYWRkcmVzcyI6IlRhbmdhaWwifSwiaWF0IjoxNjM3MzE2OTY5LCJleHAiOjE2MzczNDU3Njl9.vv1_pXjdDTc2_V68wq4Hw5zEN2yklnA17LpUJIMVMVo',
  ),
  userInfo: UserInfo(
    address: 'Tangail',
    petName: 'Dog',
    photo: 'image (1).png',
    userId: 25,
  ),
  username: 'tushar@gm.com',
);
