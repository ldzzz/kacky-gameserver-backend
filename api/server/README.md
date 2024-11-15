# `server` Channel

## Introduction

`server` channel implements all routes that are of concern on a server level.

## Routes

Following routes are currently supported by this channel:

- [`server.sync`](#serversync)
- [`server.mapRecords`](#servermaprecords)
- [`server.mapEnd`](#servermapend)
- [`server.setTimeLimit`](#serversettimelimit)
- [`server.mapSync`](#servermapsync)
- [`server.setDifficulty`](#serversetdifficulty)
- [`server.leaderboard`](#serverleaderboard)

---

### `server.sync`

The route is called by gameserver controller on succesful initialisation and on any desired interval.
This registers the server in the server list and returns a list of all active servers for the specific `gameType`.
The game controller can calculate remaining time using information from the `startStamp` and `timeLimit`.

<u>**Request**:</u>

```json
{
   "serverLogin":"string",
   "serverName":"string",
   "gameType":"string",
   "timeLimit":number, # minutes
   "currentMapInfo":{
      "mapUid":"string",
      "mapName":"string",
      "mapNumber":number,
      "mapAuthor":"string", #author name
      "mapAuthorTime":number, #milis
      "startStamp":"datetime string iso8601 (UTC)"
   },
   "nextMaps":[
      "string",
      "string",
      "string",
      "string",
      "string"
   ]
}
```

<u>**Response**</u>

```json
[
   {
      "login":"string",
      "name":"string",
      "difficulty":number,
      "timeLimit":number,
      "currentMapInfo":{
         "mapUid":"string",
         "mapName":"string",
         "mapNumber":number,
         "mapAuthor":"string",
         "mapAuthorTime":number,
         "startStamp":"datetime string iso8601 (UTC)"
      },
      "nextMaps":[
          {
                "mapUid": "string",
                "mapName": "string",
                "mapNumber": number,
                "mapAuthor": "string",
                "mapAuthorTime": number
            },
            ...
      ]
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
   "serverLogin":"server2",
   "serverName":"Red 2",
   "gameType":"TmForever",
   "timeLimit":15,
   "currentMapInfo":{
      "mapUid":"6ktPCqLADXXuy5LaOLTzktaGlKf",
      "mapName":"Kackiest Kacky #123",
      "mapNumber":123,
      "mapAuthor":"djinn",
      "mapAuthorTime":12345,
      "startStamp":"2024-08-27T16:03:40.692654Z"
   },
   "nextMaps":[
      "BeySZdnfuSh4nHY5xztiXLmlrXe",
      "jH8X3qPtpn6pj3dLAaq08pyDdp1",
      "N0CpLabOm8Kk6Lsf0kwelgHiMQm",
      "SEHmwPJVBl3NpHS56w6Sirac2Ic",
      "K27AW3HYV47qqqXentunIoUERu8"
   ]
}
```

</details>

<details>
  <summary>Response: Success</summary>

```json
[
   {
      "login":"server1",
      "name":"White 1",
      "difficulty":0,
      "timeLimit":55,
      "currentMapInfo":{
         "mapUid":"6ktPCqLADXXuy5LaOLTzktaGlKf",
         "mapAuthor":"djinn",
         "mapAuthorTime":12345,
         "startStamp":"2024-08-27T16:03:22.064576Z"
      },
      "nextMaps":[
         {
                "mapUid": "BeySZdnfuSh4nHY5xztiXLmlrXe",
                "mapName": "A01-Race",
                "mapNumber": 1,
                "mapAuthor": "Nadeo",
                "mapAuthorTime": 54321
            },
            {
                "mapUid": "jH8X3qPtpn6pj3dLAaq08pyDdp1",
                "mapName": "A10-Acrobatic",
                "mapNumber": 10,
                "mapAuthor": "Nadeo",
                "mapAuthorTime": 54321
            },
            {
                "mapUid": "N0CpLabOm8Kk6Lsf0kwelgHiMQm",
                "mapName": "A11-Race",
                "mapNumber": 11,
                "mapAuthor": "Nadeo",
                "mapAuthorTime": 54321
            },
            {
                "mapUid": "SEHmwPJVBl3NpHS56w6Sirac2Ic",
                "mapName": "A04-Acrobatic",
                "mapNumber": 4,
                "mapAuthor": "Nadeo",
                "mapAuthorTime": 54321
            },
            {
                "mapUid": "K27AW3HYV47qqqXentunIoUERu8",
                "mapName": "A13-Race",
                "mapNumber": 13,
                "mapAuthor": "Nadeo",
                "mapAuthorTime": 54321
            }
      ]
   },
   {
      "login":"server2",
      "name":"Red 2",
      "difficulty":0,
      "timeLimit":15,
      "currentMapInfo":{
         "mapUid":"6ktPCqLADXXuy5LaOLTzktaGlKf",
         "mapAuthor":"djinn",
         "mapAuthorTime":12345,
         "startStamp":"2024-08-27T16:03:40.692654Z"
      },
      "nextMaps":[
         {
                "mapUid": "BeySZdnfuSh4nHY5xztiXLmlrXe",
                "mapName": "A01-Race",
                "mapNumber": 1,
                "mapAuthor": "Nadeo",
                "mapAuthorTime": 54321
            },
            {
                "mapUid": "jH8X3qPtpn6pj3dLAaq08pyDdp1",
                "mapName": "A10-Acrobatic",
                "mapNumber": 10,
                "mapAuthor": "Nadeo",
                "mapAuthorTime": 54321
            },
            {
                "mapUid": "N0CpLabOm8Kk6Lsf0kwelgHiMQm",
                "mapName": "A11-Race",
                "mapNumber": 11,
                "mapAuthor": "Nadeo",
                "mapAuthorTime": 54321
            },
            {
                "mapUid": "SEHmwPJVBl3NpHS56w6Sirac2Ic",
                "mapName": "A04-Acrobatic",
                "mapNumber": 4,
                "mapAuthor": "Nadeo",
                "mapAuthorTime": 54321
            },
            {
                "mapUid": "K27AW3HYV47qqqXentunIoUERu8",
                "mapName": "A13-Race",
                "mapNumber": 13,
                "mapAuthor": "Nadeo",
                "mapAuthorTime": 54321
            }
      ]
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

### `server.mapEnd`

The route is called by gameserver controller whenever a maps' playtime is done and server is moving to the next map in the tracklist.
The backend calculates current playtime and updates the database. It then returns the information of the updated map.

<u>**Request**:</u>

```json
{
   "serverLogin":"string",
   "serverName":"string",
   "gameType":"string",
   "currentMapInfo":{
      "mapUid":"string",
      "mapName":"string",
      "mapNumber":number,
      "mapAuthor":"string", #author name
      "mapAuthorTime":number, #milis
      "endStamp":"datetime string iso8601 (UTC)"
   }
}
```

<u>**Response**</u>

```json
{
   "id":number,
   "mapUid":"string",
   "eventId":number,
   "fullName":"string",
   "number":number,
   "author":"string",
   "authorTime":number,
   "totalPlaytime":number,
   "createdAt":"datetime string iso8601 (UTC)",
   "updatedAt":"datetime string iso8601 (UTC)"
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
  <summary>Request: Example</summary>

```json
{
   "serverLogin":"server1",
   "serverName":"White 1",
   "gameType":"KK",
   "currentMapInfo":{
      "mapUid":"6ktPCqLADXXuy5LaOLTzktaGlKf",
      "mapName":"Kackiest Kacky #123",
      "mapNumber":123,
      "mapAuthor":"djinn",
      "mapAuthorTime":12345,
      "endStamp":"2024-09-04T20:00:11.796735Z"
   }
}
```

</details>

<details>
  <summary>Response: Success</summary>

```json
{
   "id":14,
   "mapUid":"6ktPCqLADXXuy5LaOLTzktaGlKf",
   "eventId":1,
   "fullName":"A14-Race",
   "number":14,
   "author":"Nadeo",
   "authorTime":22170,
   "totalPlaytime":20,
   "createdAt":"2024-09-04T19:50:02Z",
   "updatedAt":"2024-09-04T19:50:11Z"
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

### `server.setTimeLimit`

The route is called by gameserver controller whenever it wants to change the time limit for any of the available servers.<br>
Backend validates time limit is `> 0` and returns updated server data on success.

<u>**Request**:</u>

```json
{
   "serverLogin": "string",
   "gameType":"string",
   "timeLimit": number
}
```

<u>**Response**</u>

```json
{
      "login":"string",
      "name":"string",
      "difficulty":number,
      "timeLimit":number,
      "currentMapInfo":{
         "mapUid":"string",
         "mapName":"string",
         "mapNumber":number,
         "mapAuthor":"string",
         "mapAuthorTime":number,
         "startStamp":"datetime string iso8601 (UTC)"
      },
      "nextMaps":[
          {
                "mapUid": "string",
                "mapName": "string",
                "mapNumber": number,
                "mapAuthor": "string",
                "mapAuthorTime": number
            },
            ...
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
  <summary>Request: Example</summary>

```json
{
   "serverLogin":"server1",
   "gameType":"KK",
   "timeLimit":15
}
```

</details>

<details>
  <summary>Response: Success</summary>

```json
{
  "login": "server1",
  "name": "White 1",
  "difficulty": 0,
  "timeLimit": 15,
  "currentMapInfo": {
    "mapUid": "6ktPCqLADXXuy5LaOLTzktaGlKf",
    "mapName": "Kackiest Kacky #123",
    "mapNumber": 123,
    "mapAuthor": "djinn",
    "mapAuthorTime": 12345,
    "startStamp": "2024-09-09T14:33:14.449696Z"
  },
  "nextMaps": [
    {
      "mapUid": "BeySZdnfuSh4nHY5xztiXLmlrXe",
      "mapName": "A01-Race",
      "mapNumber": 1,
      "mapAuthor": "Nadeo",
      "mapAuthorTime": 24540
    },
    {
      "mapUid": "jH8X3qPtpn6pj3dLAaq08pyDdp1",
      "mapName": "A10-Acrobatic",
      "mapNumber": 10,
      "mapAuthor": "Nadeo",
      "mapAuthorTime": 9650
    },
    {
      "mapUid": "N0CpLabOm8Kk6Lsf0kwelgHiMQm",
      "mapName": "A11-Race",
      "mapNumber": 11,
      "mapAuthor": "Nadeo",
      "mapAuthorTime": 19320
    },
    {
      "mapUid": "SEHmwPJVBl3NpHS56w6Sirac2Ic",
      "mapName": "A04-Acrobatic",
      "mapNumber": 4,
      "mapAuthor": "Nadeo",
      "mapAuthorTime": 5950
    },
    {
      "mapUid": "K27AW3HYV47qqqXentunIoUERu8",
      "mapName": "A13-Race",
      "mapNumber": 13,
      "mapAuthor": "Nadeo",
      "mapAuthorTime": 31700
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

### `server.setDifficulty`

TBD

---

### `server.leaderboard`

TBD
