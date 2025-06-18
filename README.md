# DaLUI - Datastore Local User Interface
![Docker Image Version](https://img.shields.io/docker/v/vexdev/dalui)

DaLUI is a simple and lightweight user interface for google cloud datastore in firestore mode (But it should work for the legacy datastore emulator as well).
This tool has been thought to be used in local development environments, where you can run the datastore emulator and visualize your entities in a simple way.

![Example](https://raw.githubusercontent.com/vexdev/dalui/main/example.png)

# Known Limitations
- Currently only supports visualization, no editing (WiP).
- Currently does not support pagination, all entities are loaded at once, may not be suitable for large datasets (WiP).
- Firestore in datastore mode [does not currently support __kind__ queries](https://github.com/firebase/firebase-tools/issues/6903), therefore we need to query all entities and filter them in the client, this can be slow for large datasets.

# Features
Allows you to visualize entities and their properties in a simple and intuitive way.
Also allows visualization of nested entities and properties.
Allows querying entities by full GQL queries, please note that datastore mode does not support all GQL features, so some queries may not work as expected (I.E. queries with __kind__, but I also couldn't get projections to work, nor COUNT(*)).

# Running
DaLUI runs as a docker container exposing the HTTP port 8699, you can run it with the following command:

```bash
docker run -p 8699:8699 -e PORT=8080 -e PROJECT_ID=your-project-id vexdev/dalui
```

It can then be accessed at `http://localhost:8699`.

## Configuring
The following environment variables can be configured:

- `HOST`: The host of the datastore emulator, defaults to `localhost`.
- `PORT`: The port of the datastore emulator, defaults to `8080`.
- `PROJECT_ID`: The project id of the datastore emulator, no default, must be set.