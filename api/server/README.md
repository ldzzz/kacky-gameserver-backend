# `server` Channel

## Introduction

`server` channel implements all routes that are of concern on a server level.

## Routes

Here is a short overview of what commands are currently supported by this channel.
Detailed description of each route with examples can be found in their respective sections thereafter.

- [`server.mapStart`](#servermapstart)
- [`server.mapEnd`](#servermapend)
- [`server.mapRecords`](#servermaprecords)
- [`server.mapSync`](#servermapsync)
- [`server.sync`](#serversync)
- [`server.setDifficulty`](#serversetdifficulty)
- [`server.leaderboard`](#serverleaderboard)
- [`server.leaderboard`](#serverleaderboard)
- [`server.setTimeLimit`](#serversettimelimit)

---

### `server.mapStart`

The route is called by gameserver controller whenever the server is switching to the next map. The backend prepares the necessary data to load into the map and sends the data back to the gameserver controller.

<u>**Request**:</u>

```json
{
   "mapinfo":{
      "mapUid":"string",
      "mapAuthor":"string",
      "mapAuthorTime":"number",
      "startStamp":"datetime string iso8601 (UTC)"
   },
   "nextMaps":["mapUid array"]
}
```

<u>**Response**</u>

```json
{
   "mapUid":"string",
   "mapRecords":[
      {
         "login":"string",
         "nickname":"string",
         "score":number,
         "updatedAt":number,
         "totalFinishes":number
      }
   ],
   "mapKarma": [
      {
         "login":"string",
         "nickname":"string",
         "vote":number(double/float),
         "updatedAt":"datetime string iso8601 (UTC)"
      }
   ]
}

-------------------------------------------------------------------------------
Error Response
{
   "code": number,                  # HTTP error code (404, 400, 500, etc.)
   "message": "Error message"
}
```

#### <u>**Examples**</u>

<details>
  <summary>Request: Example</summary>

```json
```

</details>

<details>
  <summary>Response: Success </summary>

```json
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

### `server.mapEnd`

The route is called by gameserver controller whenever a map playtime ends. The backend processes relevant info and updates map playtime as well as server status.

<u>**Request**:</u>

```json
```

<u>**Response**</u>

```json
{
   "id": number,
   "login": "string",
   "gameType": "string",
   "zone": "string",
   "totalPlaytime": number,
   "nickname":"string",
   "role": "string",
   "isMuted": bool,
   "isBlacklisted": bool,
   "createdAt": "datetime string iso8601 (UTC)",
   "updatedAt": "datetime string iso8601 (UTC)",
   "streamData": {                          # or null if it doesn't exist
      "platform": "string",
      "streamerLogin": "string",
      "streamStatus": bool
   }
}

-------------------------------------------------------------------------------

Error Response
{
   "code": number,                  # HTTP error code (404, 400, 500, etc.)
   "message": "Error message"
}
```

 <u>**Examples**</u>

<details>
  <summary>Request: Example</summary>

```json
{
   "login":"el-djinn",
   "gameType":"TmForever",
   "nickname":"djinn",
   "zone":"World|Europe|Croatia"
}
```

</details>

<details>
  <summary>Response: Success</summary>

```json
{
   "id":20,
   "login":"el-djinn",
   "gameType":"KK",
   "zone":"World|Europe|Croatia",
   "totalPlaytime":0,
   "nickname":"djinn",
   "role":"user",
   "isMuted":false,
   "isBlacklisted":false,
   "createdAt":"2024-08-10T10:24:06Z",
   "updatedAt":"2024-08-10T12:33:42Z",
   "streamData": null
}
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

### `server.mapRecords`

The route is called by gameserver controller whenever they want to obtain map records for a specific map.
Backend expects a mapUID and in return it returns sorted records (lowest to highest score) and additionally sorts by date finished last,
so that players who finished a map first are ordered above the ones that finished it later with the same score.

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

### `server.mapSync`

### `server.sync`

### `server.setDifficulty`

### `server.leaderboard`

### `server.setTimeLimit`
