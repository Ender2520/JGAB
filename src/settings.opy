settings {
    "main": {
        "description": "Team up with up to 3 of your friends in an attempt to beat this bullet hell gamemode | The higher difficulty the more enemies you will encounter, and the more chaotic the game will become. | Created by u/Ender / v1.0.3",
        "modeName": "Just Genjis and Beats | J.G.A.B."
    },
    "lobby": {
        "spectatorSlots": 12,
        "team1Slots": 4,
        "team2Slots": 0
    },
    "gamemodes": {
        "skirmish": {
            "enabledMaps": [
                "workshopChamber"
            ]
        },
        "general": {
            "gameLengthInMn": 15,
            "heroLimit": "off",
            "enableKillCam": false,
            "enableKillFeed": false,
            "scoreToWin": 1
        }
    },
    "heroes": {
        "allTeams": {
            "genji": {
                "enablePrimaryFire": false,
                "enableMelee": false,
                "enableSecondaryFire": false,
                "ability1Cooldown%": 62.5,
                "ability2Cooldown%": 62.5
            },
            "mei": {
                "primaryFireFreezeDuration%": 50,
                "primaryFireFreezeMinimum%": 80,
                "primaryFireFreezeRate%": 100
            },
            "reinhardt": {
                "enableSpawningWithUlt": true
            },
            "enabledHeroes": [
                "genji"
            ],
            "general": {
                "ultGen%": 10,
                "combatUltGen%": 0,
                "passiveUltGen%": 0
            }
        }
    }
}
