# Demo of ConvertEmptyStringsToNull middleware

POST - Create an example webhook

```json
{
  "authentication_mode": "bearer",
  "request_type": "put",
  "content_type": "json",
  "is_active": true,
  "password": "top secret",
  "data": null,
  "username": "",
  "name": "GitHub",
  "url": "https://api.github.com"
}
```

`"username": ""` should be converted to `"username": null`
