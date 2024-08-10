# `player` Channel

## Introduction

`player` channel implements all routes that are unique to a singular player entity.

Currently, there are 4 distinct roles a user on the server can have, ordered from least to most privileged:

- **User**      - every player joining the server automatically obtains this role
- **Streamer**  - every player that has a stream data added by {*Moderator, Admin*} obtains this role
- **Moderator** - set of Moderators with limited admin functionality
- **Admin**     - set of Admins with full privileges

This channel is covering generic routes that are of concern for {*User, Streamer*} roles.
For routes of other roles, please refer to (TBD - admin channel).

## Routes

Here is a short overview of what commands are currently supported by this channel.
Detailed description of each route with examples can be found in their respective sections thereafter.

- [`player.connect`](#player.connect)
- [`player.setName`](#player.setName)
- [`player.finish`](#player.finish)
- [`player.addStreamer`](#player.addStreamer)
- [`player.setStreamStatus`](#player.setStreamStatus)

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
   "createdAt": "ISO8601 datetime string",
   "updatedAt": "ISO8601 datetime string",
   "streamData": {                          # or null if it doesn't exist
      "platform": "string",
      "streamerLogin": "string",
      "streamStatus": bool
   },
   "records": []    # or null if it doesn't exist
}

-------------------------------------------------------------------------------
Error Response
{
   "code": number,                  # HTTP error code (404, 400, 500, etc.)
   "message": "Error message"
}
```

### <u>**Examples**</u>

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
   "records":[]
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
   "createdAt": "ISO8601 datetime string",
   "updatedAt": "ISO8601 datetime string",
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

### <u>**Examples**</u>

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

The route is called by gameserver controller whenever a player finishes a map. The backend will process and update relevant finish data and increment the finish counter of the player.
The gameserver controller shall report status accordingly upon response reception (new finish, pb, non-pb).

<u>**Request**:</u>

```json
{
   "login":"string",
   "gameType":"string",
   "mapUid":"string",
   "timestamp":"string iso8601 (UTC)",
   "score":number
}
```

<u>**Response**</u>

```json

-------------------------------------------------------------------------------

Error Response
{
   "code": number,                  # HTTP error code (404, 400, 500, etc.)
   "message": "Error message"
}
```

### <u>**Example responses**</u>

<details>
  <summary>xxx</summary>

```json
```

</details>

---

### `player.addStreamer`

The route is called by gameserver controller whenever a player wants to update their nickname. The backend stores new nickname to database and responds with player metadata for consistency (without records).

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
   "createdAt": "ISO8601 datetime string",
   "updatedAt": "ISO8601 datetime string",
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

### <u>**Example responses**</u>

<details>
  <summary>Request: TMNF player</summary>

```json
{
   "login":"el-djinn",
   "gameType":"TmForever",
   "platform":"twitch.tv",
   "streamerLogin":"tekky",
   "streamStatus":false,
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
   "streamStatus":false,
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
      "streamStatus":false
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
   "createdAt": "ISO8601 datetime string",
   "updatedAt": "ISO8601 datetime string",
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

### <u>**Example responses**</u>

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
