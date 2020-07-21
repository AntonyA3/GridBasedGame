package data;

import data.OpponentSpawnerData;
import entities.OpponentSpawner;
import data.GridData;

typedef LevelData = {
    var ?grid:GridData;
    var ?opponent_spawners:Array<OpponentSpawnerData>;
    var ?player:PlayerData;
}