# `admin` Channel

## Introduction

`admin` channel implements all routes that are unique to a singular player entity.

Currently, there are 4 distinct roles a user on the server can have, ordered from least to most privileged:

- **User**      - every player joining the server automatically obtains this role
- **Streamer**  - every player that has a stream data added by {*Moderator, Admin*} obtains this role
- **Moderator** - set of Moderators with limited admin functionality
- **Admin**     - set of Adminstrators with full privileges

This channel is covering routes that are of concern for {*Moderator, Admin*} roles.<br>
For routes of other roles, please refer to [`player` channel](../player/README.md).

## Routes

Following routes are currently supported by this channel:

- [`admin.addStreamer`](#adminaddstreamer)

---

### `admin.addStreamer`

The route is called by gameserver controller whenever a privileged user wants to add a new stream information for a specific player.
The backend stores the stream data to database and responds with player metadata for consistency (without records).

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
   "streamData": {                          # request data must be same here
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
