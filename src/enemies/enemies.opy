#!mainFile "../main.opy"

rule "[Enemies] Initialize":
    @Event eachPlayer
    @Condition eventPlayer.isDummy() == true
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.getCurrentHero() != Hero.GENJI
    
    eventPlayer.disableEnvironmentCollision(true)
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.setHealingDealt(0)
    eventPlayer.setKnockbackDealt(0)
    wait(0.2)
    if eventPlayer.getCurrentHero() == Hero.PHARAH:
        if getMatchTime() >= roundLength - 15:
            eventPlayer.enemyType = random.randint(0, 2)
        else:
            eventPlayer.enemyType = random.randint(0, 3)
        eventPlayer.setMaxAmmo(0, 10 if chaosMode else 3 + 0.6 * difficulty)
        eventPlayer.setAmmo(0, 10 if chaosMode else 3 + 0.6 * difficulty)
        if eventPlayer.enemyType == 0:
            eventPlayer.startForcingName("Tier I Rocketeer")
            eventPlayer.setProjectileSpeed(45 if chaosMode else 20 + round(difficulty / 2.01) * 2.5)
            Enemy_Slow_Rocket()
        elif eventPlayer.enemyType == 1:
            eventPlayer.startForcingName("Tier II Rocketeer")
            eventPlayer.setProjectileSpeed(55 if chaosMode else 30 + round(difficulty / 2.01) * 2.5)
            Enemy_Moderate_Rocket()
        elif eventPlayer.enemyType == 2:
            eventPlayer.startForcingName("Tier III Rocketeer")
            eventPlayer.setProjectileSpeed(65 if chaosMode else 40 + round(difficulty / 2.01) * 2.5)
            Enemy_Fast_Rocket()
        elif eventPlayer.enemyType == 3:
            eventPlayer.startForcingName("Displacer")
            eventPlayer.setProjectileSpeed(35 if chaosMode else 14 + round(difficulty / 2.01))
            eventPlayer.setKnockbackDealt(100)
            Enemy_Concussive_Blast()
    elif eventPlayer.getCurrentHero() == Hero.ORISA:
        if getMatchTime() >= roundLength - 15:
            eventPlayer.enemyType = random.randint(0, 1)
        else:
            eventPlayer.enemyType = random.randint(0, 2)
        eventPlayer.bulletsLeft = (5 if chaosMode else 3)
        eventPlayer.setDamageDealt(1000)
        if eventPlayer.enemyType == 0:
            eventPlayer.startForcingName("Tier I Gunner")
            eventPlayer.setProjectileSpeed(10 if chaosMode else 5 + round(difficulty / 2.01) * 0.5)
            Enemy_Moderate_Bullet()
        elif eventPlayer.enemyType == 1:
            eventPlayer.startForcingName("Tier II Gunner")
            eventPlayer.setProjectileSpeed(15 if chaosMode else 10 + round(difficulty / 2.01) * 0.5)
            Enemy_Fast_Bullet()
        elif eventPlayer.enemyType == 2:
            eventPlayer.startForcingName("Piercer")
            eventPlayer.setProjectileSpeed(80 if chaosMode else 20 + round(difficulty / 2.01) * 5)
            eventPlayer.setProjectileGravity(80 if chaosMode else 20 + round(difficulty / 2.01) * 5)
            Enemy_Piercer()
    elif eventPlayer.getCurrentHero() == Hero.MEI:
        eventPlayer.enemyType = 0
        eventPlayer.setMaxAmmo(0, 72 if chaosMode else 48)
        eventPlayer.setAmmo(0, 72 if chaosMode else 48)
        eventPlayer.setDamageDealt(1)
        eventPlayer.startForcingName("Freezer")
        Enemy_Freeze()
    elif eventPlayer.getCurrentHero() == Hero.REINHARDT:
        eventPlayer.enemyType = random.randint(0, 1)
        eventPlayer.disableEnvironmentCollision(false)
        if eventPlayer.enemyType == 0:
            eventPlayer.setDamageDealt(1)
            eventPlayer.startForcingName("Groundbreaker")
            Enemy_Shatter()
        elif eventPlayer.enemyType == 1:
            eventPlayer.setDamageDealt(1)
            eventPlayer.startForcingName("Charger")
            Enemy_Charge()

rule "[Enemies] Dealt Damage":
    @Event playerTookDamage
    @Condition attacker != victim
    @Condition eventDamage >= 100
    
    if not victim.isDummy():
        if victim.usingAbility1REAL == true and victim.a1Choice == 4:
            playEffect(getAllPlayers(), DynamicEffect.BUFF_IMPACT_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 200)
            playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.TEAM_1, eventPlayer.getPosition(), 1)
            victim.ultCharge += 2
        elif victim.usingAbility2REAL == true and victim.a2Choice == 4:
            playEffect(eventPlayer, DynamicEffect.BAPTISTE_BIOTIC_LAUNCHER_EXPLOSION_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 200)
        else:
            playEffect(getAllPlayers(), DynamicEffect.DEBUFF_IMPACT_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 200)
            playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.RED, eventPlayer.getPosition(), 1)
            heal(victim, null, eventDamage)
            victim.lives[0] -= 1
            if victim.lives[0] == 0:
                kill(eventPlayer, null)

rule "[Enemies] Reinhardt Charge Insta-Kill":
    @Event eachPlayer
    @Hero genji
    @Condition distance(eventPlayer, (([player for player in getPlayersOnHero(Hero.REINHARDT, Team.2) if player.enemyType == 1]).getPosition()) + vect(0, 1, 0)) <= 2.5
    @Condition distance(eventPlayer, (([player for player in getPlayersOnHero(Hero.REINHARDT, Team.2) if player.enemyType == 1]).getPosition()) + vect(0, 1, 0)) > 0
    @Condition eventPlayer.hasStatusEffect(Status.PHASED_OUT) != true
    @Condition roundUnderway != false
    
    playEffect(getAllPlayers(), DynamicEffect.DEBUFF_IMPACT_SOUND, Color.TEAM_1, eventPlayer.getPosition(), 200)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.ORANGE, eventPlayer.getPosition(), 2)
    kill(eventPlayer, null)

rule "[Enemies] Orisa Spear Stun":
    @Event playerDealtDamage
    @Hero orisa
    @Condition eventAbility == Button.SECONDARY_FIRE

    victim.setStatusEffect(eventPlayer, Status.STUNNED, 1.5)
                
rule "[Enemies] Random Targeting Offset":
    @Condition roundUnderway != false
    
    targetOffset = vect(false, false, false)
    chase(targetOffset, vect(toX, toY, 0), rate=9999, ChaseReeval.DESTINATION_AND_RATE)
    if chaosMode:
        #MAYBE BELL CURVE
        while getMatchTime() < 9999:
            toX = random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1) + random.uniform(-0.1, 0.1)
            toY = random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05) + random.uniform(-0.05, 0.05)
            wait(1)
    else:
        #MAYBE BELL CURVE
        while getMatchTime() < 9999:
            toX = random.uniform(-2.2 + difficulty * 0.2, 2.2 - difficulty * 0.2) + (random.uniform(-2.2 + difficulty * 0.2, 2.2 - difficulty * 0.2)) + (random.uniform(-2.2 + difficulty * 0.2, 2.2 - difficulty * 0.2)) + (random.uniform(-2.2 + difficulty * 0.2, 2.2 - difficulty * 0.2)) + (random.uniform(-2.2 + difficulty * 0.2, 2.2 - difficulty * 0.2))
            toY = random.uniform(-0.5 + difficulty * 0.05, 0.55 - difficulty * 0.05) + (random.uniform(-0.5 + difficulty * 0.05, 0.55 - difficulty * 0.05)) + (random.uniform(-0.5 + difficulty * 0.05, 0.55 - difficulty * 0.05)) + (random.uniform(-0.5 + difficulty * 0.05, 0.55 - difficulty * 0.05))
            wait(1)