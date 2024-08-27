# `server` Channel

## Introduction

`server` channel implements all routes that are of concern on a server level.

## Routes

Following routes are currently supported by this channel:

- [`server.mapStart`](#servermapstart)
- [`server.mapEnd`](#servermapend)
- [`server.mapRecords`](#servermaprecords)
- [`server.mapSync`](#servermapsync)
- [`server.sync`](#serversync)
- [`server.setDifficulty`](#serversetdifficulty)
- [`server.leaderboard`](#serverleaderboard)

---

### `server.mapRecords`

The route is called by gameserver controller whenever it wants to obtain map records for a specific map.
Backend expects a `mapUID` and in return it returns sorted records (lowest to highest score) and additionally sorts by date finished last, so that players who finished a map first are ordered above the ones that finished it later with the same score.

<u>**Request**:</u>

```json
{
   "mapUid": "string"
}
```

<u>**Response**</u>

```json
[
   {
      "login":"string",
      "nickname":"string",
      "score":number,
      "finishCounter":number,
      "lastImprovedAt":"datetime string iso8601 (UTC)"
   },
   ...
]


-------------------------------------------------------------------------------

Error Response
{
   "code": number,                  # HTTP error code (404, 400, 500, etc.)
   "message": "Error message"
}

```

#### <u>**Example responses**</u>

<details>
  <summary>Request: Example</summary>

```json
{
   "mapUid": "6ktPCqLADXXuy5LaOLTzktaGlKf"
}
```

</details>

<details>
  <summary>Response: Success</summary>

```json
[
   {
      "login":"p7",
      "nickname":"el-djinn",
      "score":12343,
      "finishCounter":6,
      "lastImprovedAt":"2024-08-10T21:03:43Z"
   },
   {
      "login":"p8",
      "nickname":"el-djinn",
      "score":12345,
      "finishCounter":1,
      "lastImprovedAt":"2024-08-11T13:47:14Z"
   },
   {
      "login":"*fakeplayer1*",
      "nickname":"player1",
      "score":52255,
      "finishCounter":17,
      "lastImprovedAt":"2024-08-10T19:48:22Z"
   },
   {
      "login":"*fakeplayer2*",
      "nickname":"player2",
      "score":94283,
      "finishCounter":14,
      "lastImprovedAt":"2024-08-10T19:48:22Z"
   }
]
```

</details>

<details>
  <summary>Response: Error</summary>

```json
{
   "code": 500,
   "message": "Internal Server Error
}
```

</details>

---

### `server.mapStart`

TBD

---

### `server.mapEnd`

TBD

---

### `server.mapSync`

TBD

---

### `server.sync`

TBD

---

### `server.setDifficulty`

TBD

---

### `server.leaderboard`

TBD
