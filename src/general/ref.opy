#!mainFile "../main.opy"

#!define wuPhase getMatchTime() >= (60 + (difficulty*6)) - 15
#!define nPhase getMatchTime() >= (60 + (difficulty*6)) * 0.5

#!define abilityHUDName(ENABLED, BUTTON) "--Disabled--" if (ENABLED) != true else "Ready" if localPlayer.getAbilityCooldown((BUTTON)) == 0 else localPlayer.getAbilityCooldown((BUTTON))
#!define ultHUDName(ENABLED) "--Disabled--" if (ENABLED) != true else "Ready" if localPlayer.ultCharge == 100 else "{0}%".format(round(localPlayer.ultCharge))

#!define abilityUltColor(ENABLED, USING, BUTTON) rgba(127,127,127,127) if (ENABLED) != true else Color.YELLOW if (USING) == true else Color.RED if localPlayer.getAbilityCooldown((BUTTON)) > 0 else Color.WHITE
#!define ultHUDColor(ENABLED) rgba(127,127,127,127) if (ENABLED) != true else Color.YELLOW if localPlayer.usingUltimateREAL == true else Color.BLACK if roundUnderway and localPlayer.ultCharge == 0 else rgb(200 + (55*(localPlayer.ultCharge/100)), (255*(localPlayer.ultCharge/100)), 19 - (19*(localPlayer.ultCharge/100))) if localPlayer.getUltCharge() != 100 else Color.WHITE

#!define totalWeight (pWeight+oWeight+mWeight+rWeight)

#!define chaos(PARAMETER) (PARAMETER) if chaosMode else

#!define isCharger (eventPlayer.isDummy() and eventPlayer.getCurrentHero() == Hero.REINHARDT and eventPlayer.enemyType == 1)

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
globalvar dashEnabled
globalvar deflectEnabled
globalvar ultimateEnabled
globalvar chaosMode
globalvar i

globalvar pWeight
globalvar oWeight
globalvar mWeight
globalvar rWeight

#Player variables

playervar faceDirection
playervar lives
playervar damageDealt
playervar enemyType
playervar directionName
playervar dest_tp_2d
playervar botPosition
playervar botEffect
playervar ultCharge
playervar usingUltimateREAL