# DaLUI - Datastore Local User Interface
![Docker Image Version](https://img.shields.io/docker/v/vexdev/dalui)

DaLUI is a simple and lightweight user interface for google cloud datastore in firestore mode (But it should work for the legacy datastore emulator as well).
This tool has been thought to be used in local development environments, where you can run the datastore emulator and visualize your entities in a simple way.

![Example](https://raw.githubusercontent.com/vexdev/dalui/main/example.png)

# Known Limitations
- Currently does not support editing (WiP).
- Currently does not support pagination, all entities are loaded at once, may not be suitable for large datasets (WiP).
- Firestore in datastore mode [does not currently support __kind__ queries](https://github.com/firebase/firebase-tools/issues/6903), therefore we need to query all entities and filter them in the client, this can be slow for large datasets.
- Projections and COUNT(*) queries are not supported in datastore mode, so they will not work as expected.

# Features
- Visualize entities and their properties.
- Visualize nested entities and properties.
- Delete entities.
- Query entities using full GQL queries (with limitations).
- Supports both Firestore in datastore mode and legacy datastore emulator.

# Running
DaLUI runs as a docker container exposing the HTTP port 80, you can run it with the following command:

```bash
docker run -p 8699:80 -e DALUI_HOST=localhost:8080 -e DALUI_DS_PROJECT=your-project-id vexdev/dalui
```

It can then be accessed at `http://localhost:8699`.

## Configuring
The following environment variables must be configured:

- `DALUI_HOST`: The host and port of the datastore emulator.
- `DALUI_DS_PROJECT`: The project id of the datastore emulator.