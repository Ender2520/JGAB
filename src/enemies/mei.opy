#!mainFile "../main.opy"

def Enemy_Freeze():
    eventPlayer.botPosition = vect(chaos(max(-18,min(18,random.choice([p for p in getAllPlayers() if p.isDummy() != true and p.isAlive()]).getPosition().x + random.randint(-0.4 , 0.4)))) max(-18,min(18,random.choice([p for p in getAllPlayers() if p.isDummy() != true and p.isAlive()]).getPosition().x + random.randint(-0.8 * (10/difficulty), 0.8 * (10/difficulty)))), -1.8, 0)
    eventPlayer.startForcingPosition(eventPlayer.botPosition, true)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.AQUA, eventPlayer.botPosition + vect(-0.15,1.6,false), 0.8, EffectReeval.VISIBILITY)
    eventPlayer.botEffect[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, eventPlayer.botPosition + vect(-0.15,1.6,false), 0.6, EffectReeval.VISIBILITY)
    eventPlayer.botEffect[1] = getLastCreatedEntity()
    eventPlayer.startFacing(directionTowards(eventPlayer, eventPlayer + Vector.UP * 10), 9999, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    # custom delay
    wait(chaos(0.128) (1/difficulty) + random.uniform(0.256,0.512))
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.AQUA, eventPlayer.botPosition - vect(0.15,20,false), 0.6, EffectReeval.VISIBILITY)
    eventPlayer.botEffect[2] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.WHITE, eventPlayer.botPosition - vect(0.15,20,false), 0.4, EffectReeval.VISIBILITY)
    eventPlayer.botEffect[3] = getLastCreatedEntity()
    waitUntil(eventPlayer.getAmmo(0) == 0, 9999)
    destroyEffect(eventPlayer.botEffect[2])
    destroyEffect(eventPlayer.botEffect[3])
    wait(0.5)
    kill(eventPlayer, null)
    destroyEffect(eventPlayer.botEffect[0])
    destroyEffect(eventPlayer.botEffect[1])