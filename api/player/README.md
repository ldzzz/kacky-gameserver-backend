# `player` Channel

## Introduction

`player` channel implements all routes that are unique to a singular player entity.

Currently, there are 4 distinct roles a user on the server can have, ordered from least to most privileged:

- **User**      - every player joining the server automatically obtains this role
- **Moderator** - set of Moderators with limited admin functionality
- **Admin**     - set of Admins with full privileges

This channel is covering routes that are of concern for {*User, Streamer*} roles.<br>
For routes of other roles, please refer to [`admin` channel](../admin/README.md).

## Routes

Following routes are currently supported by this channel:

- [`player.connect`](#playerconnect)
- [`player.setName`](#playersetname)
- [`player.finish`](#playerfinish)
- [`player.setStreamStatus`](#playersetstreamstatus)

---

### `player.connect`

The route is called by gameserver controller whenever a player connects to one of the gameservers and their metadata is unknown to the controller. The backend responds with all necessary metadata of the player for their initialization on the server.

<u>**Request**:</u>

```json
{
   "login": "string",
   "gameType":"string",
   "nickname": "string",
   "zone": "string"
}
```

<u>**Response**</u>

```json
{
   "id": number,
   "login": "string",
   "gameType": "string",
   "zone": "string",
   "totalPlaytime": number,
   "nickname": "string",
   "role": "string",
   "isMuted": bool,
   "isBlacklisted": bool,
   "createdAt": "datetime string iso8601 (UTC)",
   "updatedAt": "datetime string iso8601 (UTC)",
   "streamData": {                          # or null if not a streamer (this can be inferred by role)
      "platform": "string",
      "streamerLogin": "string",
      "streamStatus": bool
   },
   "records": []    # or null if player has no finishes
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
  <summary>Request: TMNF player</summary>

```json
{
   "login":"el-djinn",
   "gameType":"TmForever",
   "nickname":"el-djinn",
   "zone":"World|Europe|Croatia"
}
```

</details>

<details>
  <summary>Request: TM20 player</summary>

```json
{
   "login":"3zrJPQyLTZKF2Mrkr-qUEw",
   "gameType":"Trackmania",
   "nickname":"el-djinn",
   "zone":"World|Europe|Croatia"
}
```

</details>

<details>
  <summary>Response: New player </summary>

```json
{
   "id": 20,
   "login": "p7",
   "gameType": "KK",
   "zone": "World|Europe|Croatia",
   "totalPlaytime":0,
   "nickname": "el-djinn",
   "role": "user",
   "isMuted": false,
   "isBlacklisted": false,
   "createdAt": "2024-08-10T10:24:06Z",
   "updatedAt": "2024-08-10T12:33:42Z",
   "streamData": null,
   "records": null
}
```

</details>

<details>
  <summary>Response: With stream data</summary>

```json
{
   "id":20,
   "login":"p7",
   "gameType":"KK",
   "zone":"World|Europe|Croatia",
   "totalPlaytime":0,
   "nickname":"el-djinn",
   "role":"streamer",
   "isMuted":false,
   "isBlacklisted":false,
   "createdAt":"2024-08-10T10:24:06Z",
   "updatedAt":"2024-08-10T12:33:42Z",
   "streamData":{
      "platform":"twitch.tv",
      "streamerLogin":"tekky",
      "streamStatus":false
   },
   "records":null
}
```

</details>

<details>
  <summary>Response: With records</summary>

```json
{
   "id":20,
   "login":"p7",
   "gameType":"KK",
   "zone":"World|Europe|Croatia",
   "totalPlaytime":0,
   "nickname":"el-djinn",
   "role":"streamer",
   "isMuted":false,
   "isBlacklisted":false,
   "createdAt":"2024-08-10T10:24:06Z",
   "updatedAt":"2024-08-10T12:33:42Z",
   "streamData":{
      "platform":"twitch.tv",
      "streamerLogin":"tekky",
      "streamStatus":false
   },
   "records":[
      {
         "mapUid":"I7rI7jAga6C4tGAe5OTDoyLF2fh",
         "number":5,
         "score":12345,
         "finishCounter":1,
         "createdAt":"2024-08-10T20:29:51Z",
         "lastImprovedAt":"2024-08-10T20:29:51Z"
      },
      {
         "mapUid":"6ktPCqLADXXuy5LaOLTzktaGlKf",
         "number":14,
         "score":12343,
         "finishCounter":6,
         "createdAt":"2024-08-10T21:03:31Z",
         "lastImprovedAt":"2024-08-10T21:03:43Z"
      }
   ]
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

### `player.setName`

The route is called by gameserver controller whenever a player wants to update their nickname. The backend stores new nickname to database and responds with player metadata for consistency (without records).

<u>**Request**:</u>

```json
{
   "login": "string",
   "gameType":"string",
   "nickname": "string",
   "zone": "string"
}
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

#### <u>**Examples**</u>

<details>
  <summary>Request: TMNF player</summary>

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
  <summary>Request: TM20 player</summary>

```json
{
   "login":"3zrJPQyLTZKF2Mrkr-qUEw",
   "gameType":"Trackmania",
   "nickname":"djinn",
   "zone":"World|Europe|Croatia"
}
```

</details>

<details>
  <summary>Response: Nickname set</summary>

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

### `player.finish`

The route is called by gameserver controller whenever a player finishes a map. The backend will process and update relevant finish data and increment the finish counter of the player, as well as determine finish type, rank, and score and rank differences.
At the moment the backend will categorize the finish into 3 different finish types:

- `NewFinish` - The player finished the map for the first time, (`finishRankDifference`, `finishScoreDifference`) shall be ignored
- `PersonalBest` - The player improved their map time, (`finishRankDifference`, `finishScoreDifference`) contain
- `Finish` - The player finished again without improving their score, (`finishRankDifference`, `finishScoreDifference`) shall be ignored

The gameserver controller can find all relevant finish metadata like type, rank, and (rank, score) differences in `finishInfo` field.

<u>**Request**:</u>

```json
{
   "login":"string",
   "gameType":"string",
   "mapUid":"string",
   "timestamp":"datetime string iso8601 (UTC)",
   "score":number
}
```

<u>**Response**</u>

```json
{
   "id":number,
   "login":"string",
   "gameType":"string",
   "zone":"string",
   "totalPlaytime":number,
   "nickname":"string",
   "role":"string",
   "isMuted":number,
   "isBlacklisted":number,
   "createdAt":"datetime string iso8601 (UTC)",
   "updatedAt":"datetime string iso8601 (UTC)",
   "streamData":null,
   "finishInfo": :{
      "finishType":"string",
      "finishRank":number,
      "finishRankDifference":number,
      "finishScoreDifference":number
   },
   "records":[
      {
         "mapUId":"string",
         "number":number,
         "score":number,
         "finishCounter":number,
         "createdAt":"datetime string iso8601 (UTC)",
         "lastImprovedAt":"datetime string iso8601 (UTC)"
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

#### <u>**Example responses**</u>

<details>
  <summary>Request: TMNF player</summary>

```json
{
   "login":"el-djinn",
   "gameType":"TmForever",
   "mapUid":"string",
   "timestamp":"2024-08-10T21:10:12.390824Z",
   "score":12345
}
```

</details>

<details>
  <summary>Request: TM20 player</summary>

```json
{
   "login":"I7rI7jAga6C4tGAe5OTDoyLF2fh",
   "gameType":"Trackmania",
   "mapUid":"6y_26o7fxz0Es3t0e0EPBE7vF_k",
   "timestamp":"2024-08-10T21:10:12.390824Z",
   "score":12345
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
   "nickname":"el-djinn",
   "role":"streamer",
   "isMuted":0,
   "isBlacklisted":0,
   "createdAt":"2024-08-10T20:27:55Z",
   "updatedAt":"2024-08-10T20:29:17Z",
   "streamData":{
      "platform":"twitch.tv",
      "streamerLogin":"bla1",
      "streamStatus":true
   },
   "finishInfo":{
      "finishType":"Finish",
      "finishRank":3,
      "finishRankDifference":-1,
      "finishScoreDifference":-1
   },
   "records":[
      {
         "mapUid":"I7rI7jAga6C4tGAe5OTDoyLF2fh",
         "number":5,
         "score":12345,
         "finishCounter":1,
         "createdAt":"2024-08-10T20:29:51Z",
         "lastImprovedAt":"2024-08-10T20:29:51Z"
      },
      {
         "mapUid":"6ktPCqLADXXuy5LaOLTzktaGlKf",
         "number":14,
         "score":12343,
         "finishCounter":6,
         "createdAt":"2024-08-10T21:03:31Z",
         "lastImprovedAt":"2024-08-10T21:03:43Z"
      }
   ]
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

### `player.setStreamStatus`

The route is called by gameserver controller whenever a player wants to modify their stream status.
Whether they are going live (true) or going offline (false), the backend stores the data as long as the user has a role of streamer and has stream data set. The gameserver shall ensure that only players with Streamer role can call this functionality.

<u>**Request**:</u>

```json
{
   "login":"string",
   "gameType":"string",
   "platform":"string",
   "streamerLogin":"string",
   "streamStatus":bool
}
```

<u>**Response**</u>

```json
{
   "id": number,
   "login": "string",
   "gameType": "string",
   "zone": "string",
   "totalPlaytime": number,
   "nickname": "string",
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

#### <u>**Example responses**</u>

<details>
  <summary>Request: TMNF player</summary>

```json
{
   "login":"el-djinn",
   "gameType":"TmForever",
   "platform":"twitch.tv",
   "streamerLogin":"tekky",
   "streamStatus":true,
}
```

</details>

<details>
  <summary>Request: TM20 player</summary>

```json
{
   "login":"3zrJPQyLTZKF2Mrkr-qUEw",
   "gameType":"Trackmania",
   "platform":"twitch.tv",
   "streamerLogin":"tekky",
   "streamStatus":true,
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
   "nickname":"el-djinn",
   "role":"streamer",
   "isMuted":false,
   "isBlacklisted":false,
   "createdAt":"2024-08-10T10:24:06Z",
   "updatedAt":"2024-08-10T13:15:51Z",
   "streamData":{
      "platform":"twitch.tv",
      "streamerLogin":"tekky",
      "streamStatus":true
   }
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
