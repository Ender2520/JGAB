#!mainFile "../main.opy"

#!define wuPhase getMatchTime() >= roundLength - 15
#!define nPhase getMatchTime() >= roundLength * 0.5
#!define fPhase 1 if getMatchTime() >= roundLength * 0.5 else 0.75

#!define abilityHUDName(ENABLED, BUTTON) "--Disabled--" if (ENABLED) != true else "Ready" if localPlayer.getAbilityCooldown((BUTTON)) == 0 else localPlayer.getAbilityCooldown((BUTTON))
#!define ultHUDName(ENABLED) "--Disabled--" if (ENABLED) != true else "Ready" if localPlayer.ultCharge == 100 else "{0}%".format(round(localPlayer.ultCharge))

#!define abilityUltColor(ENABLED, USING, BUTTON) rgba(127,127,127,127) if (ENABLED) != true else Color.YELLOW if (USING) == true else Color.RED if localPlayer.getAbilityCooldown((BUTTON)) > 0 else Color.WHITE
#!define ultHUDColor(ENABLED, USING) rgba(127,127,127,127) if (ENABLED) != true else Color.YELLOW if (USING) == true else Color.BLACK if roundUnderway and localPlayer.ultCharge == 0 else rgb(200 + (55*(localPlayer.ultCharge/100)), (255*(localPlayer.ultCharge/100)), 19 - (19*(localPlayer.ultCharge/100))) if localPlayer.ultCharge != 100 else Color.WHITE

#!define totalWeights (enemySpawnWeights[0] + enemySpawnWeights[1] + enemySpawnWeights[2] + enemySpawnWeights[3])

#!define chaos(PARAMETER) (PARAMETER) if chaosMode else

#!define isCharger (eventPlayer.isDummy() and eventPlayer.getCurrentHero() == Hero.REINHARDT and eventPlayer.enemyType == 1)

#!define allPlayersReady all([distance(player.getPosition() * vect(1, 0, 1), vect(-12, 0, 0)) <= 3 and distance(vect(-12, 0, 0), player) > 0 and not player.isDummy() for player in getPlayers(Team.1)])

#!define spawnDelay(HERO) random.uniform(   enemyMINSpawnDelays[enemyMINSpawnDelays.index(HERO) + 2] - ((difficulty - 1) / (9/((enemyMINSpawnDelays[enemyMINSpawnDelays.index(HERO) + 2])-(enemyMINSpawnDelays[enemyMINSpawnDelays.index(HERO) + 1])))) * fPhase   ,   enemyMAXSpawnDelays[enemyMAXSpawnDelays.index(HERO) + 2] - ((difficulty - 1) / (9/((enemyMAXSpawnDelays[enemyMAXSpawnDelays.index(HERO) + 2])-(enemyMAXSpawnDelays[enemyMAXSpawnDelays.index(HERO) + 1])))) * fPhase   )

#Global variables

globalvar point
globalvar x
globalvar z
globalvar direction2D
globalvar point2D
globalvar newBackward
globalvar camDirection
globalvar readyFX
globalvar difficulty
globalvar rng
globalvar targetOffset
globalvar toX
globalvar toY
globalvar roundUnderway
globalvar roundStatus
globalvar ability1Enabled
globalvar ability2Enabled
globalvar ultimateEnabled
globalvar chaosMode
globalvar testMode
globalvar roundLength
globalvar i
globalvar abilityNames
globalvar abilityDescriptions
globalvar abilityIcons
globalvar selectionPercent_READY

globalvar enemySpawnWeights
globalvar enemyMAXSpawnDelays
globalvar enemyMINSpawnDelays

globalvar colordisabled

#Player variables

playervar faceDirection
playervar lives
playervar livesColor
playervar damageDealt
playervar enemyType
playervar directionName
playervar dest_tp_2d
playervar botPosition
playervar botEffect
playervar ultCharge
playervar usingUltimateREAL
playervar usingAbility1REAL
playervar usingAbility2REAL
playervar a1Choice
playervar a2Choice
playervar ultChoice
playervar abilityEffects
playervar effectRadius
playervar bulletsLeft
playervar a1cooldownPATCH